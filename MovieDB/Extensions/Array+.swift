//
//  Array+.swift
//  MovieDB
//
//  Created by cuonghx on 6/20/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

extension Array where Element == Int {
    func convertListGenres() -> String {
        guard !isEmpty else { return "" }
        return self.compactMap { Constants.genres[$0] }
            .joined(separator: ", ")
    }
}
