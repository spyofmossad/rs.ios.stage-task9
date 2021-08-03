//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 28.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import Foundation
import UIKit

class AppCoordinator: NSObject {
    private var navigationController: UINavigationController
    private var screenBuilder: ScreenBuilder
    private var tabBar: UITabBarController
     
    init(_ navigationController: UINavigationController, _ tabBarController: UITabBarController, _ screenBuilder: ScreenBuilder) {
        self.navigationController = navigationController
        self.screenBuilder = screenBuilder
        self.tabBar = tabBarController
    }
    
    func start() {
        let mainViewController = screenBuilder.getMainScreen(coordinator: self)
        let settingsViewController = screenBuilder.getSettingsScreen(coordinator: self)
        navigationController.setViewControllers([settingsViewController], animated: false)
        tabBar.setViewControllers([mainViewController, navigationController], animated: false)
    }
    
    func goToStoryScreen(from: UIViewController, content data: Story) {
        let storyViewController = screenBuilder.getStoryScreen(coordinator: self, story: data)
        from.present(storyViewController, animated: true, completion: nil)
    }
    
    func goToGalleryScreen(from: UIViewController, content data: Gallery) {
        let galleryViewController = screenBuilder.getGalleryScreen(coordinator: self, gallery: data)
        from.present(galleryViewController, animated: true, completion: nil)
    }
    
    func goToImageScreen(from: UIViewController, image: UIImage) {
        let imageViewController = screenBuilder.getImageScreen(coordinator: self, image: image)
        from.present(imageViewController, animated: true, completion: nil)
    }
    
    @objc func goToColorsScreen() {
        let colorsViewController = screenBuilder.getColorsScreen(coordinator: self)
        navigationController.pushViewController(colorsViewController, animated: true)
    }
    
    @objc func close() {
        navigationController.popViewController(animated: true)
    }
    
    @objc func close(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
