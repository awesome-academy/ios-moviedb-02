//
//  ActorTests.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class ActorTests: XCTestCase {
    
    func test_Mapping_Actor() {
        let json: [String: Any] = [
            "cast_id": 1,
            "character": "FooooBarrr",
            "profile_path": "foo",
            "name": "bar"
        ]
        let actor = Actor(JSON: json)
        XCTAssertNotNil(actor)
        XCTAssertEqual(actor?.id, json["cast_id"] as? Int)
        XCTAssertEqual(actor?.character, json["character"] as? String)
        XCTAssertEqual(actor?.profilePath, json["profile_path"] as? String)
        XCTAssertEqual(actor?.name, json["name"] as? String)
    }
    
}
