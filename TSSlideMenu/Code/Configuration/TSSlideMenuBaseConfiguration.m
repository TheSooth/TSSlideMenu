//
//  TSSlideMenuBaseConfiguration.m
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSSlideMenuBaseConfiguration.h"

static TSSlideMenuBaseConfiguration *sharedConfiguration = nil;

@interface TSSlideMenuBaseConfiguration ()

@property (nonatomic, strong) NSMutableDictionary *configurationHash;

@end

@implementation TSSlideMenuBaseConfiguration

+ (instancetype)defaultConfiguration
{
    TSSlideMenuBaseConfiguration *slideConfiguration = [self new];
    
    [slideConfiguration setValue:@"menu_icon" forConfigKey:TSMenuIconCKey];
    [slideConfiguration setValue:@(0) forConfigKey:TSMenuHeaderHeightCKey];
    [slideConfiguration setValue:@(44) forConfigKey:TSMenuItemHeightCKey];
    [slideConfiguration setValue:@(0) forConfigKey:TSMenuHeaderHeightCKey];
    [slideConfiguration setValue:[UIFont systemFontOfSize:16.f] forConfigKey:TSMenuItemFontCKey];
    [slideConfiguration setValue:[UIColor whiteColor] forConfigKey:TSMenuItemFontColorCKey];
    [slideConfiguration setValue:[UIColor colorWithRed:67.f / 255.f green:71.f / 255.f blue:78.f / 255.f alpha:1.f] forConfigKey:TSMenuItemBackgroundColorCKey];
    [slideConfiguration setValue:[UIColor colorWithRed:42.f / 255.f green:46.f / 255.f blue:54.f / 255.f alpha:1.f] forConfigKey:TSMenuItemSelectedBackgroundColorCKey];
    [slideConfiguration setValue:@(280) forConfigKey:TSMenuWidthCKey];
    [slideConfiguration setValue:@(460) forConfigKey:TSMenuHeightCKey];
    [slideConfiguration setValue:@(.25f) forConfigKey:TSMenuAnimationDurationCKey];
    [slideConfiguration setValue:[UIColor colorWithRed:67.f / 255.f green:71.f / 255.f blue:78.f / 255.f alpha:1.f] forConfigKey:TSMenuBackgroundCKey];
    
    [slideConfiguration setValue:@"menu_item_bottom_divider" forConfigKey:TSMenuItemBottomDividerImageNameCKey];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
        [slideConfiguration setValue:@(20) forConfigKey:TSMenuOffsetByYCKey];
    
    return slideConfiguration;
}

+ (instancetype)sharedConfiguration
{
    return sharedConfiguration;
}

+ (void)setSharedConfiguration:(TSSlideMenuBaseConfiguration *)aSharedConfiguration
{
    NSParameterAssert(aSharedConfiguration);
    NSParameterAssert([aSharedConfiguration isKindOfClass:[TSSlideMenuBaseConfiguration class]]);
    
    sharedConfiguration = aSharedConfiguration;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.configurationHash = [NSMutableDictionary new];
    }
    return self;
}

- (void)setValue:(id)aValue forConfigKey:(NSString *)aConfigKey
{
    NSParameterAssert(aValue);
    [self checkConfigKey:aConfigKey];
    
    [self.configurationHash setValue:aValue forKey:aConfigKey];
}

- (id)valueForConfigKey:(NSString *)aConfigKey
{
    [self checkConfigKey:aConfigKey];
    
    id value = self.configurationHash[aConfigKey];
    
    NSParameterAssert(aConfigKey);
    
    return value;
}

- (void)checkConfigKey:(NSString *)aKey
{
    NSParameterAssert(aKey);
    
    NSString *configKeySuffix = @"CKey";
    NSString *keySuffix = [aKey substringWithRange:NSMakeRange(aKey.length - configKeySuffix.length, configKeySuffix.length)];
    
    NSParameterAssert([configKeySuffix isEqualToString:keySuffix]);
    
}

@end
