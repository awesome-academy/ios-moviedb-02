//
//  DetailUseCaseMock.swift
//  MovieDBTests
//
//  Created by cuonghx on 6/20/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

@testable import MovieDB

final class DetailUseCaseMock: DetailUseCaseType {
    
    // MARK: - Properties
    var trailerLinkReturn: Observable<String> = {
        return Observable.just("Foo")
    }()
    
    var listActorReturn: Observable<[Actor]> = {
        return Observable.just([Actor()])
    }()
    
    var listProductionCompanyReturn: Observable<[Company]> = {
        return Observable.just([Company()])
    }()
    
    var getTrailerLinkCalled = false
    var getActorListCalled = false
    var getProductCompany = false
    var toggleFavoriteCalled = false
    var movieID: Int?
    
    // MARK: - Methods
    func getTrailerLink(movieID: Int) -> Observable<String> {
        self.movieID = movieID
        getTrailerLinkCalled = true
        return trailerLinkReturn
    }
    
    func getActorList(movieID: Int) -> Observable<[Actor]> {
        self.movieID = movieID
        getActorListCalled = true
        return listActorReturn
    }
    
    func getProductionCompanyList(movieID: Int) -> Observable<[Company]> {
        self.movieID = movieID
        getProductCompany = true
        return listProductionCompanyReturn
    }
    
    func toggleFavorite(movie: Movie) -> Observable<Void> {
        toggleFavoriteCalled = true
        return .empty()
    }
    
    func trackingFavorite(movie: Movie) -> Observable<Bool> {
        return .empty()
    }
}
