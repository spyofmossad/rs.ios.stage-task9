//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 31.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "ColorsViewController.h"
#import "ColorCell.h"
#import "RSSchool_T9-Swift.h"

@interface ColorsViewController ()

@end

@interface ColorsViewController (TableDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ColorsViewController

- (instancetype)init:(AppCoordinator *)coordinator settings:(StoriesSettings *)settings {
    self = [super init:coordinator settings:settings];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:ColorCell.self forCellReuseIdentifier:@"colorCell"];
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self switchTableScrolling];
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self switchTableScrolling];
}

-(void)switchTableScrolling {
    if (UIDevice.currentDevice.orientation == UIDeviceOrientationPortrait && self.table.contentSize.height < self.view.bounds.size.height) {
        self.table.scrollEnabled = false;
    } else {
        self.table.scrollEnabled = true;
    }
}

@end

@implementation ColorsViewController (TableDelegate)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ColorCell *cell = [self.table dequeueReusableCellWithIdentifier:@"colorCell" forIndexPath:indexPath];
    cell.textLabel.text = self.settings.availableColors[indexPath.row];
    cell.textLabel.textColor = [[UIColor alloc] initWithHexString: self.settings.availableColors[indexPath.row]];
    if (cell.textLabel.text == self.settings.colorHexName) {
        cell.checkMark.hidden = false;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settings.availableColors.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.table deselectRowAtIndexPath:indexPath animated:true];
    for (ColorCell *cell in self.table.visibleCells) {
        cell.checkMark.hidden = true;
    }
    ((ColorCell *)self.table.visibleCells[indexPath.row]).checkMark.hidden = false;
    self.settings.colorHexName = self.table.visibleCells[indexPath.row].textLabel.text;
    [self.coordinator close];
}

@end
