//
//  Movie.swift
//  MovieDB
//
//  Created by cuonghx on 6/14/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper
import RealmSwift

final class Movie: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var title: String?
    @objc dynamic var overview: String?
    @objc dynamic var genres: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var voteAverage = 0.0
    @objc dynamic var posterPath: String?
    @objc dynamic var addDate = Date()
    
    var genresList: [Int]? {
        didSet {
            genres = genresList?.convertListGenres()
        }
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

extension Movie: Mappable {
    
    convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        overview <- map["overview"]
        genresList <- map["genre_ids"]
        releaseDate <- map["release_date"]
        voteAverage <- map["vote_average"]
        posterPath <- map["poster_path"]
    }
}

extension Movie {
    func clone() -> Movie {
        return Movie(value: self)
    }
}
