//
//  Genre.swift
//  MovieDB
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import RxDataSources

struct GenreModel {
    var name: String
    var id: Int
}

extension GenreModel {
    init() {
        self.init(name: "",
                  id: 0)
    }
}
