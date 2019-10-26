//
//  TestStore.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/24.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class TestStore {

    static let shared = TestStore()

    private let disposeBag = DisposeBag()

    var repositories: Observable<[Repository]> {
        return _repositoryStream.asObservable()
    }

    private let _repositoryStream = BehaviorRelay<[Repository]>(value: [])

    required init(with dispatcher: Dispatcher = .shared) {

        dispatcher.register(handler: { [weak self] (action: TestAction) in
            guard let wself = self  else { return }
            switch action {
            case .fetchRepository(let result):
                wself._repositoryStream.accept(result)
            case .error:
                break
            }
        }).disposed(by: disposeBag)
    }
}
