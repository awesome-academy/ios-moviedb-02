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
}

extension MainAssembler where Self: DefaultAssembler {
    func resolve(navController: UINavigationController) -> MainViewController {
        
        let mainVC = MainViewController.instantiate().then {
            $0.viewControllers = []
        }
        
        return mainVC
    }
}
