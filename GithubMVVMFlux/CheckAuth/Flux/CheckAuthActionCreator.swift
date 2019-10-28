//
//  CheckAuthActionCreator.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/28.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class CheckAuthActionCreator {

    static let shared = CheckAuthActionCreator()

    private var dispatcher: Dispatcher

    private let disposeBag = DisposeBag()

    let realm = try? Realm()

    required init(with dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
    }

    func fetchCurrentUser() {
        let currentUser = realm?.objects(User.self).first
        if currentUser == nil {
            let user = User()
            user.token = ""
            try? realm?.write {
                realm?.add(user)
            }
            self.dispatcher.dispatch(CheckAuthAction.needtoLgin)
        } else if currentUser?.token == "" {
            self.dispatcher.dispatch(CheckAuthAction.needtoLgin)
        } else {
            self.dispatcher.dispatch(CheckAuthAction.currentUser(currentUser))
        }
    }

}
