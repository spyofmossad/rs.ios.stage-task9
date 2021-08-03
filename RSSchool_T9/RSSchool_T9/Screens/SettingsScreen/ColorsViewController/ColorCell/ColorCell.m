//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Dzmitry Navitski
// On: 31.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "ColorCell.h"

@implementation ColorCell

- (UIImageView *) checkMark {
    if (_checkMark != nil) {
        return _checkMark;
    }
    UIImage *tick = [UIImage systemImageNamed:@"checkmark"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:tick];
    imageView.translatesAutoresizingMaskIntoConstraints = false;
    imageView.tintColor = UIColor.redColor;
    [self.contentView addSubview:imageView];
    [NSLayoutConstraint activateConstraints:@[
        [imageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [imageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-30],
    ]];
    
    _checkMark = imageView;
    return _checkMark;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.checkMark.hidden = true;
    return self;
}

@end
