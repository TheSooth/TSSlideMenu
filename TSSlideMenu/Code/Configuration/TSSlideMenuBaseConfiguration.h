//
//  TSSlideMenuBaseConfiguration.h
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSSlideMenuConfigurationKeys.h"

@interface TSSlideMenuBaseConfiguration : NSObject

+ (instancetype)sharedConfiguration;

+ (instancetype)defaultConfiguration;

+ (void)setSharedConfiguration:(TSSlideMenuBaseConfiguration *)aSharedConfiguration;

- (void)setValue:(id)aValue forConfigKey:(NSString *)aConfigKey;

- (id)valueForConfigKey:(NSString *)aConfigKey;

@end
