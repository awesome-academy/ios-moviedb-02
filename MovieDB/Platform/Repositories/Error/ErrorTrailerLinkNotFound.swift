//
//  ErrorTrailerLinkNotFound.swift
//  MovieDB
//
//  Created by cuonghx on 6/20/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

struct ErrorTrailerLinkNotFound: Error, LocalizedError {
    var errorDescription: String {
        return "Trailer Link Not Found"
    }
}
