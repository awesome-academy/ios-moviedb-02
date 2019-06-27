//
//  DetailUseCase.swift
//  Project2
//
//  Created by cuonghx on 6/15/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

protocol DetailUseCaseType {
    func getTrailerLink(movieID: Int) -> Observable<String>
    func getActorList(movieID: Int) -> Observable<[Actor]>
    func getProductionCompanyList(movieID: Int) -> Observable<[Company]>
    func getStatusMovie(movie: Movie) -> Bool
    func toggleFavorite(movie: Movie) -> Observable<Bool>
}

struct DetailUseCase: DetailUseCaseType {
    
    var detailRepo: DetailRepositoryType
    var favoriteRepo: FavoriteRepositoryType
    
    func getTrailerLink(movieID: Int) -> Observable<String> {
        return detailRepo.getTrailerLink(movieID: movieID)
    }
    
    func getActorList(movieID: Int) -> Observable<[Actor]> {
        return detailRepo.getActorList(movieID: movieID)
    }
    
    func getProductionCompanyList(movieID: Int) -> Observable<[Company]> {
        return detailRepo.getProductionCompanyList(movieID: movieID)
    }
    
    func getStatusMovie(movie: Movie) -> Bool {
        return favoriteRepo.checkItemExist(movie)
    }
    
    func toggleFavorite(movie: Movie) -> Observable<Bool> {
        if favoriteRepo.checkItemExist(movie) {
            return favoriteRepo.delete(movie)
        }
        return favoriteRepo.add(movie)
            .map { _ in true }
    }
}
