//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 31.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import <UIKit/UIKit.h>
@class AppCoordinator;
@class StoriesSettings;

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewController : UIViewController

- (instancetype) init:(AppCoordinator *) coordinator settings:(StoriesSettings *) settings;
@property (nonatomic) UITableView *table;
@property (nonatomic) StoriesSettings* settings;
@property (nonatomic) AppCoordinator *coordinator;

@end

NS_ASSUME_NONNULL_END
