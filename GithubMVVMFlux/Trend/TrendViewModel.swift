//
//  TrendViewModel.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/02.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class TrendViewModel {

    enum ActionType {
        case fetchRepository
    }

    // MARK: VC
    private let _repositories = PublishRelay<TrendRepository>()

    // MARK: Action
    private let trendActionCreator: TrendActionCreator?

    // MARK: Store
    private let trendStore: TrendStore?

    init(with actionCreator: TrendActionCreator = .shared, store: TrendStore = .shared) {
        self.trendActionCreator = actionCreator
        self.trendStore = store
    }
}

// MARK: Output
extension TrendViewModel {
    var repositories: Observable<TrendRepository> {
        return _repositories.asObservable()
    }
}
