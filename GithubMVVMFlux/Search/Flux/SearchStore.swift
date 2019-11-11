//
//  SearchStore.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/11.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchStore {

    static let shared = SearchStore()

    private let disposeBag = DisposeBag()

    var searchRepositories: Observable<SearchRepositoriesModel?> {
        return _searchRepositoriesStream.asObservable()
    }

    private let _searchRepositoriesStream = BehaviorRelay<SearchRepositoriesModel?>(value: nil)

    required init(with dispatcher: Dispatcher = .shared) {
        dispatcher.register(handler: { [weak self] (action: SearchAction) in
            guard let wself = self else { return }
            switch action {
            case .searchRepository(let result):
                wself._searchRepositoriesStream.accept(result)
            case .error:
                break
            }
        }).disposed(by: disposeBag)
    }
}
