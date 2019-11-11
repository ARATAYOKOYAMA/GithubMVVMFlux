//
//  SearchRepositoriesModel.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/11/11.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation

// MARK: - SearchRepositoriesModel
struct SearchRepositoriesModel: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let nodeId, name, fullName: String
    let owner: Owner
    let `private`: Bool
    let htmlUrl: String
    let description: String?
    let fork: Bool
    let url: String
    let createdAt, updatedAt, pushedAt: String
    let homepage: String?
    let size, stargazersCount, watchersCount: Int
    let language: String?
    let defaultBranch: String
    let forksCount, openIssuesCount: Int
    let score: Double
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url, receivedEventsUrl: String
    let type: String
}
