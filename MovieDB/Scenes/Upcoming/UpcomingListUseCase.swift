//
//  UpcomingListUsecase.swift
//  MovieDB
//
//  Created by cuonghx on 6/20/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

protocol UpcomingListUseCaseType {
    func getMoviesList() -> Observable<PagingInfo<Movie>>
    func loadMoreMovies(page: Int) -> Observable<PagingInfo<Movie>>
}

struct UpcomingListUseCase: UpcomingListUseCaseType {
    
    var movieRepo: MovieRepositoryType
    
    func getMoviesList() -> Observable<PagingInfo<Movie>> {
        return loadMoreMovies(page: 1)
    }
    
    func loadMoreMovies(page: Int) -> Observable<PagingInfo<Movie>> {
        return movieRepo.getMovieList(category: .upcoming,
                                      page: page)
    }
}
