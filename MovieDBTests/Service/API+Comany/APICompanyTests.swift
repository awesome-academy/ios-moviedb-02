//
//  APICompanyTests.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest
import Mockingjay

@testable import MovieDB

// swiftlint:disable force_try
final class APICompanyTests: XCTestCase {
    
    var queries = "?api_key=7345489e9522a18a9b84bbc90f4d7758"
    var moviesURL = API.Urls.moviesURL
    
    func test_APICompany_Success() {
        // arranger
        let output: API.GetCompanyListOutput?
        let data = loadStub(name: "company", extension: "json")
        let stubURL = moviesURL + "/157336" + queries
        
        // act
        stub(uri(stubURL), jsonData(data as Data))
        let input = API.GetCompanyListInput(movieID: 157_336)
        output = try! API.shared.getCompanyList(input: input).toBlocking().first()
        
        // assert
        XCTAssertNotNil(output?.companyList)
        XCTAssertTrue(output?.companyList?.first?.id == 923)
    }
}
