//
//  TSMenuSection.h
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDataProviderSection.h"

@class TSMenuItem;

@interface TSMenuSection : NSObject <TSDataProviderSection>

- (void)addMenuItem:(TSMenuItem *)aMenuItem;

@end
