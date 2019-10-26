//
//  TestViewFluxTest.swift
//  GithubMVVMFluxTests
//
//  Created by 横山新 on 2019/10/26.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import GithubMVVMFlux

class TestViewFluxTest: XCTestCase {

    // MARK: Action
    private let testActionCreator: TestActionCreator? = .shared

    // MARK: Store
    private let testStore: TestStore? = .shared

    private let _repositories = PublishRelay<[Repository]>()

    private let disposeBag = DisposeBag()

    override func setUp() {
        guard let testStore = testStore else { return }
        testStore.repositories
            .bind(to: _repositories)
            .disposed(by: disposeBag)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFlux() {
        testActionCreator?.fetchRepository(userName: "ARATAYOKOYAMA")
        _repositories.subscribe(onNext: {
            print($0)
            XCTAssert(true)
        })
    }

}
