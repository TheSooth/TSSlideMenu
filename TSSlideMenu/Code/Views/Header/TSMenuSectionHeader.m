//
//  TSMenuSectionHeader.m
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSMenuSectionHeader.h"
#import "TSSlideMenuBaseConfiguration.h"

@interface TSMenuSectionHeader ()

@property (nonatomic, strong) UILabel *sectionTitleLabel;

@end

@implementation TSMenuSectionHeader

- (id)init
{
    self = [super init];
    if (self) {
        [self setupAppearance];
    }
    return self;
}

- (void)setupAppearance
{
    TSSlideMenuBaseConfiguration *configuration = [TSSlideMenuBaseConfiguration sharedConfiguration];
    
    self.backgroundColor = [configuration valueForConfigKey:TSMenuHeaderBackgroundColorCKey];
    
    self.sectionTitleLabel = [UILabel new];
    self.sectionTitleLabel.backgroundColor = [UIColor clearColor];
    self.sectionTitleLabel.font = [configuration valueForConfigKey:TSMenuHeaderFontCKey];
    self.sectionTitleLabel.textColor = [configuration valueForConfigKey:TSMenuHeaderFontColorCKey];
    
    [self addSubview:self.sectionTitleLabel];
}

- (void)setTitle:(NSString *)aTitle
{
    NSParameterAssert(aTitle);
    
    self.sectionTitleLabel.text = aTitle;
}

- (void)layoutSubviews
{
    TSSlideMenuBaseConfiguration *configuration = [TSSlideMenuBaseConfiguration sharedConfiguration];
    
    CGFloat offsetByX = [[configuration valueForConfigKey:TSMenuHeaderLabelOffsetCKey] floatValue];
    
    self.sectionTitleLabel.frame = CGRectMake(offsetByX, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

@end
