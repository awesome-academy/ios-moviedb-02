//
//  FavoriteAssembler.swift
//  MovieDB
//
//  Created by cuonghx on 6/23/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

protocol FavoriteListAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteListViewController
    func resolve(navigationController: UINavigationController) -> FavoriteListViewModel
    func resolve(navigationController: UINavigationController) -> FavoriteListNavigatorType
    func resolve() -> FavoriteListUseCaseType
}

extension FavoriteListAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteListViewController {
        let vc = FavoriteListViewController.instantiate()
        let vm: FavoriteListViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> FavoriteListViewModel {
        return FavoriteListViewModel(usecase: resolve(),
                                     navigator: resolve(navigationController: navigationController))
    }
}

extension FavoriteListAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteListNavigatorType {
        return FavoriteListNavigator(assembler: self,
                                     navigation: navigationController)
    }
    func resolve() -> FavoriteListUseCaseType {
        return FavoriteListUseCase(favoriteRepo: resolve())
    }
}
