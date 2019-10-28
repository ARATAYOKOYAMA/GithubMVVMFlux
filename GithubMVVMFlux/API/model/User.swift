//
//  User.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/28.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var token: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
