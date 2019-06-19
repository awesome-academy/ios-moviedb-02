//
//  MovieTests.swift
//  Project2Tests
//
//  Created by cuonghx on 6/14/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import XCTest

@testable import MovieDB

final class MovieTests: XCTestCase {
    
    func test_Mapping_Movie() {
        let json: [String: Any] = [
            "id": 1,
            "vote_average": 6.2,
            "title": "foo",
            "poster_path": "bar",
            "genre_ids": [
                878,
                28
            ],
            "backdrop_path": "foo-bar",
            "overview": "fooo",
            "release_date": "2019"
        ]
        let movie = Movie(JSON: json)
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie?.id, json["id"] as? Int)
        XCTAssertEqual(movie?.voteAverage, json["vote_average"] as? Double)
        XCTAssertEqual(movie?.title, json["title"] as? String)
        XCTAssertEqual(movie?.posterPath, json["poster_path"] as? String)
        XCTAssertEqual(movie?.backdropPath, json["backdrop_path"] as? String)
        XCTAssertEqual(movie?.overview, json["overview"] as? String)
        XCTAssertEqual(movie?.releaseDate, json["release_date"] as? String)
        XCTAssertEqual(movie?.genres, json["genre_ids"] as? [Int])
    }
    
}
