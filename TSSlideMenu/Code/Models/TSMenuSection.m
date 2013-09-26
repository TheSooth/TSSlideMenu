//
//  TSMenuSection.m
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSMenuSection.h"

@interface TSMenuSection ()

@property (nonatomic, strong) NSMutableArray *itemsArray;

@end

@implementation TSMenuSection

@synthesize sectionTitle;

- (id)init
{
    self = [super init];
    if (self) {
        self.itemsArray = [NSMutableArray new];
    }
    return self;
}


- (void)addMenuItem:(TSMenuItem *)aMenuItem
{
    [self.itemsArray addObject:aMenuItem];
}

- (TSMenuItem *)objectForRow:(NSInteger)aRow
{
    NSParameterAssert(aRow <= self.itemsArray.count - 1);
    
    return self.itemsArray[aRow];
}

- (NSInteger)numberOfItems
{
    return self.itemsArray.count;
}

@end
