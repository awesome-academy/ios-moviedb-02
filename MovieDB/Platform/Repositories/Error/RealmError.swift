//
//  RealmError.swift
//  MovieDB
//
//  Created by cuonghx on 6/24/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

enum RealmError: Error {
    case addFail
    case deleteFail
    case itemExist
}

extension RealmError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .addFail:
            return "Cant add this item. Try again later"
        case .deleteFail:
            return "Cant delete this item. Try again later"
        case .itemExist:
            return "This item exists in favorite list."
        }
    }
}
