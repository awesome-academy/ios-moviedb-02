//
//  RepositoriesAssembler.swift
//  MovieDB
//
//  Created by cuonghx on 6/1/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import UIKit

protocol RepositoriesAssembler {
    func resolve() -> MovieRepositoryType
    func resolve() -> DetailRepositoryType
    func resolve() -> SearchRepositoryType
    func resolve() -> FavoriteRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> MovieRepositoryType {
        return MovieRepository()
    }
    
    func resolve() -> DetailRepositoryType {
        return DetailRepository()
    }
    
    func resolve() -> SearchRepositoryType {
        return SearchRepository()
    }
    
    func resolve() -> FavoriteRepositoryType {
        return FavoriteRepository()
    }
}
