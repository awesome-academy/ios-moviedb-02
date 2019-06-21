//
//  UpcomingListViewModel.swift
//  MovieDB
//
//  Created by cuonghx on 6/20/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

typealias UpcomingMovieSection = SectionModel<String, UpcomingViewModel>

struct UpcomingListViewModel {
    var navigation: UpcomingListNavigatorType
    var usecase: UpcomingListUseCaseType
}

extension UpcomingListViewModel: ViewModelType {
    struct Input {
        var loadTrigger: Driver<Void>
        var refreshTrigger: Driver<Void>
        var loadMoreTrigger: Driver<Void>
        var selection: Driver<IndexPath>
    }
    
    struct Output {
        var movieList: Driver<[UpcomingMovieSection]>
        var loading: Driver<Bool>
        var refreshing: Driver<Bool>
        var error: Driver<Error>
        var loadingMore: Driver<Bool>
        var fetchItems: Driver<Void>
        var isEmptyData: Driver<Bool>
        var selectedItem: Driver<Movie>
    }
    
    func transform(_ input: Input) -> Output {
        let loadMore = setupLoadMorePaging(loadTrigger: input.loadTrigger,
                                           getItems: usecase.getMoviesList,
                                           refreshTrigger: input.refreshTrigger,
                                           refreshItems: usecase.getMoviesList,
                                           loadMoreTrigger: input.loadMoreTrigger,
                                           loadMoreItems: usecase.loadMoreMovies)
        let (page, fetchItems, error, loading, refreshing, loadingMore) = loadMore
        
        let movieList = page.map {
            [UpcomingMovieSection(model: "",
                                  items: $0.items.map {
                                     UpcomingViewModel(movie: $0)
                                  })]
        }
        .asDriverOnErrorJustComplete()
        
        let movies = page
            .map { $0.items }
            .asDriverOnErrorJustComplete()
        
        let selectedItem = input.selection
            .withLatestFrom(movies) { $1[$0.row] }
            .do(onNext: { movie in
                self.navigation.toDetailVC(movie: movie)
            })
        
        let isEmptyData = checkIfDataIsEmpty(fetchItemsTrigger: fetchItems,
                                             loadTrigger: Driver.merge(loading, refreshing),
                                             items: movieList)
        return Output(movieList: movieList,
                      loading: loading,
                      refreshing: refreshing,
                      error: error,
                      loadingMore: loadingMore,
                      fetchItems: fetchItems,
                      isEmptyData: isEmptyData,
                      selectedItem: selectedItem)
    }
}
