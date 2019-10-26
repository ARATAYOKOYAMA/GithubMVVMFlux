//
//  FetchRepositoryRequest.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/24.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import APIKit
import RxSwift

struct FetchRepositoryRequest: GitHubRequest {
    typealias Response = [Repository]

    var userName: String

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/users/\(self.userName)/repos"
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
