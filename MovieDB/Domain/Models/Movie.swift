//
//  Movie.swift
//  MovieDB
//
//  Created by cuonghx on 6/14/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper

struct Movie {
    var id: Int
    var title: String
    var overview: String
    var genres: [Int]
    var releaseDate: String
    var voteAverage: Double
    var posterPath: String
    var backdropPath: String
}

extension Movie {
    init() {
        self.init(id: 0,
                  title: "",
                  overview: "",
                  genres: [],
                  releaseDate: "",
                  voteAverage: 0.0,
                  posterPath: "",
                  backdropPath: "")
    }
}

extension Movie: Mappable {
    
    init?(map: Map) { self.init() }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        overview <- map["overview"]
        genres <- map["genre_ids"]
        releaseDate <- map["release_date"]
        voteAverage <- map["vote_average"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
    }
}
