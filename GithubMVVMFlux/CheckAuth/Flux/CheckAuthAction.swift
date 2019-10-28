//
//  CheckAuthAction.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/28.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation

enum CheckAuthAction: Action {
    case currentUser(User?)
    case needtoLgin
}
