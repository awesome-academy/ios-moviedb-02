//
//  SearchBar+Rx.swift
//  MovieDB
//
//  Created by cuonghx on 6/19/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

extension Reactive where Base: UISearchBar {
    var clearText: Binder<Void> {
        return Binder(base) { searchBar, _ in
            guard let txtField = searchBar.value(forKey: "_searchField") as? UITextField else {
                assertionFailure()
                return
            }
            txtField.text = ""
            txtField.sendActions(for: .editingDidEnd)
        }
    }
}
