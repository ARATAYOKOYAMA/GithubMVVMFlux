//
//  SearchViewController.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/29.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import APIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            //            tableView.dataSource = self
        }
    }
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.rx.text
            // MARK: 初期化時に空文字が流れるのでそれはスキップ
            .skip(1)
            // MARK: 最後のストリームから1秒後に流す
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            // MARK: 流れるストリームはoptionalなので
            .filterNil()
            .subscribe(onNext: { [weak self] text in
                print(text)
                //FIXME: とりあえず
                self?.fetchRepository(userName: text)
            })
            .disposed(by: disposeBag)
    }
    
    //FIXME: とりあえず
    private var request = SearchRepositories()

    func fetchRepository(userName: String) {
        request.searchText = userName
        Session.rx_sendRequest(request: request)
            .subscribe { [weak self] event in
                switch event {
                case .next(let repos):
                    print(repos)
                case .error(let error):
                    print(error)
                default:
                    break
                }
            }
        .disposed(by: disposeBag)
    }

}

extension SearchViewController: UISearchBarDelegate {

    // 検索キータップ時に呼び出されるメソッド.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }

}

extension SearchViewController: UITableViewDelegate {

}

//extension SearchViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    }
//}
