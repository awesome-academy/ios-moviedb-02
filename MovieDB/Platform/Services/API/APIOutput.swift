//
//  APIOutput.swift
//  MovieDB
//
//  Created by cuonghx on 6/1/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper

// swiftlint:disable final_class
class APIOutput: APIOutputBase {
    var message: String?
    
    override func mapping(map: Map) {
        message <- map["status_message"]
    }
}
