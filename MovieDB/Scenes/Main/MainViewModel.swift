//
//  MainViewModel.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

struct MainViewModel {
    var usecase: MainUseCaseType
    var navigator: MainNavigatorType
}

extension MainViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
    }
    
    func transform(_ input: Input) -> Output {
        return Output()
    }
}
