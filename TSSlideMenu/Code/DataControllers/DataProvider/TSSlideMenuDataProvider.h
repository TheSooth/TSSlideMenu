//
//  TSSlideMenuDataProvider.h
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDataProviderSection.h"

@interface TSSlideMenuDataProvider : NSObject

- (void)commitSections:(NSArray *)aSections;

- (id)objectForIndexPath:(NSIndexPath *)aIndexPath;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfItemsInSection:(NSInteger)aSection;

- (id <TSDataProviderSection>)sectionAtIndex:(NSInteger)aIndex;

@end
