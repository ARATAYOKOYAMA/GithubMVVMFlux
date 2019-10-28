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
    private var vc1: RepositoryViewController!
    private var vc2: FavorateViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboardRepository = UIStoryboard(name: "Repository", bundle: nil)
        let storyboardFavorate = UIStoryboard(name: "Favorate", bundle: nil)

        // TabBarController
        vc1 = storyboardRepository.instantiateViewController(withIdentifier: "storyboardRepository") as? RepositoryViewController
        vc1.test = 100
        vc2 = storyboardFavorate.instantiateViewController(withIdentifier: "storyboardFavorate") as? FavorateViewController
        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        let vcs: [UIViewController] = [vc1, vc2]
        self.setViewControllers(vcs, animated: true)
    }

    func inject(currentUser: User) {
        self.currentUser = currentUser
    }

}
