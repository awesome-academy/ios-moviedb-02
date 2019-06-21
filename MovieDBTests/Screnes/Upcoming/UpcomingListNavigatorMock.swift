//
//  UpcomingListNavigatorMock.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class UpcomingListNavigatorMock: UpcomingListNavigatorType {
    
    var expectationToDetailCalled: XCTestExpectation!
    
    func toDetailVC(movie: Movie) {
        expectationToDetailCalled.fulfill()
    }
}
