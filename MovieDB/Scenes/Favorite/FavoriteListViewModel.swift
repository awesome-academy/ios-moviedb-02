//
//  FavoriteViewModel.swift
//  MovieDB
//
//  Created by cuonghx on 6/23/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

typealias FavoriteMovieSection = AnimatableSectionModel<String, FavoriteViewModel>

struct FavoriteListViewModel {
    var usecase: FavoriteListUseCaseType
    var navigator: FavoriteListNavigatorType
}

extension FavoriteListViewModel: ViewModelType {
    struct Input {
        var selection: Driver<IndexPath>
        var deletion: Driver<IndexPath>
        var loadTrigger: Driver<Void>
    }
    
    struct Output {
        var movieList: Driver<[FavoriteMovieSection]>
        var deletedMovie: Driver<Bool>
        var selectedMovie: Driver<Movie>
    }
    
    func transform(_ input: Input) -> Output {
        
        let movies = input.loadTrigger
            .flatMapLatest {
                self.usecase.getMovieList()
                    .asDriverOnErrorJustComplete()
            }
        
        let moviesList = movies
            .map { movies  in
                [FavoriteMovieSection(model: "",
                                      items: movies.map {
                                         FavoriteViewModel(movie: $0)
                                      })]
            }
        
        let deletedMovie = input.deletion
            .withLatestFrom(movies) {
                $1[$0.row]
            }
            .flatMapLatest {
                self.navigator.showAlertDelete(movie: $0)
                    .asDriverOnErrorJustComplete()
            }
            .flatMapLatest {
                self.usecase.deleteMovie(movie: $0)
                    .asDriverOnErrorJustComplete()
            }
        
        let selectedMovie = input.selection
            .withLatestFrom(movies) {
                $1[$0.row]
            }
            .do(onNext: { movie in
                self.navigator.toDetailScene(movie: movie)
            })
        
        return Output(movieList: moviesList,
                      deletedMovie: deletedMovie,
                      selectedMovie: selectedMovie)
    }
}

