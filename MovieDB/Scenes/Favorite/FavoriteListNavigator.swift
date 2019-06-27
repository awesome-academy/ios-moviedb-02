//
//  FavoriteNavigator.swift
//  MovieDB
//
//  Created by cuonghx on 6/23/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

protocol FavoriteListNavigatorType {
    func showAlertDelete(movie: Movie) -> Observable<Movie>
    func toDetailScene(movie: Movie)
}

struct FavoriteListNavigator: FavoriteListNavigatorType {
    var assembler: Assembler
    var navigation: UINavigationController
    
    func showAlertDelete(movie: Movie) -> Observable<Movie> {
        let message = String(format: "Do you really want to delete \" %@ \" from favorites",
                             movie.title ?? "")
        return navigation.showAlertView(title: "Are you sure ?",
                                        message: message,
                                        style: .alert,
                                        actions: [("Cancel", .cancel),
                                                  ("Yes", .default)])
            .filter { $0 == 1 }
            .map { _ in movie }
    }
    
    func toDetailScene(movie: Movie) {
        let detailVC: DetailViewController = assembler.resolve(navigation: navigation,
                                                               movie: movie)
        navigation.pushViewController(detailVC, animated: true)
        
    }
    
}
