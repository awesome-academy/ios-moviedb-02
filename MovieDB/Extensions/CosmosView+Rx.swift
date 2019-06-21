//
//  Comos+Rx.swift
//  Project2
//
//  Created by cuonghx on 6/16/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Cosmos

extension Reactive where Base: CosmosView {
    public var rating: Binder<Double> {
        return Binder<Double>(base, binding: { view, rating in
            view.rating = rating
        })
    }
}
