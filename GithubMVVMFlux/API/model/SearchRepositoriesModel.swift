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
    let nodeID, name, fullName: String
    let owner: Owner
    let itemPrivate: Bool
    let htmlURL: String
    let itemDescription: String
    let fork: Bool
    let url: String
    let createdAt, updatedAt, pushedAt: Date
    let homepage: String
    let size, stargazersCount, watchersCount: Int
    let language: String
    let forksCount, openIssuesCount: Int
    let masterBranch, defaultBranch: String
    let score: Double
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, receivedEventsURL: String
    let type: String
}
