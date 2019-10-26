//
//  TestViewModel.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/24.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class TestViewModel {

    enum ActionType {
        case fetchRepository
    }

    // MARK: VC
    private let _testButtonDidTapStream = PublishSubject<Void>()
    private let _repositories = PublishRelay<[Repository]>()

    // MARK: Action
    private let testActionCreator: TestActionCreator?

    // MARK: Store
    private let testStore: TestStore?

    private let disposeBag = DisposeBag()

    init(with actionCreator: TestActionCreator = .shared, store: TestStore = .shared) {
        self.testActionCreator = actionCreator
        self.testStore = store

        // MARK: input
        _testButtonDidTapStream.subscribe({[weak self] _ in
            self?.createAction(type: .fetchRepository)
        })
            .disposed(by: disposeBag)

        // MARK: ouutput
        guard let testStore = testStore else { return }
        testStore.repositories
            .bind(to: _repositories)
            .disposed(by: disposeBag)
    }

    private func createAction(type: ActionType) {
        guard let testActionCreator = testActionCreator else { return }
        switch type {
        case .fetchRepository:
            testActionCreator.fetchRepository(userName: "ARATAYOKOYAMA")
        }
    }
}

// MARK: input
extension TestViewModel {
    var testButtonDidTap: AnyObserver<()> {
        return _testButtonDidTapStream.asObserver()
    }
}

// MARK: output
extension TestViewModel {
    var repositories: Observable<[Repository]> {
        return _repositories.asObservable()
    }
}
