//
//  TabBarController.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/28.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    private var currentUser: User?
    private let storyboardRepository = UIStoryboard(name: "Repository", bundle: nil)
    private let storyboardFavorate = UIStoryboard(name: "Favorate", bundle: nil)
    private let storyboardTrend = UIStoryboard(name: "Trend", bundle: nil)
    private let storyboardSearch = UIStoryboard(name: "Search", bundle: nil)
    private var repositoryViewController: RepositoryViewController!
    private var favorateViewController: FavorateViewController!
    private var trendViewController: TrendViewController!
    private var searchViewController: SearchViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TabBarController
        repositoryViewController = storyboardRepository.instantiateViewController(withIdentifier: "storyboardRepository") as? RepositoryViewController
        favorateViewController = storyboardFavorate.instantiateViewController(withIdentifier: "storyboardFavorate") as? FavorateViewController
        trendViewController = storyboardTrend.instantiateViewController(withIdentifier: "storyboardTrend") as? TrendViewController
        searchViewController = storyboardSearch.instantiateViewController(withIdentifier: "storyboardSearch") as? SearchViewController
        repositoryViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        trendViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 3)
        let vcs: [UIViewController] = [repositoryViewController, trendViewController, searchViewController]
        self.setViewControllers(vcs, animated: true)
    }

    func inject(currentUser: User) {
        self.currentUser = currentUser
    }

}
