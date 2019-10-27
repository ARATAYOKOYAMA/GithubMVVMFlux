//
//  ViewController.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/21.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet private weak var testButton: UIButton!
    private let viewModel = TestViewModel()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: output
        testButton.rx.tap
            .bind(to: viewModel.testButtonDidTap)
            .disposed(by: disposeBag)

        // MARK: inpuut
        viewModel.repositories.subscribe(onNext: {
            print($0)
        })
            .disposed(by: disposeBag)
    }

}
