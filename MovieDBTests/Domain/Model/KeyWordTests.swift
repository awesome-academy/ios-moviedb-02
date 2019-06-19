//
//  KeyWordTests.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class KeyWordTests: XCTestCase {

    func test_Mapping_KeyWord() {
        let json: [String: Any] = [
            "id": 1,
            "name": "bar"
        ]
        let keyword = KeyWord(JSON: json)
        XCTAssertNotNil(keyword)
        XCTAssertEqual(keyword?.id, json["id"] as? Int)
        XCTAssertEqual(keyword?.name, json["name"] as? String)
    }
    
}
