//
//  MainAssembler.swift
//  MovieDB
//
//  Created by cuonghx on 6/14/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

protocol MainAssembler {
    func resolve(navController: UINavigationController) -> MainViewController
    func resolve(navController: UINavigationController) -> MainViewModel
    func resolve(navController: UINavigationController) -> MainNavigatorType
    func resolve() -> MainUseCaseType
}

extension MainAssembler {
    
    func resolve(navController: UINavigationController) -> MainViewController {
        let vc = MainViewController.instantiate()
        let vm: MainViewModel = resolve(navController: navController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navController: UINavigationController) -> MainViewModel {
        return MainViewModel(usecase: resolve(),
                             navigator: resolve(navController: navController))
    }
}

extension MainAssembler where Self: DefaultAssembler {
    func resolve(navController: UINavigationController) -> MainNavigatorType {
        return MainNavigator(assembler: self,
                             navigation: navController)
    }
    
    func resolve() -> MainUseCaseType {
        return MainUseCase()
    }
}
