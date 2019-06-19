//
//  VideoTests.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class VideoTests: XCTestCase {
    
    func test_Mapping_Video() {
        let json: [String: Any] = [
            "key": "Foo",
            "type": "Bar"
        ]
        let video = Video(JSON: json)
        XCTAssertNotNil(video)
        XCTAssertEqual(video?.key, json["key"] as? String)
        XCTAssertEqual(video?.type, json["type"] as? String)
    }
    
}
