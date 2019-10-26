//
//  GitHubAPIRequest.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/24.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import APIKit

protocol GitHubRequest: Request {

}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return object
    }
}

extension GitHubRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
