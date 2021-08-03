//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 30.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "SettingsViewController.h"
#import "AnimationSwitchCell.h"

#import "RSSchool_T9-Swift.h"

@interface SettingsViewController ()

@end

@interface SettingsViewController (TableDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SettingsViewController

- (instancetype)init:(AppCoordinator *)coordinator settings:(StoriesSettings *)settings {
    self = [super init:coordinator settings:settings];
    self.table.delegate = self;
    self.table.dataSource = self;
    UIImage *icon = [UIImage systemImageNamed: @"gear"];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Settings" image:icon tag:0];
    self.tabBarItem = item;
    self.navigationItem.title = @"Settings";
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.table reloadData];
}

@end


@implementation SettingsViewController (TableDelegate)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        AnimationSwitchCell *cell = [[AnimationSwitchCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"settingsCell"];
        [cell prepare: self.settings];
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"settingsCell"];
    cell.textLabel.text = @"Stroke color";
    cell.detailTextLabel.text = self.settings.colorHexName;
    cell.detailTextLabel.textColor = self.settings.drawColor;
    [self addArrowTo: cell];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.table deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.row != 0) {
        [self.coordinator goToColorsScreen];
    }
}

- (void) addArrowTo:(UITableViewCell *) cell {
    UIImage *arrow = [UIImage systemImageNamed:@"chevron.right"];
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:arrow];
    arrowView.tintColor = UIColor.lightGrayColor;
    arrowView.translatesAutoresizingMaskIntoConstraints = false;
    [cell.contentView addSubview:arrowView];
    [NSLayoutConstraint activateConstraints:@[
        [arrowView.centerYAnchor constraintEqualToAnchor:cell.contentView.centerYAnchor],
        [arrowView.rightAnchor constraintEqualToAnchor:cell.contentView.rightAnchor constant:-30]
    ]];
}

@end
