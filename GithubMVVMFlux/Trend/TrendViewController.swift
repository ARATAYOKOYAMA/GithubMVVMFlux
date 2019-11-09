//
//  TrendViewController.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/29.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import APIKit
import RxSwift
import RxCocoa

final class TrendViewController: UIViewController {

    enum UIparameters: CGFloat {
        case trendTableViewCellHeight = 116
    }

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = TrendViewModel()

    private let disposeBag = DisposeBag()

    private var request = FetchTrendRepositoreis()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: TrendTableViewCell.self)
        tableView.estimatedRowHeight = UIparameters.trendTableViewCellHeight.rawValue //セルの高さ

        // MARK: Input
        viewModel.reloadData.subscribe({[weak self] _ in
            self?.reloadData()
        })
            .disposed(by: disposeBag)

        // MARK: Output
        rx.sentMessage(#selector(viewWillAppear(_:)))
            .take(1)
            .map { _ in }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
    }

    private func reloadData() {
        tableView.reloadData()
    }

}

extension TrendViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIparameters.trendTableViewCellHeight.rawValue
    }

}

extension TrendViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositoriesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TrendTableViewCell.self, for: indexPath)
        return cell
    }

}
