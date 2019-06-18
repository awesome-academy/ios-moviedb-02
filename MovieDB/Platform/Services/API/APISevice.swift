//
//  APISevice.swift
//  MovieDB
//
//  Created by cuonghx on 6/1/19.
//  Copyright © 2019 Sun*. All rights reserved.
//

final class API: APIBase {
    static var shared = API()
    
    override func handleResponseError(response: HTTPURLResponse, data: Data, json: JSONDictionary?) -> Error {
        if let json = json, let message = json["message"] as? String {
            return APIResponseError(statusCode: response.statusCode, message: message)
        }
        return super.handleResponseError(response: response, data: data, json: json)
    }
    
    override func preprocess(_ input: APIInputBase) -> Observable<APIInputBase> {
        return super.preprocess(input)
    }
}
