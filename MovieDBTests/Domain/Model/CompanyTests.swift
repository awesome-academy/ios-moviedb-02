//
//  CompanyTests.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class CompanyTests: XCTestCase {
    
    func test_Mapping_Company() {
        let json: [String: Any] = [
            "id": 1,
            "logo_path": "FooooBarrr",
            "name": "bar"
        ]
        let company = Company(JSON: json)
        XCTAssertNotNil(company)
        XCTAssertEqual(company?.id, json["id"] as? Int)
        XCTAssertEqual(company?.logoPath, json["logo_path"] as? String)
        XCTAssertEqual(company?.name, json["name"] as? String)
    }
    
}
