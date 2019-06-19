//
//  APIActorTests.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest
import Mockingjay

@testable import MovieDB

// swiftlint:disable force_try
final class APIActorTests: XCTestCase {
    
    var moviesURL = API.Urls.moviesURL
    var queries = "?api_key=7345489e9522a18a9b84bbc90f4d7758"
    
    func test_APIActor_Success() {
        // arranger
        let output: API.GetActorListOutput?
        let data = loadStub(name: "actor", extension: "json")
        let stubURL = moviesURL + "/320288/casts" + queries
        
        // act
        stub(uri(stubURL), jsonData(data as Data))
        let input = API.GetActorListInput(movieID: 320_288)
        output = try! API.shared.getActorList(input: input).toBlocking().first()
        
        // assert
        XCTAssertNotNil(output?.actors)
        XCTAssertTrue(output?.actors?.first?.id == 4)
    }
}
