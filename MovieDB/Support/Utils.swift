//
//  Utils.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.

import Foundation

enum Utils {
    static func getGenreList(genres: [Int]) -> String {
        guard !genres.isEmpty else { return "" }
        var genresReturn = ""
        for index in genres {
            genresReturn += "\(Constants.genres[index] ?? ""), "
        }
        return String(genresReturn.prefix(upTo: genresReturn.index(genresReturn.endIndex,
                                                                   offsetBy: -2)))
    }
}
