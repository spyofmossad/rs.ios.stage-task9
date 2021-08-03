//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 31.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "CustomTableViewController.h"
#import "RSSchool_T9-Swift.h"

@interface CustomTableViewController ()

@end

@implementation CustomTableViewController

- (UITableView *) table {
    if (_table != nil) {
        return _table;
    }
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    table.translatesAutoresizingMaskIntoConstraints = false;
    table.scrollEnabled = false;
    table.rowHeight = 44;
    _table = table;
    
    return _table;
}

- (instancetype)init:(AppCoordinator *)coordinator settings:(StoriesSettings *)settings {
    self = [super initWithNibName:nil bundle:nil];
    self.coordinator = coordinator;
    self.settings = settings;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.table];
    [NSLayoutConstraint activateConstraints:@[
        [self.table.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.table.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.table.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [self.table.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

@end
