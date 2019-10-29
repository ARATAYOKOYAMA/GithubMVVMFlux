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

    override func viewDidLoad() {
        super.viewDidLoad()

        // TabBarController
        trendViewController = storyboardTrend.instantiateViewController(withIdentifier: "storyboardTrend") as? TrendViewController
        searchViewController = storyboardSearch.instantiateViewController(withIdentifier: "storyboardSearch") as? SearchViewController

        pageViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        trendViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 3)

        let vcs: [UIViewController] = [pageViewController, trendViewController, searchViewController]
        self.setViewControllers(vcs, animated: true)
    }

    func inject(currentUser: User) {
        self.currentUser = currentUser
    }

}
