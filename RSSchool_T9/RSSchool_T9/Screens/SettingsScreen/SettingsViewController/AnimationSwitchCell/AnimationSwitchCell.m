//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 31.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "AnimationSwitchCell.h"
#import "RSSchool_T9-Swift.h"

@interface AnimationSwitchCell()

@property (nonatomic) StoriesSettings *settings;
@property (nonatomic) UISwitch *animationSwitcher;

@end

@implementation AnimationSwitchCell

- (UISwitch *) animationSwitcher {
    if (_animationSwitcher != nil) {
        return _animationSwitcher;
    }
    UISwitch *switcher = [[UISwitch alloc] init];
    switcher.translatesAutoresizingMaskIntoConstraints = false;
    [switcher addTarget:self action:@selector(switchOnTap) forControlEvents:UIControlEventValueChanged];
    _animationSwitcher = switcher;
    [self addSubview: _animationSwitcher];
    return _animationSwitcher;
}

- (void) prepare:(StoriesSettings *)settings {
    self.settings = settings;
    self.textLabel.text = @"Draw stories";
    [self.animationSwitcher setOn: settings.isAnimated];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.animationSwitcher.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.animationSwitcher.rightAnchor constraintEqualToAnchor:self.rightAnchor constant: -30]
    ]];
}

- (void) switchOnTap {
    self.settings.isAnimated = self.animationSwitcher.isOn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
}

- (BOOL)isHighlighted {
    return false;
}

@end
