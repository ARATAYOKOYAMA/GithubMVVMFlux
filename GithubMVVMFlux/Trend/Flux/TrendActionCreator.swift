//
//  TrendActionCreator.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/02.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import APIKit
import RxSwift
import RxCocoa

final class TrendActionCreator: Action {

    static let shared = TrendActionCreator()

    private var dispatcher: Dispatcher

    private let disposeBag = DisposeBag()

    private var request = FetchTrendRepositoreis()

    required init(with dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
    }

    func fetchRepository() {
        Session.rx_sendRequest(request: request)
            .subscribe { [weak self] event in
                switch event {
                case .next(let repos):
                    self?.dispatcher.dispatch(TrendAction.fetchRepository(repos))
                case .error(let error):
                    self?.dispatcher.dispatch(TrendAction.error(error))
                default:
                    break
                }
            }
        .disposed(by: disposeBag)
    }
}
