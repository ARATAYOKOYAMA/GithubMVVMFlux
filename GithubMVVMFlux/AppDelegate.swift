//
//  AppDelegate.swift
//  GithubMVVMFlux
//
//  Created by 横山新 on 2019/10/21.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        //　Storyboardを指定
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        // Viewcontrollerを指定
//        let initialViewController = storyboard.instantiateInitialViewController() as! ViewController

        //　Storyboardを指定
        let storyboard = UIStoryboard(name: "TestTabNav", bundle: nil)
        // Viewcontrollerを指定
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "TabVC")

        //　windowを生成
        window = UIWindow(frame: UIScreen.main.bounds)
        // rootViewControllerに入れる
        window?.rootViewController = initialViewController
        // 表示
        window?.makeKeyAndVisible()

        FirebaseApp.configure()
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
            })
        Realm.Configuration.defaultConfiguration = config
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
