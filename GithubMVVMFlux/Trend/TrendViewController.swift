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

class TrendViewController: UIViewController {

    private let disposeBag = DisposeBag()

    private var request = FetchTrendRepositoreis()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRepository()
        // Do any additional setup after loading the view.
    }

    func fetchRepository() {
        print(request.baseURL)
        print(request.path)
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
