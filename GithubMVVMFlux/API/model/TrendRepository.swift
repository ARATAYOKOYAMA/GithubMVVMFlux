//
//  TrendRepository.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/02.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - TrendRepository
struct TrendRepositoryElement: Codable {
    let author, name: String
    let avatar: String
    let url: String
    let description, language, languageColor: String
    let stars, forks, currentPeriodStars: Int
    let builtBy: [BuiltBy]

    enum CodingKeys: String, CodingKey {
        case author, name, avatar, url
        case description
        case language, languageColor, stars, forks, currentPeriodStars, builtBy
    }
}

// MARK: - BuiltBy
struct BuiltBy: Codable {
    let username: String
    let href, avatar: String
}

typealias TrendRepository = [TrendRepositoryElement]
