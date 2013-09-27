//
//  TSSlideMenuCell.m
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSSlideMenuCell.h"
#import "TSSlideMenuBaseConfiguration.h"

@interface TSSlideMenuCell ()

@property (nonatomic, strong) UIImageView *bottomDividerImageView;
@property (nonatomic, strong) UIImage *bottomDividerImage;

@end

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
        
        [self setupDividerImageView];
    }
    return self;
}

- (void)setupDividerImageView
{
    TSSlideMenuBaseConfiguration *configuration = [TSSlideMenuBaseConfiguration sharedConfiguration];
    
    self.bottomDividerImage = [UIImage imageNamed:[configuration valueForConfigKey:TSMenuItemBottomDividerImageNameCKey]];
    
    if (self.bottomDividerImage) {
        self.bottomDividerImageView = [UIImageView new];
        self.bottomDividerImageView.image = self.bottomDividerImage;
        
        [self addSubview:self.bottomDividerImageView];
    }
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
    
    if (self.bottomDividerImageView) {
        [self layoutDividerImageView];
    }
    
}

- (void)layoutDividerImageView
{
    self.bottomDividerImageView.frame = CGRectMake(0,
                                                   CGRectGetHeight(self.bounds) - self.bottomDividerImage.size.height,
                                                   CGRectGetWidth(self.bounds),
                                                   self.bottomDividerImage.size.height);
}

@end
