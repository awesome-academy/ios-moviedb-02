//
//  SearchUseCase.swift
//  MovieDB
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

protocol SearchUseCaseType {
    func getListGenres() -> Observable<[GenreModel]>
    func getGenresID(indexList: [IndexPath]) -> [Int]
    func searchMovie(keyword: String, genres: [Int]) -> Observable<PagingInfo<Movie>>
    func loadMoreMovie(keyword: String, genres: [Int], page: Int)
        -> Observable<PagingInfo<Movie>>
}

struct SearchUseCase: SearchUseCaseType {
    
    var searchRepo: SearchRepositoryType
    var movieRepo: MovieRepositoryType

    func getListGenres() -> Observable<[GenreModel]> {
        let genreList = Constants.genres
            .map {
                GenreModel(name: $0.value, id: $0.key)
            }
        return Observable.just(genreList)
    }
    
    func getGenresID(indexList: [IndexPath]) -> [Int] {
        return indexList.map {
            Array(Constants.genres.keys)[$0.row]
        }
    }
    
    func searchMovie(keyword: String, genres: [Int]) -> Observable<PagingInfo<Movie>> {
        return loadMoreMovie(keyword: keyword, genres: genres, page: 1)
    }
    
    func loadMoreMovie(keyword: String, genres: [Int], page: Int)
        -> Observable<PagingInfo<Movie>> {
            if keyword.isEmpty {
                return movieRepo.getMovieList(category: .popular, page: page).map { pageInfo in
                    PagingInfo<Movie>(page: page,
                                      items: pageInfo.items
                                        .filter { movie -> Bool in
                                            if genres.isEmpty {
                                                return true
                                            }
                                            return !Set(movie.genres).isDisjoint(with: genres)
                                        })
                }
            }
            return searchRepo.searchMovie(keyword: keyword,
                                          genres: genres,
                                          page: page)
    }
}
