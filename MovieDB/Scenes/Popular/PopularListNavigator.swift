//
//  PopularNavigator.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.

protocol PopularListNavigatorType {
}

struct PopularListNavigator: PopularListNavigatorType {
    var assembler: Assembler
    var navigation: UINavigationController
}
