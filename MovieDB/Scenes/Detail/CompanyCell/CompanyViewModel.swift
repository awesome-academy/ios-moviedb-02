//
//  CompanyViewModel.swift
//  MovieDB
//
//  Created by cuonghx on 6/21/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import Foundation

struct CompanyViewModel {
    let company: Company
}

extension CompanyViewModel {
    
    var logoPath: String {
        return company.logoPath
    }
    
    var name: String {
        return company.name
    }
}
