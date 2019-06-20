//
//  PopularListUseCaseMock.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class PopularListUseCaseMock: PopularListUseCaseType {
    
    var getMoviesListCalled: XCTestExpectation!
    var loadMoreMoviesCalled: XCTestExpectation!
    
    var getMovieListReturnValue: Observable<PagingInfo<Movie>> = {
        let items = [
            Movie()
        ]
        let page = PagingInfo<Movie>(page: 1, items: items)
        return Observable.just(page)
    }()
    
    func getMoviesList() -> Observable<PagingInfo<Movie>> {
        if getMoviesListCalled != nil {
            getMoviesListCalled.fulfill()
        }
        return getMovieListReturnValue
    }
    
    func loadMoreMovies(page: Int) -> Observable<PagingInfo<Movie>> {
        loadMoreMoviesCalled.fulfill()
        return getMovieListReturnValue
    }
}
