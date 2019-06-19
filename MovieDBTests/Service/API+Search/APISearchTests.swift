//
//  APISearchTests.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/19/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest
import Mockingjay

@testable import MovieDB

// swiftlint:disable force_try
final class APISearchTests: XCTestCase {
    
    var searchQueryURL = API.Urls.searchMovieQuery
    var searchGenresURL = API.Urls.searchMovieGenres
    var queries = "?page=1&query=fast&api_key=7345489e9522a18a9b84bbc90f4d7758"
    let queriesGenres = "?with_genres=28&page=1&api_key=7345489e9522a18a9b84bbc90f4d7758"
    
    func test_APISearchByQuery_Success() {
        // arranger
        let output: API.GetMovieByKeywordOutput?
        let data = loadStub(name: "searchQuery", extension: "json")
        let stubURL = searchQueryURL + queries
        
        // act
        stub(uri(stubURL), jsonData(data as Data))
        let input = API.GetMovieByKeywordInput(query: "fast",
                                               page: 1)
        output = try! API.shared.getMovieByKeyword(input: input).toBlocking().first()
        
        // assert
        XCTAssertNotNil(output?.movies)
        XCTAssertTrue(output?.movies?.first?.id == 450_487)
    }
    
    func test_APISearchByGenres_Success() {
        // arranger
        let output: API.GetMovieByGenresOutput?
        let data = loadStub(name: "searchGenres", extension: "json")
        let stubURL = searchGenresURL + queriesGenres
        
        // act
        stub(uri(stubURL), jsonData(data as Data))
        let input = API.GetMovieByGenresInput(genre: 28,
                                              page: 1)
        output = try! API.shared.getMovieByGenres(input: input).toBlocking().first()
        
        // assert
        XCTAssertNotNil(output?.movies)
        XCTAssertTrue(output?.movies?.first?.id == 320_288)
    }
}
