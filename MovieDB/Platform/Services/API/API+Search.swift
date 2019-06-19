//
//  API+SearchKeyWord.swift
//  MovieDB
//
//  Created by cuonghx on 6/17/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper

extension API {
    func getMovieByKeyword(input: GetMovieByKeywordInput) -> Observable<GetMovieByKeywordOutput> {
        return request(input)
    }
    
    func getMovieByGenres(input: GetMovieByGenresInput) -> Observable<GetMovieByGenresOutput> {
        return request(input)
    }
}

extension API {
    final class GetMovieByKeywordInput: APIInputBase {
        init(query: String, page: Int) {
            let params: [String: Any] = [
                "query": query,
                "page": page
            ]
            super.init(urlString: Urls.searchMovieQuery,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetMovieByKeywordOutput: APIOutputBase {
        private(set) var movies: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movies <- map["results"]
        }
    }
    
    final class GetMovieByGenresInput: APIInputBase {
        init(genre: Int, page: Int) {
            let params: [String: Any] = [
                "with_genres": genre,
                "page": page
            ]
            super.init(urlString: Urls.searchMovieGenres,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetMovieByGenresOutput: APIOutputBase {
        private(set) var movies: [Movie]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            movies <- map["results"]
        }
    }
}
