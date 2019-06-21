//
//  DetailRepository.swift
//  Project2
//
//  Created by cuonghx on 6/16/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

protocol DetailRepositoryType {
    func getTrailerLink(movieID: Int) -> Observable<String>
    func getActorList(movieID: Int) -> Observable<[Actor]>
    func getProductionCompanyList(movieID: Int) -> Observable<[Company]>
}

struct DetailRepository: DetailRepositoryType {
    
    func getTrailerLink(movieID: Int) -> Observable<String> {
        let input = API.TrailerLinkInput(movieID: movieID)
        return API.shared
            .getTrailerLink(input: input)
            .flatMapLatest { output -> Observable<String> in
                guard let videos = output.videos else {
                    throw APIInvalidResponseError()
                }
                for video in videos where video.type == "Trailer" {
                    return Observable.just(video.key)
                }
                throw ErrorTrailerLinkNotFound()
            }
    }
    
    func getActorList(movieID: Int) -> Observable<[Actor]> {
        let input = API.GetActorListInput(movieID: movieID)
        return API.shared
            .getActorList(input: input)
            .map { output in
                guard let actors = output.actors else {
                    throw APIInvalidResponseError()
                }
                return actors
            }
    }
    
    func getProductionCompanyList(movieID: Int) -> Observable<[Company]> {
        let input = API.GetCompanyListInput(movieID: movieID)
        return API.shared
            .getCompanyList(input: input)
            .map { output in
                guard let companies = output.companyList else {
                    throw APIInvalidResponseError()
                }
                return companies
            }
    }
}
