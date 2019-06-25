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
    func searchMovie(param: (String, [IndexPath])) -> Observable<PagingInfo<Movie>>
    func loadMoreMovie(param: (String, [IndexPath]), page: Int) -> Observable<PagingInfo<Movie>>
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
    
    func searchMovie(param: (String, [IndexPath])) -> Observable<PagingInfo<Movie>> {
        return loadMoreMovie(param: param, page: 1)
    }
    
    func loadMoreMovie(param: (String, [IndexPath]), page: Int) -> Observable<PagingInfo<Movie>> {
        let (keyword, listSelectedGenres) = param
        let genres = getGenresID(indexList: listSelectedGenres)
        if keyword.isEmpty {
            return movieRepo.getMovieList(category: .popular, page: page)
                .map { pageInfo in
                    let movies = pageInfo.items
                        .filter {
                            genres.isEmpty || !Set($0.genres).isDisjoint(with: genres)
                        }
                    return PagingInfo<Movie>(page: page, items: movies)
                }
        }
        return searchRepo.searchMovie(keyword: keyword,
                                      genres: genres,
                                      page: page)
    }
    
    private func getGenresID(indexList: [IndexPath]) -> [Int] {
        return indexList.map {
            Array(Constants.genres.keys)[$0.row]
        }
    }
}
