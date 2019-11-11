//
//  SearchActionCreator.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/11.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import APIKit
import RxSwift
import RxCocoa

final class SearchActionCreator: Action {

    static let shared = TrendActionCreator()

    private var dispatcher: Dispatcher

    private let disposeBag = DisposeBag()

    private var request = SearchRepositories()

    required init(with dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
    }

    func searchRepository(userName: String) {
        request.searchText = userName
        Session.rx_sendRequest(request: request)
            .subscribe { [weak self] event in
                guard let wself = self else { return }
                switch event {
                case .next(let repos):
                    print(repos)
                    wself.dispatcher.dispatch(SearchAction.searchRepository(repos))
                case .error(let error):
                    print(error)
                default:
                    break
                }
            }
        .disposed(by: disposeBag)
    }
}
