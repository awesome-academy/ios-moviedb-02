//
//  DetailViewModel.swift
//  Project2
//
//  Created by cuonghx on 6/15/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

typealias ActorSection = SectionModel<String, ActorViewModel>
typealias CompanySection = SectionModel<String, CompanyViewModel>

struct DetailViewModel {
    var usecase: DetailUseCaseType
    var navigator: DetailNavigatorType
    var movie: Movie
}

extension DetailViewModel: ViewModelType {
    struct Input {
        var loadTrigger: Driver<Void>
    }
    
    struct Output {
        var movie: Driver<Movie>
        var trailerLink: Driver<String>
        var actorList: Driver<[ActorSection]>
        var companyList: Driver<[CompanySection]>
        var error: Driver<Error>
        var loadingTrailer: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let indicatorTrailerLink = ActivityIndicator()
        
        let trailerLink = input.loadTrigger
            .flatMapLatest {
                self.usecase
                    .getTrailerLink(movieID: self.movie.id)
                    .trackError(errorTracker)
                    .trackActivity(indicatorTrailerLink)
                    .asDriverOnErrorJustComplete()
            }
        
        let companyList = input.loadTrigger
            .flatMapLatest {
                self.usecase
                    .getProductionCompanyList(movieID: self.movie.id)
                    .trackError(errorTracker)
                    .map {
                        [CompanySection(model: "",
                                        items: $0.map {
                                            CompanyViewModel(company: $0)
                                        })]
                    }
                    .asDriverOnErrorJustComplete()
            }
        
        let actorList = input.loadTrigger
            .flatMapLatest {
                self.usecase
                    .getActorList(movieID: self.movie.id)
                    .trackError(errorTracker)
                    .map {
                        [ActorSection(model: "",
                                      items: $0.map {
                                          ActorViewModel(actor: $0)
                                      })]
                    }
                    .asDriverOnErrorJustComplete()
            }
        
        return Output(movie: Driver.just(movie),
                      trailerLink: trailerLink,
                      actorList: actorList,
                      companyList: companyList,
                      error: errorTracker.asDriver(),
                      loadingTrailer: indicatorTrailerLink.asDriver())
    }
}
