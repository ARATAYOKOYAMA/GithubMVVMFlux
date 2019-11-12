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

final class SearchViewController: UIViewController {

    enum UIparameters: CGFloat {
        case trendTableViewCellHeight = 132
    }

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(cellType: SearchTableViewCell.self)
            tableView.estimatedRowHeight = UIparameters.trendTableViewCellHeight.rawValue //セルの高さ
        }
    }
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Input
        viewModel.reloadData.subscribe({[weak self] _ in
            self?.reloadData()
        })
            .disposed(by: disposeBag)

        // MARK: Output
        searchBar.rx.text
            // MARK: 初期化時に空文字が流れるのでそれはスキップ
            .skip(1)
            // MARK: 最後のストリームから1秒後に流す
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            // MARK: 流れるストリームはoptionalなので
            .filterNil()
            .bind(to: viewModel.incrementalSearchBar)
            .disposed(by: disposeBag)
    }

    private func reloadData() {
        tableView.reloadData()
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // MARK: 外に出せないかな・・？？
        //        if let url = viewModel.repositories[indexPath.row].url.url {
        //            let safariVC = SFSafariViewController(url: url)
        //            present(safariVC, animated: true, completion: nil)
        //        }
    }

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositoriesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SearchTableViewCell.self, for: indexPath)
        cell.seetupCell(ropository: viewModel.repositories?[indexPath.row])
        return cell
    }
}
