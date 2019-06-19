//
//  Actor.swift
//  MovieDB
//
//  Created by cuonghx on 6/16/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper

struct Actor {
    var character: String
    var name: String
    var profilePath: String
    var id: Int
}

extension Actor {
    init() {
        self.init(character: "",
                  name: "",
                  profilePath: "",
                  id: 0)
    }
}

extension Actor: Mappable {
    
    init?(map: Map) { self.init() }
    
    mutating func mapping(map: Map) {
        character <- map["character"]
        name <- map["name"]
        profilePath <- map["profile_path"]
        id <- map["cast_id"]
    }
}
