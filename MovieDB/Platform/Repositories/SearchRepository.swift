//
//  SearchRepository.swift
//  MovieDB
//
//  Created by cuonghx on 6/17/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

protocol SearchRepositoryType {
    func searchMovie(keyword: String, genres: [Int], page: Int) -> Observable<PagingInfo<Movie>>
}

struct SearchRepository: SearchRepositoryType {
    
    func searchMovie(keyword: String, genres: [Int], page: Int) -> Observable<PagingInfo<Movie>> {
        let input = API.GetMovieByKeywordInput(query: keyword, page: page)
        return API.shared
            .getMovieByKeyword(input: input)
            .map { output in
                guard let movies = output.movies else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Movie>(page: page,
                                         items: movies
                                            .filter { movie in
                                                if genres.isEmpty {
                                                    return true
                                                }
                                                return !Set(movie.genres).isDisjoint(with: genres)
                                            })
            }
    }
}
