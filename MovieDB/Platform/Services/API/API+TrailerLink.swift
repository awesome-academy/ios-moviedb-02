//
//  API+TrailerLink.swift
//  MovieDB
//
//  Created by cuonghx on 6/16/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation
import ObjectMapper

extension API {
    func getTrailerLink(input: TrailerLinkInput) -> Observable<TrailerlinkOutput> {
        return request(input)
    }
}

extension API {
    final class TrailerLinkInput: APIInputBase {
        init (movieID: Int) {
            super.init(urlString: Urls.moviesURL + "/\(movieID)/videos",
                       parameters: nil,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class TrailerlinkOutput: APIOutputBase {
        private(set) var videos: [Video]?
       
        override func mapping(map: Map) {
            super.mapping(map: map)
            videos <- map["results"]
        }
    }
}
