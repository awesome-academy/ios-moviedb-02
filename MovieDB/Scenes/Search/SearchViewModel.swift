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
    }
    
    func transform(_ input: Input) -> Output {
        
        let errorTracker = ErrorTracker()
        
        let loadTrigger = Driver
            .combineLatest(input.textSearch.debounce(0.5).distinctUntilChanged(),
                           input.selectionGenre)
        
        let refreshTrigger = input.refreshTrigger
            .withLatestFrom(loadTrigger)
        
        let loadMoreTrigger = input.loadMoreTrigger
            .withLatestFrom(loadTrigger)
        
        let loadMore = setupLoadMorePagingWithParam(loadTrigger: loadTrigger,
                                                    getItems: usecase.searchMovie,
                                                    refreshTrigger: refreshTrigger,
                                                    refreshItems: usecase.searchMovie,
                                                    loadMoreTrigger: loadMoreTrigger,
                                                    loadMoreItems: usecase.loadMoreMovie)
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
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: movie)
        let genresList = input.loadTrigger
            .flatMapLatest {
                self.usecase.getListGenres()
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
                      genresList: genresList)
    }
}
