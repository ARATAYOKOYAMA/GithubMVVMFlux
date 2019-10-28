//
//  CheckAuthStore.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/28.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class CheckAuthStore {
    static let shared = CheckAuthStore()

    private let disposeBag = DisposeBag()

    var user: Observable<User?> {
        return _userStream.asObservable()
    }

    var requireToken: Observable<Void> {
        return _requireTokenStream.asObservable()
    }

    private let _userStream = BehaviorRelay<User?>(value: nil)
    private let _requireTokenStream = BehaviorRelay<Void>(value: ())

    required init(with dispatcher: Dispatcher = .shared) {

        dispatcher.register(handler: { [weak self] (action: CheckAuthAction) in
            guard let wself = self  else { return }
            switch action {
            case .currentUser(let result):
                wself._userStream.accept(result)
            case .needtoLgin:
                wself._requireTokenStream.accept(())
            }
        }).disposed(by: disposeBag)
    }
}
