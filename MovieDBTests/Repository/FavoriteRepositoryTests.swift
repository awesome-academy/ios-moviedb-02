//
//  FavoriteRepositoryTests.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/25/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest
import RealmSwift

@testable import MovieDB

// swiftlint:disable force_try
final class FavoriteRepositoryTests: XCTestCase {
    
    var repository: FavoriteRepositoryType!
    
    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        repository = FavoriteRepository()
    }
    
    func test_add_movieToFavorite() {
        
        _ = repository.add(Movie().with { $0.id = 1 })

        let movies = try! repository.getAll().toBlocking().first()
        
        XCTAssert(movies?.count == 1)
        XCTAssert(repository.checkItemExist(Movie().with { $0.id = 1 }))
    }
    
    func test_deleted_movieFromFavorite() {
        
        _ = repository.delete(Movie().with { $0.id = 1 })
        
        let movies = try! repository.getAll().toBlocking().first()
    
        XCTAssertEqual(movies?.count, 0)
    }
    
}
