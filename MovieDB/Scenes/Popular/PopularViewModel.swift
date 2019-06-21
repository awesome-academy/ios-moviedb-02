//
//  PopularViewModel.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

struct PopularViewModel {
    let movie: Movie
}

extension PopularViewModel: MovieModelType {
    var id: Int {
        return movie.id
    }
    
    var title: String {
        return movie.title
    }
    
    var genres: String {
        return movie.genres.convertListGenres()
    }
    
    var overview: String {
        return movie.overview
    }
    
    var voteAverage: Double {
        return movie.voteAverage / 2
    }
    
    var posterPath: String {
        return movie.posterPath
    }
    
    var releaseDate: String {
        return movie.releaseDate
    }
}
