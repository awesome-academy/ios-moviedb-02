//
//  API+TrailerLinkTest.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest
import Mockingjay
@testable import MovieDB

// swiftlint:disable force_try
final class API_TrailerLinkTest: XCTestCase {
    
    var moviesURL = API.Urls.moviesURL
    var queries = "?api_key=7345489e9522a18a9b84bbc90f4d7758"
    
    func test_APITrailerLink_Success() {
        // arranger
        let output: API.TrailerlinkOutput?
        let data = loadStub(name: "trailerLink", extension: "json")
        let stubURL = moviesURL + "/301528/videos" + queries
        
        // act
        stub(uri(stubURL), jsonData(data as Data))
        let input = API.TrailerLinkInput(movieID: 301_528)
        output = try! API.shared.getTrailerLink(input: input).toBlocking().first()
        
        // assert
        XCTAssertNotNil(output?.videos)
        XCTAssertTrue(output?.videos?.first?.key == "LDXYRzerjzU" )
    }
}
