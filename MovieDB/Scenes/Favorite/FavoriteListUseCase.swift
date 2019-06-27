//
//  FavoriteUseCase.swift
//  MovieDB
//
//  Created by cuonghx on 6/23/19.
//  Copyright © 2019 Sun*. All rights reserved.
//
import Foundation

protocol FavoriteListUseCaseType {
    func getMovieList() -> Observable<[Movie]>
    func deleteMovie(movie: Movie) -> Observable<Bool>
}

struct FavoriteListUseCase: FavoriteListUseCaseType {
    
    var favoriteRepo: FavoriteRepositoryType
    
    func getMovieList() -> Observable<[Movie]> {
        return favoriteRepo.getAll()
    }
    
    func deleteMovie(movie: Movie) -> Observable<Bool> {
        return favoriteRepo.delete(movie)
    }
}
