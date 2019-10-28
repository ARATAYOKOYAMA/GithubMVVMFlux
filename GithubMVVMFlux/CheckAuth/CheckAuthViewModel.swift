//
//  CheckAuthViewModel.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/28.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CheckAuthViewModel {
    enum ActionType {
        case fetchCurrentUser
    }

    // MARK: View
    let setupStream = PublishSubject<Void>()
    private let _userStream = PublishRelay<User>()
    private let _requireTokenStream = PublishRelay<Void>()

    // MARK: Action
    private let checkAuthActionCreator: CheckAuthActionCreator?

    // MARK: Store
    private let checkAuthStore: CheckAuthStore?

    private let disposeBag = DisposeBag()

    init(with actionCreator: CheckAuthActionCreator = .shared, store: CheckAuthStore = .shared) {
        self.checkAuthActionCreator = actionCreator
        self.checkAuthStore = store

        // MARK: Input
        setupStream.subscribe({[weak self] _ in
            self?.createAction(type: .fetchCurrentUser)
        })
            .disposed(by: disposeBag)

        // MARK: Output
        guard let checkAuthStore = checkAuthStore else { return }
        checkAuthStore.user
            .filterNil()
            .bind(to: _userStream)
            .disposed(by: disposeBag)

        checkAuthStore.requireToken
            .bind(to: _requireTokenStream)
            .disposed(by: disposeBag)
    }

    private func createAction(type: ActionType) {
        guard checkAuthActionCreator != nil else { return }
        switch type {
        case .fetchCurrentUser:
            self.checkAuthActionCreator?.fetchCurrentUser()
        }
    }
}

// MARK: Input
extension CheckAuthViewModel {
//    var setup: AnyObserver<Void> {
//        return _setupStream.asObserver()
//    }
}

// MARK: Output
extension CheckAuthViewModel {
    var user: Observable<User> {
        return _userStream.asObservable()
    }

    var requireToken: Observable<Void> {
        return _requireTokenStream.asObservable()
    }
}
