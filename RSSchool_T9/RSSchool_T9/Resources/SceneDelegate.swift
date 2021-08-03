//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: Uladzislau Volchyk
// On: 23.07.21
//
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else {
            fatalError("LOL, be careful, drink some water")
        }
        window = UIWindow(windowScene: scene)
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = .red
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .red
        
        let navigationController = UINavigationController()
        let tabBarController = UITabBarController()
        let screenBuilder = ScreenBuilder(storiesSettings: StoriesSettings())
        appCoordinator = AppCoordinator(navigationController, tabBarController, screenBuilder)
        appCoordinator?.start()
                
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

