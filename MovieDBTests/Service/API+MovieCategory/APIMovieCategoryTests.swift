//
//  APIMovieCategoryTests.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest
import Mockingjay
import RxBlocking

@testable import MovieDB

// swiftlint:disable force_try
final class APIMovieCategoryTests: XCTestCase {
    
    let movieURL = API.Urls.moviesURL
    let queries = "?api_key=7345489e9522a18a9b84bbc90f4d7758&page=1"
    
    func test_APIMoviePopular_Success() {
        // arrange
        let output: API.GetMovieListOutput?
        let data = loadStub(name: "popular", extension: "json")
        let stubURL = movieURL + "/popular" + queries
        
        // act
        stub(uri(stubURL), jsonData(data as Data))
        let input = API.GetMovieListInput(categoryType: CategoryType.popular,
                                          page: 1)
        output = try! API.shared.getMovieList(input: input).toBlocking().first()
        
        // assert
        XCTAssertNotNil(output?.movies)
        XCTAssertTrue(output?.movies?.first?.id == 320_288)
        XCTAssertTrue(output?.movies?.first?.title == "Dark Phoenix")
    }
    
    func test_APIMovieUpComing_Success() {
        // arrange
        let output: API.GetMovieListOutput?
        let data = loadStub(name: "upcoming", extension: "json")
        let stubURL = movieURL + "/upcoming" + queries
        
        // act
        stub(uri(stubURL), jsonData(data as Data))
        let input = API.GetMovieListInput(categoryType: .upcoming,
                                          page: 1)
        output = try! API.shared.getMovieList(input: input).toBlocking().first()
        
        // assert
        XCTAssertNotNil(output?.movies)
        XCTAssertTrue(output?.movies?.first?.id == 320_288)
        XCTAssertTrue(output?.movies?.first?.title == "Dark Phoenix")
    }
    
    func test_APIMoviePopular_Error_404() {
        // arrange
        let error = NSError(domain: "404 Not Found", code: 404, userInfo: nil)
        let stubURL = movieURL + "/popular" + queries
        
        // act
        stub(uri(stubURL), failure(error))
        let input = API.GetMovieListInput(categoryType: CategoryType.popular,
                                          page: 1)
        
        // assert
        XCTAssertThrowsError(try API.shared.getMovieList(input: input)
            .toBlocking()
            .first())
    }
    
    func test_APIMoviePopular_Error_500() {
        // arrange
        let error = NSError(domain: "500 Internal Server Error", code: 500, userInfo: nil)
        let stubURL = movieURL + "/popular" + queries
        
        // act
        stub(uri(stubURL), failure(error))
        let input = API.GetMovieListInput(categoryType: CategoryType.popular,
                                          page: 1)
        
        // assert
        XCTAssertThrowsError(try API.shared.getMovieList(input: input)
            .toBlocking()
            .first())
    }

}
