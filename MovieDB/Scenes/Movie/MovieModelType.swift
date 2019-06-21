//
//  MovieModelType.swift
//  MovieDB
//
//  Created by cuonghx on 6/18/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

protocol MovieModelType {
    var title: String { get }
    var genres: String { get }
    var overview: String { get }
    var voteAverage: Double { get }
    var posterPath: String { get }
    var releaseDate: String { get }
    var id: Int { get }
}
