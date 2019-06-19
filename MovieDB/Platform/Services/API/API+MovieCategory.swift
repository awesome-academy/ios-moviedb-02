//
//  API+MovieCategory.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper

extension API {
    func getMovieList(input: GetMovieListInput) ->
        Observable<GetMovieListOutput> {
        return request(input)
    }
}

extension API {
    final class GetMovieListInput: APIInput {
        init(categoryType: CategoryType, page: Int) {
            let params: [String: Any] = [
                "page": page
            ]
            super.init(urlString: API.Urls.moviesURL + categoryType.rawValue,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetMovieListOutput: APIOutput {
        private(set) var movies: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movies <- map["results"]
        }
    }
}
