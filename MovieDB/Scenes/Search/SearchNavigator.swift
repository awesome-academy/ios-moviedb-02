//
//  SearchNavigator.swift
//  MovieDB
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

protocol SearchNavigatorType {
    func toDetailScreen(movie: Movie)
}

struct SearchNavigator: SearchNavigatorType {
    var assembler: Assembler
    var navigator: UINavigationController
    
    func toDetailScreen(movie: Movie) {
        let detailVC: DetailViewController = assembler.resolve(navigation: navigator,
                                                               movie: movie)
        navigator.pushViewController(detailVC,
                                     animated: true)
    }
}
