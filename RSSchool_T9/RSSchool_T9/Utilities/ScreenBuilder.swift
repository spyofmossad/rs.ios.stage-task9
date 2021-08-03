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

class ScreenBuilder {
    
    private var storiesSettings: StoriesSettings
    
    init(storiesSettings: StoriesSettings) {
        self.storiesSettings = storiesSettings
    }
    
    func getMainScreen(coordinator: AppCoordinator) -> UIViewController {
        return MainViewController(coordinator: coordinator)
    }
    
    func getSettingsScreen(coordinator: AppCoordinator) -> UIViewController {
        return SettingsViewController(coordinator, settings: storiesSettings)
    }
    
    func getColorsScreen(coordinator: AppCoordinator) -> UIViewController {
        return ColorsViewController(coordinator, settings: storiesSettings)
    }
    
    func getStoryScreen(coordinator: AppCoordinator, story: Story) -> UIViewController {
        return StoryViewController(coordinator: coordinator, story: story, settings: storiesSettings)
    }
    
    func getGalleryScreen(coordinator: AppCoordinator, gallery: Gallery) -> UIViewController {
        return GalleryViewController(coordinator: coordinator, gallery: gallery)
    }
    
    func getImageScreen(coordinator: AppCoordinator, image: UIImage) -> UIViewController {
        return ImageViewController(coordinator: coordinator, image: image)
    }
}
