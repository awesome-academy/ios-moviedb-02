//
//  PopularAssembler.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.

import Foundation

protocol PopularListAssembler {
    func resolve(navigationController: UINavigationController) -> PopularListViewController
    func resolve(navigationController: UINavigationController) -> PopularListViewModel
    func resolve(navigationController: UINavigationController) -> PopularListNavigatorType
    func resolve() -> PopularListUseCaseType
}

extension PopularListAssembler {
    
    func resolve(navigationController: UINavigationController) -> PopularListViewController {
        let vc = PopularListViewController.instantiate()
        let vm: PopularListViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> PopularListViewModel {
        return PopularListViewModel(navigator: resolve(navigationController: navigationController),
                                    usecase: resolve())
    }
}

extension PopularListAssembler where Self: DefaultAssembler {
    
    func resolve(navigationController: UINavigationController) -> PopularListNavigatorType {
        return PopularListNavigator(assembler: self,
                                    navigation: navigationController)
    }
    
    func resolve() -> PopularListUseCaseType {
        return PopularListUseCase(movieRepo: resolve())
    }
}

