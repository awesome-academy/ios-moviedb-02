//
//  Company.swift
//  MovieDB
//
//  Created by cuonghx on 6/17/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper

struct Company {
    var id: Int
    var logoPath: String
    var name: String
}

extension Company {
    init() {
        self.init(id: 0,
                  logoPath: "",
                  name: "")
    }
}

extension Company: Mappable {
    
    init?(map: Map) { self.init() }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        logoPath <- map["logo_path"]
        name <- map["name"]
    }
}
