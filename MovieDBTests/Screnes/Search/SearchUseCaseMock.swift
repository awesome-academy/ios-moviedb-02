//
//  SearchUseCaseMock.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class SearchUseCaseMock: SearchUseCaseType {
    
    var movieListReturn: Observable<PagingInfo<Movie>> = {
        let movie = Movie().with { $0.id = 1 }
        let page = PagingInfo<Movie> (page: 1,
                                      items: [movie])
        return Observable.just(page)
    }()
    var getMovieListCalled: XCTestExpectation?
    var loadMoreMovieListCalled: XCTestExpectation?
    
    func searchMovie(param: (String, [IndexPath])) -> Observable<PagingInfo<Movie>> {
        getMovieListCalled?.fulfill()
        return loadMoreMovie(param: param, page: 1)
    }
    
    func loadMoreMovie(param: (String, [IndexPath]), page: Int) -> Observable<PagingInfo<Movie>> {
        loadMoreMovieListCalled?.fulfill()
        return movieListReturn
    }
    
    func getListGenres() -> Observable<[GenreModel]> {
        let genreList = Constants.genres
            .map {
                GenreModel(name: $0.value, id: $0.key)
            }
        return Observable.just(genreList)
    }
}

