//
//  UpcomingListAssembler.swift
//  MovieDB
//
//  Created by cuonghx on 6/20/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

protocol UpcomingListAssembler {
    func resolve(navigationController: UINavigationController) -> UpcomingListViewController
    func resolve(navigationController: UINavigationController) -> UpcomingListViewModel
    func resolve(navigationController: UINavigationController) -> UpcomingListNavigatorType
    func resolve() -> UpcomingListUseCaseType
}

extension UpcomingListAssembler {
    func resolve(navigationController: UINavigationController) -> UpcomingListViewController {
        let vc = UpcomingListViewController.instantiate()
        let vm: UpcomingListViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> UpcomingListViewModel {
        return UpcomingListViewModel(navigation: resolve(navigationController: navigationController),
                                     usecase: resolve())
    }
}

extension UpcomingListAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> UpcomingListNavigatorType {
        return UpcomingListNavigator(assembler: self,
                                     navigation: navigationController)
    }
    
    func resolve() -> UpcomingListUseCaseType {
        return UpcomingListUseCase(movieRepo: resolve())
    }
}
