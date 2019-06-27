//
//  FavoriteListNavigatorMock.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/24/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class FavoriteListNavigatorMock: FavoriteListNavigatorType {
    
    var expectShowAlertDelgate: XCTestExpectation?
    var expectToDetail: XCTestExpectation?
    
    var showAlertDelegateReturn: Observable<Movie> = {
        let movie = Movie().with { $0.id = 1 }
        return Observable.just(movie)
    }()
    
    func showAlertDelete(movie: Movie) -> Observable<Movie> {
        expectShowAlertDelgate?.fulfill()
        return showAlertDelegateReturn
    }
    
    func toDetailScene(movie: Movie) {
        expectToDetail?.fulfill()
    }
}
