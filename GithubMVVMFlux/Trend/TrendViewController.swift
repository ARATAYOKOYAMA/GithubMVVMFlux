//
//  TrendViewController.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/29.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import SafariServices
import RxSwift
import RxCocoa

final class TrendViewController: UIViewController {

    enum UIparameters: CGFloat {
        case trendTableViewCellHeight = 116
    }

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = TrendViewModel()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = L10n.Navigation.Trend.title

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
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // MARK: 外に出せないかな・・？？
        if let url = viewModel.repositories[indexPath.row].url.url {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }

}

extension TrendViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositoriesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TrendTableViewCell.self, for: indexPath)
        if !viewModel.hideSkeletonFlag {
            cell.seetupCell(ropository: viewModel.repositories[indexPath.row])
        }
        return cell
    }

}
