//
//  TrendAction.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/02.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation

enum TrendAction: Action {
    case fetchRepository(TrendRepository)
    case error(Swift.Error)
}
