//
//  TSMenuSectionHeader.m
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSMenuSectionHeader.h"

@interface TSMenuSectionHeader ()

@property (nonatomic, strong) UILabel *sectionTitleLabel;

@end

@implementation TSMenuSectionHeader

- (id)init
{
    self = [super init];
    if (self) {
        [self setupTitleLabel];
    }
    return self;
}

- (void)setupTitleLabel
{
    self.sectionTitleLabel = [UILabel new];
    self.sectionTitleLabel.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.sectionTitleLabel];
}

- (void)setTitle:(NSString *)aTitle
{
    NSParameterAssert(aTitle);
    
    self.sectionTitleLabel.text = aTitle;
}

- (void)layoutSubviews
{
    self.sectionTitleLabel.frame = self.bounds;
}

@end
