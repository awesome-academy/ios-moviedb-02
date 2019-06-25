//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

typealias ResultSearchSection = SectionModel<String, SearchResultModel>

struct SearchViewModel {
    var usecase: SearchUseCaseType
    var navigator: SearchNavigatorType
}

extension SearchViewModel: ViewModelType {
    
    struct Input {
        var loadTrigger: Driver<Void>
        var loadMoreTrigger: Driver<Void>
        var refreshTrigger: Driver<Void>
        var selectionGenre: Driver<[IndexPath]>
        var textSearch: Driver<String>
        var selectionMovie: Driver<IndexPath>
    }
    
    struct Output {
        var fetchItems: Driver<Void>
        var error: Driver<Error>
        var loading: Driver<Bool>
        var refreshing: Driver<Bool>
        var loadingMore: Driver<Bool>
        var movieResult: Driver<[ResultSearchSection]>
        var selectedMovie: Driver<Movie>
        var isEmptyData: Driver<Bool>
        var genresList: Driver<[GenreModel]>
        var gotoTop: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let errorTracker = ErrorTracker()

        let searchText = input.textSearch
            .debounce(0.5)
            .distinctUntilChanged()
        
        let search = searchText
            .withLatestFrom(input.selectionGenre) { ($0, $1) }
            .asObservable()
        
        let getItems: () -> Observable<PagingInfo<Movie>> = {
            return search
                .take(1)
                .flatMapLatest { arg -> Observable<PagingInfo<Movie>> in
                    let (query, selectedItems) = arg
                    let genres = self.usecase.getGenresID(indexList: selectedItems)
                    return self.usecase
                        .searchMovie(keyword: query, genres: genres)
                        .trackError(errorTracker)
                }
        }
        
        let loadMoreItems: (_ page: Int) -> Observable<PagingInfo<Movie>> = { page in
            return search
                .take(1)
                .flatMapLatest { arg -> Observable<PagingInfo<Movie>> in
                    let (query, selectedItems) = arg
                    let genres = self.usecase.getGenresID(indexList: selectedItems)
                    print(genres)
                    return self.usecase
                        .loadMoreMovie(keyword: query, genres: genres, page: page)
                        .trackError(errorTracker)
                }
        }
        
        let loadTrigger = Driver.merge(input.loadTrigger,
                                       searchText.mapToVoid(),
                                       input.selectionGenre.mapToVoid())
        
        let loadMore = setupLoadMorePaging(loadTrigger: loadTrigger,
                                           getItems: getItems,
                                           refreshTrigger: input.refreshTrigger,
                                           refreshItems: getItems,
                                           loadMoreTrigger: input.loadMoreTrigger,
                                           loadMoreItems: loadMoreItems)
        let ( page, fetchItems, error, loading, refreshing, loadingMore ) = loadMore
        
        let movieResult = page.map {
            [ResultSearchSection(model: "",
                                 items: $0.items.map {
                                    SearchResultModel(movie: $0)
                                 })]
        }
        .asDriverOnErrorJustComplete()
        
        let movie = page
            .map { $0.items }
            .asDriverOnErrorJustComplete()
        
        let selectedMovie = input.selectionMovie
            .withLatestFrom(movie) { $1[$0.row] }
            .do(onNext: { movie in
                self.navigator.toDetailScreen(movie: movie)
            })
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading,
                                                                       refreshing),
                                             items: movie)
        let genresList = input.loadTrigger
            .flatMapLatest {
                self.usecase
                    .getListGenres()
                    .asDriverOnErrorJustComplete()
            }
        
        return Output(fetchItems: fetchItems,
                      error: Driver.merge(error, errorTracker.asDriver()),
                      loading: loading,
                      refreshing: refreshing,
                      loadingMore: loadingMore,
                      movieResult: movieResult,
                      selectedMovie: selectedMovie,
                      isEmptyData: isEmptyData,
                      genresList: genresList,
                      gotoTop: loadTrigger)
    }
}
