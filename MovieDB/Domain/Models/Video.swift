//
//  Video.swift
//  MovieDB
//
//  Created by cuonghx on 6/16/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper

struct Video {
    var key: String
    var type: String
}

extension Video {
    init() {
        self.init(key: "",
                  type: "")
    }
}

extension Video: Mappable {
    
    init?(map: Map) { self.init() }
    
    mutating func mapping(map: Map) {
        key <- map["key"]
        type <- map["type"]
    }
}

