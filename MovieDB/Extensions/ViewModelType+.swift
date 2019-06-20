//
//  ViewModelType+.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.

extension ViewModelType {
    func checkIfDataIsEmpty<T: Collection>(fetchItemsTrigger: Driver<Void>,
                                           loadTrigger: Driver<Bool>,
                                           items: Driver<T>) -> Driver<Bool> {
        return Driver.combineLatest(fetchItemsTrigger, loadTrigger)
            .map { $0.1 }
            .withLatestFrom(items) { ($0, $1.isEmpty) }
            .map { loading, isEmpty -> Bool in
                return loading ? false : isEmpty
            }
    }
}
