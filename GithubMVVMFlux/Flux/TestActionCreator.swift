//
//  TestActionCreator.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/24.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import APIKit
import RxSwift
import RxCocoa

final class TestActionCreator: Action {

    static let shared = TestActionCreator()

    private var dispatcher: Dispatcher

    private let disposeBag = DisposeBag()

    private var request: FetchRepositoryRequest?

    required init(with dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
    }

    func fetchRepository(userName: String) {
        guard var request = request else { return }
        request = FetchRepositoryRequest(userName: userName)
        Session.rx_sendRequest(request: request)
            .subscribe { [weak self] event in
                switch event {
                case .next(let repos):
                    self?.dispatcher.dispatch(TestAction.fetchRepository(repos))
                case .error(let error):
                    self?.dispatcher.dispatch(TestAction.error(error))
                default:
                    break
                }
            }
        .disposed(by: disposeBag)
    }

}
