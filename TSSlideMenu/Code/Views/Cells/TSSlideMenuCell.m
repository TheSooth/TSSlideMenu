//
//  TSSlideMenuCell.m
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSSlideMenuCell.h"
#import "TSSlideMenuBaseConfiguration.h"

@implementation TSSlideMenuCell

+ (NSString *)reusableIdentifier
{
    return NSStringFromClass([self class]);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [UIView new];
        self.selectedBackgroundView = [UIView new];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    TSSlideMenuBaseConfiguration *configuration = [TSSlideMenuBaseConfiguration sharedConfiguration];
    
    self.backgroundColor = [configuration valueForConfigKey:TSMenuItemBackgroundColorCKey];
    self.backgroundView.backgroundColor = [configuration valueForConfigKey:TSMenuItemBackgroundColorCKey];
    self.selectedBackgroundView.backgroundColor = [configuration valueForConfigKey:TSMenuItemSelectedBackgroundColorCKey];
    self.textLabel.font = [configuration valueForConfigKey:TSMenuItemFontCKey];
    self.textLabel.textColor = [configuration valueForConfigKey:TSMenuItemFontColorCKey];
}

@end
