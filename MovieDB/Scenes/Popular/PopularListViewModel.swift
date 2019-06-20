//
//  PopularViewModel.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

typealias PopularMovieSection = SectionModel<String, PopularViewModel>

struct PopularListViewModel {
    var navigator: PopularListNavigatorType
    var usecase: PopularListUseCaseType
}

extension PopularListViewModel: ViewModelType {
    struct Input {
        var loadTrigger: Driver<Void>
        var refreshTrigger: Driver<Void>
        var loadMoreTrigger: Driver<Void>
        var selection: Driver<IndexPath>
    }
    
    struct Output {
        var error: Driver<Error>
        var loading: Driver<Bool>
        var refreshing: Driver<Bool>
        var loadingMore: Driver<Bool>
        var movieList: Driver<[PopularMovieSection]>
        var fetchItems: Driver<Void>
        var selectedItems: Driver<Movie>
        var isEmptyData: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let loadMoreOutput = setupLoadMorePaging(loadTrigger: input.loadTrigger,
                                                 getItems: usecase.getMoviesList,
                                                 refreshTrigger: input.refreshTrigger,
                                                 refreshItems: usecase.getMoviesList,
                                                 loadMoreTrigger: input.loadMoreTrigger,
                                                 loadMoreItems: usecase.loadMoreMovies)
        let (page, fetchItems, error, loading, refreshing, loadingMore) = loadMoreOutput
        
        let movieList = page.map {
            [PopularMovieSection(model: "",
                                 items: $0.items.map {
                                    PopularViewModel(movie: $0)
                                 })]
        }
        .asDriverOnErrorJustComplete()
        
        let movies = page
            .map { $0.items }
            .asDriverOnErrorJustComplete()
        
        let selectedItem = input.selection
            .withLatestFrom(movies) { $1[$0.row] }
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: movieList)
        return Output(error: error,
                      loading: loading,
                      refreshing: refreshing,
                      loadingMore: loadingMore,
                      movieList: movieList,
                      fetchItems: fetchItems,
                      selectedItems: selectedItem,
                      isEmptyData: isEmptyData)
    }
}
