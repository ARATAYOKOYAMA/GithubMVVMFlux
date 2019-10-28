//
//  SceneDelegate.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/21.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let viewModel = CheckAuthViewModel()
    private let disposeBag = DisposeBag()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        viewModel.user.subscribe({[weak self] user in
            self?.pushTab(scene: scene)
        })
            .disposed(by: disposeBag)
        
        viewModel.requireToken.subscribe({[weak self] _ in
            self?.pushTab(scene: scene)
        })
            .disposed(by: disposeBag)
        
        viewModel.setupStream.onNext(())
        viewModel.setupStream.dispose()
        
    }
    
    private func pushMain(scene: UIWindowScene) {
        //　Storyboardを指定
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Viewcontrollerを指定
        let initialViewController = storyboard.instantiateInitialViewController() as! ViewController
        
        //　windowを生成
        window = UIWindow(windowScene: scene)
        // rootViewControllerに入れる
        window?.rootViewController = initialViewController
        // 表示
        window?.makeKeyAndVisible()
    }
    
    private func pushTab(scene: UIWindowScene) {
        // Viewcontrollerを指定
        let initialViewController = TabBarController()
        
        //　windowを生成
        window = UIWindow(windowScene: scene)
        // rootViewControllerに入れる
        window?.rootViewController = initialViewController
        // 表示
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
