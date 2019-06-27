//
//  FavoriteListUseCaseMock.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/24/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class FavoriteListUseCaseMock: FavoriteListUseCaseType {
    
    var expectationGetMovieListCalled: XCTestExpectation?
    var expectationDeleteMovieCalled: XCTestExpectation?
    
    var movieReturn: Observable<[Movie]> = {
        let movie = Movie().with { $0.id = 1 }
        return Observable.just([movie])
    }()
    
    func getMovieList() -> Observable<[Movie]> {
        expectationGetMovieListCalled?.fulfill()
        return movieReturn
    }
    
    func deleteMovie(movie: Movie) -> Observable<Bool> {
        expectationDeleteMovieCalled?.fulfill()
        return .empty()
    }
}
