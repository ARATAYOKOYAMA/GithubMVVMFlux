//
//  SearchViewModel.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/11.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {

    enum ActionType {
        case searchRepository(text: String)
    }

    // MARK: VC
    private let _incrementalSearchBarStream = PublishSubject<String>()
    private let _repositories = BehaviorRelay<SearchRepositoriesModel?>(value: nil)
    private let _reloadData = PublishSubject<Void>()

    // MARK: Action
    private let searchActionCreator: SearchActionCreator?

    // MARK: Store
    private let searchStore: SearchStore?

    private let disposeBag = DisposeBag()

    required init(with actionCreator: SearchActionCreator = .shared, store: SearchStore = .shared) {
        self.searchActionCreator = actionCreator
        self.searchStore = store

        // MARK: Input
        _incrementalSearchBarStream.subscribe(onNext: { [weak self] text in
            self?.createAction(type: .searchRepository(text: text))
        }).disposed(by: disposeBag)

        // MARK: Output
        searchStore?.searchRepositories
            .subscribe({[weak self] repositories in
                guard let data = repositories.element else { return }
                self?._repositories.accept(data)
                self?._reloadData.onNext(())
            })
            .disposed(by: disposeBag)
    }

    private func createAction(type: ActionType) {
        switch type {
        case .searchRepository(let text):
            guard text != "" else { return }
            self.searchActionCreator?.searchRepository(userName: text)
        }
    }
}

// MARK: Input
extension SearchViewModel {
    var incrementalSearchBar: AnyObserver<String> {
        return _incrementalSearchBarStream.asObserver()
    }
}

// MARK: Output
extension SearchViewModel {
    var reloadData: Observable<Void> {
        return _reloadData.asObservable()
    }

    var repositories: SearchRepositoriesModel? {
        return _repositories.value
    }

    var repositoriesCount: Int {
        guard let count = _repositories.value?.items.count else {
            return 0
        }
        return count
    }
}
