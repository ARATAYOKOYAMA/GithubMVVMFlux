//
//  SearchRepositories.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/11.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import APIKit
import RxSwift

struct SearchRepositories: GitHubRequest {
    typealias Response = SearchRepositoriesModel

    var searchText: String = ""

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/search/repositories"
    }

    var parameters: Any? {
        return ["q": searchText]
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        let decoder = JSONDecoder()
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try decoder.decode(Response.self, from: data)
    }

    // RxSwift の Observable を実装したインターフェース
    public func asObservable() -> Observable<Response> {
        return Session.rx_sendRequest(request: self)
    }
}
