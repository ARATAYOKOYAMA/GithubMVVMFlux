//
//  SearchAction.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/11.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation

enum SearchAction: Action {
    case searchRepository(SearchRepositoriesModel)
    case error(Swift.Error)
}
