//
//  UpcomingListNavigator.swift
//  MovieDB
//
//  Created by cuonghx on 6/20/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

protocol UpcomingListNavigatorType {
    func toDetailVC(movie: Movie)
}

struct UpcomingListNavigator: UpcomingListNavigatorType {
    var assembler: Assembler
    var navigation: UINavigationController
    
    func toDetailVC(movie: Movie) {
        let detailVC: DetailViewController = assembler.resolve(navigation: navigation,
                                                               movie: movie)
        navigation.pushViewController(detailVC, animated: true)
    }
}
