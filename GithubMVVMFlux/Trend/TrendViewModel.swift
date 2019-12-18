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
    private let viewWillAppearStream = PublishSubject<Void>()
    private let _repositories = BehaviorRelay<TrendRepository>(value: [])
    private let _reloadData = PublishSubject<Void>()
    private var _hideSkeletonFlag = true

    // MARK: Action
    private let trendActionCreator: TrendActionCreator?

    // MARK: Store
    private let trendStore: TrendStore?

    private let disposeBag = DisposeBag()

    init(with actionCreator: TrendActionCreator = .shared, store: TrendStore = .shared) {
        self.trendActionCreator = actionCreator
        self.trendStore = store

        // MARK: Input
        viewWillAppearStream.subscribe({[weak self] _ in
            self?.createAction(type: .fetchRepository)
            self?._hideSkeletonFlag = true
        })
            .disposed(by: disposeBag)

        // MARK: Output
        trendStore?.trendRepositories
            .skip(1)
            .subscribe({[weak self] repositories in
                guard let data = repositories.element else { return }
                self?._repositories.accept(data)
                self?._reloadData.onNext(())
                self?._hideSkeletonFlag = false
            })
            .disposed(by: disposeBag)
    }

    private func createAction(type: ActionType) {
        switch type {
        case .fetchRepository:
            self.trendActionCreator?.fetchRepository()
        }
    }
}

// MARK: Input
extension TrendViewModel {
    var viewWillAppear: AnyObserver<()> {
        return viewWillAppearStream.asObserver()
    }
}

// MARK: Output
extension TrendViewModel {
    var reloadData: Observable<Void> {
        return _reloadData.asObservable()
    }

    var repositories: TrendRepository {
        return _repositories.value
    }

    var repositoriesCount: Int {
        return _repositories.value.count
    }

    var hideSkeletonFlag: Bool {
        return _hideSkeletonFlag
    }
}
