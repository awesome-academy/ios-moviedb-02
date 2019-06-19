//
//  API+CompanyList.swift
//  MovieDB
//
//  Created by cuonghx on 6/17/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

import ObjectMapper

extension API {
    func getCompanyList(input: GetCompanyListInput) -> Observable<GetCompanyListOutput> {
        return request(input)
    }
}

extension API {
    final class GetCompanyListInput: APIInputBase {
        init(movieID: Int) {
            super.init(urlString: API.Urls.moviesURL + "/\(movieID)",
                       parameters: nil,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetCompanyListOutput: APIOutputBase {
        private(set) var companyList: [Company]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            companyList <- map["production_companies"]
        }
    }
}
