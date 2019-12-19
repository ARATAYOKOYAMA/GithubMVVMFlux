//
//  FetchTrendRepositoreis.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/02.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import APIKit
import RxSwift

struct FetchTrendRepositoreis: GithubTrendingAPIRequest {
    typealias Response = TrendRepository

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/repositories"
    }

    var parameters: Any? {
        return ["language": "swift", "since": "weekly"]
    }

    // RxSwift の Observable を実装したインターフェース
    public func asObservable() -> Observable<Response> {
        return Session.rx_sendRequest(request: self)
    }
}
