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

    // MARK: Storyboard
    private let storyboardTrend = UIStoryboard(name: "Trend", bundle: nil)
    private let storyboardSearch = UIStoryboard(name: "Search", bundle: nil)

    // MARK: View
    private let pageViewController = RepositoryFavoratePageViewController()
    private var trendViewController: TrendViewController!
    private var searchViewController: SearchViewController!

    // MARK: Navigation
    private var pageViewNavigation: UINavigationController!
    private var trendViewNavigation: UINavigationController!
    private var searchNavigation: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TabBarController
        trendViewController = storyboardTrend.instantiateViewController(withIdentifier: "storyboardTrend") as? TrendViewController
        searchViewController = storyboardSearch.instantiateViewController(withIdentifier: "storyboardSearch") as? SearchViewController

        pageViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        trendViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 2)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)

        // MARK: Navigation
        pageViewNavigation = UINavigationController(rootViewController: pageViewController)
        trendViewNavigation = UINavigationController(rootViewController: trendViewController)
        searchNavigation = UINavigationController(rootViewController: searchViewController)

        let vcs: [UIViewController] = [pageViewNavigation, trendViewNavigation, searchNavigation]
        self.setViewControllers(vcs, animated: true)
    }

    func inject(currentUser: User) {
        self.currentUser = currentUser
    }

}
