//
//  TrendStore.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/02.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class TrendStore {

    static let shared = TrendStore()

    private let disposeBag = DisposeBag()

    var trendRepositories: Observable<TrendRepository> {
        return _trendRepositoriesStream.asObservable()
    }

    private let _trendRepositoriesStream = BehaviorRelay<TrendRepository>(value: [])

    required init(with dispatcher: Dispatcher = .shared) {

        dispatcher.register(handler: { [weak self] (action: TrendAction) in
            guard let wself = self else { return }
            switch action {
            case .fetchRepository(let result):
                wself._trendRepositoriesStream.accept(result)
            case .error:
                break
            }
        }).disposed(by: disposeBag)
    }

}
