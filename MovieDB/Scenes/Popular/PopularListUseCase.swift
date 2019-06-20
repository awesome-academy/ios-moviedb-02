//
//  PopularUseCase.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

protocol PopularListUseCaseType {
    func getMoviesList() -> Observable<PagingInfo<Movie>>
    func loadMoreMovies(page: Int) -> Observable<PagingInfo<Movie>>
}

struct PopularListUseCase: PopularListUseCaseType {
    var movieRepo: MovieRepositoryType
    
    func loadMoreMovies(page: Int) -> Observable<PagingInfo<Movie>> {
        return movieRepo.getMovieList(category: .popular,
                                      page: page)
    }
    
    func getMoviesList() -> Observable<PagingInfo<Movie>> {
        return loadMoreMovies(page: 1)
    }
}
