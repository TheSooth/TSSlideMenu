//
//  TSDataProviderItem.h
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TSDataProviderSection <NSObject>

@property (nonatomic, strong) NSString *sectionTitle;

- (id)objectForRow:(NSInteger)aRow;

- (NSInteger)numberOfItems;

@end
