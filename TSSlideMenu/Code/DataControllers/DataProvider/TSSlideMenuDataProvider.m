//
//  TSSlideMenuDataProvider.m
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSSlideMenuDataProvider.h"

@interface TSSlideMenuDataProvider ()

@property (nonatomic, strong) NSArray *sections;

@end

@implementation TSSlideMenuDataProvider

- (void)commitSections:(NSArray *)aSections
{
    self.sections = aSections;
}

- (id)objectForIndexPath:(NSIndexPath *)aIndexPath
{
    [self checkItemAtSection:aIndexPath.section];
    
    id <TSDataProviderSection> sectionItem = self.sections[aIndexPath.section];
    
    return [sectionItem objectForRow:aIndexPath.row];
}

- (NSInteger)numberOfSections
{
    return self.sections.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)aSection
{
    [self checkItemAtSection:aSection];
    
    id <TSDataProviderSection> sectionItem = self.sections[aSection];

    return [sectionItem numberOfItems];
}

- (id <TSDataProviderSection>)sectionAtIndex:(NSInteger)aIndex
{
    [self checkItemAtSection:aIndex];
    
    return self.sections[aIndex];
}

- (void)checkItemAtSection:(NSInteger)aSection
{
    NSParameterAssert(aSection <= self.sections.count - 1);
    
    id <TSDataProviderSection> sectionItem = self.sections[aSection];
    
    NSParameterAssert([sectionItem conformsToProtocol:@protocol(TSDataProviderSection)]);
}


@end
