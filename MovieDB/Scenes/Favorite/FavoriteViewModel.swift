//
//  FavoriteViewModel.swift
//  MovieDB
//
//  Created by cuonghx on 6/24/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

struct FavoriteViewModel {
    let movie: Movie
}

extension FavoriteViewModel: MovieModelType {
    
    var id: Int {
        return movie.id
    }
    
    var title: String? {
        return movie.title
    }
    
    var genres: String {
        return movie.genres ?? ""
    }
    
    var overview: String? {
        return movie.overview
    }
    
    var voteAverage: Double {
        return movie.voteAverage / 2
    }
    
    var posterPath: String? {
        return movie.posterPath
    }
    
    var releaseDate: String? {
        return movie.releaseDate
    }
}

extension FavoriteViewModel: IdentifiableType, Equatable {
    
    var identity: Int {
        return id
    }
    
    static func == (lhs: FavoriteViewModel, rhs: FavoriteViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
