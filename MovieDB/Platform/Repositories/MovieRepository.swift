//
//  MovieRepository.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.

protocol MovieRepositoryType {
    func getMovieList(category: CategoryType,
                      page: Int) -> Observable<PagingInfo<Movie>>
}

final class MovieRepository: MovieRepositoryType {
    func getMovieList(category: CategoryType, page: Int) -> Observable<PagingInfo<Movie>> {
        let input = API.GetMovieListInput(categoryType: category,
                                          page: page)
        return API.shared
            .getMovieList(input: input)
            .map { ouput in
                guard let movies = ouput.movies else {
                    throw APIInvalidResponseError()
                }
                return PagingInfo<Movie>(page: page, items: movies)
            }
    }
}
