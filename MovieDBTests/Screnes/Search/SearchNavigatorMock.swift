//
//  SearchNavigatorMock.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class SearchNavigatorMock: SearchNavigatorType {
    
    var expectToDetailCalled: XCTestExpectation!
    var movieID: Int!
    
    func toDetailScreen(movie: Movie) {
        expectToDetailCalled.fulfill()
        movieID = movie.id
    }
}
