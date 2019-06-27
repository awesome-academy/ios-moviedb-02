//
//  DetailAssembler.swift
//  Project2
//
//  Created by cuonghx on 6/15/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

protocol DetailAssembler {
    func resolve(navigation: UINavigationController, movie: Movie) -> DetailViewController
    func resolve(navigation: UINavigationController, movie: Movie) -> DetailViewModel
    func resolve(navigation: UINavigationController) -> DetailNavigatorType
    func resolve() -> DetailUseCaseType
}

extension DetailAssembler {
    func resolve(navigation: UINavigationController, movie: Movie) -> DetailViewController {
        let vc = DetailViewController.instantiate()
        let vm: DetailViewModel = resolve(navigation: navigation, movie: movie)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigation: UINavigationController, movie: Movie) -> DetailViewModel {
        return DetailViewModel(usecase: resolve(),
                               navigator: resolve(navigation: navigation),
                               movie: movie)
    }
}

extension DetailAssembler where Self: DefaultAssembler {
    func resolve(navigation: UINavigationController) -> DetailNavigatorType {
        return DetailNavigator(assembler: self,
                               navigation: navigation)
    }
    
    func resolve() -> DetailUseCaseType {
        return DetailUseCase(detailRepo: resolve(), favoriteRepo: resolve())
    }
}
