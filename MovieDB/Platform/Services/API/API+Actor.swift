//
//  API+Actor.swift
//  MovieDB
//
//  Created by cuonghx on 6/16/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper

extension API {
    func getActorList(input: GetActorListInput) -> Observable<GetActorListOutput> {
        return request(input)
    }
}

extension API {
    final class GetActorListInput: APIInputBase {
        init(movieID: Int) {
            super.init(urlString: Urls.moviesURL + "/\(movieID)/casts",
                       parameters: nil,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }

    final class GetActorListOutput: APIOutputBase {
        private (set) var actors: [Actor]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            actors <- map["cast"]
        }
    }
}
