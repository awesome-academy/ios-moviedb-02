//
//  Keyword.swift
//  MovieDB
//
//  Created by cuonghx on 6/17/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper

struct KeyWord {
    var id: Int
    var name: String
}

extension KeyWord {
    init() {
        self.init(id: 0,
                  name: "")
    }
}

extension KeyWord: Mappable {
    
    init?(map: Map) { self.init() }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
