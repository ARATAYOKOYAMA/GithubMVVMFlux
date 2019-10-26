//
//  TestAction.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/24.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation

enum TestAction: Action {
    case fetchRepository([Repository])
    case error(Swift.Error)
}
