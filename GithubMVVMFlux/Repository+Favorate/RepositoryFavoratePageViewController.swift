//
//  RepositoryFavoratePageViewController.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/29.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class RepositoryFavoratePageViewController: TabmanViewController {

    private var controllers: [UIViewController] = []
    private let storyboardRepository = UIStoryboard(name: "Repository", bundle: nil)
    private let storyboardFavorate = UIStoryboard(name: "Favorate", bundle: nil)
    private var repositoryViewController: RepositoryViewController!
    private var favorateViewController: FavorateViewController!
    // Create bar
    private let bar = TMBar.ButtonBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: View
        repositoryViewController = storyboardRepository.instantiateViewController(withIdentifier: "storyboardRepository") as? RepositoryViewController
        favorateViewController = storyboardFavorate.instantiateViewController(withIdentifier: "storyboardFavorate") as? FavorateViewController

        controllers.append(repositoryViewController)
        controllers.append(favorateViewController)

        self.dataSource = self

        // MARK: contentMode:bar全体のstyle fitで画面いっぱい
        bar.layout.contentMode = .fit
        // MARK: contentInset:button一つずつのpaddingのようなもの
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 4.0, right: 16.0)
        bar.indicator.weight = .light

        // Add to view
        addBar(bar, dataSource: self, at: .top)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Customize bar colors for gradient background.
        bar.buttons.customize { (button) in
            button.selectedTintColor = .red
            button.tintColor = .blue
        }

        bar.indicator.tintColor = .black
    }

}

extension RepositoryFavoratePageViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = "Page \(index)"
        return TMBarItem(title: title)
    }

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return controllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return controllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

}
