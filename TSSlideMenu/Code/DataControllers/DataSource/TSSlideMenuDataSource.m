//
//  TSDataSource.m
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSSlideMenuDataSource.h"
#import "TSSlideMenuCell.h"
#import "TSMenuItem.h"
#import "TSMenuSection.h"
#import "TSMenuSectionHeader.h"
#import "TSSlideMenuBaseConfiguration.h"

@implementation TSSlideMenuDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [[[TSSlideMenuBaseConfiguration sharedConfiguration] valueForConfigKey:TSMenuHeaderHeightCKey] floatValue];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataProvider.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataProvider numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSSlideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:[TSSlideMenuCell reusableIdentifier]];
    
    if (!cell) {
        cell = [[TSSlideMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[TSSlideMenuCell reusableIdentifier]];
    }
    
    TSMenuItem *menuItem = [self.dataProvider objectForIndexPath:indexPath];
    
    cell.textLabel.text = menuItem.itemTitle;
    
    if (menuItem.itemImageName) {
        cell.imageView.image = [UIImage imageNamed:menuItem.itemImageName];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TSMenuSection *menuSection = [self.dataProvider sectionAtIndex:section];
    
    if (menuSection.sectionTitle) {
        return menuSection.sectionTitle;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    
    TSMenuSectionHeader *header = nil;
    
    if (sectionTitle) {
        header = [TSMenuSectionHeader new];
        [header setTitle:sectionTitle];
    }
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectObject:)]) {
        id aObject = [self.dataProvider objectForIndexPath:indexPath];
        NSParameterAssert(aObject);
        [self.delegate didSelectObject:aObject];
    }
}

- (void)setContentView:(UITableView *)contentView
{
    NSParameterAssert(contentView);
    
    contentView.dataSource = self;
    contentView.delegate = self;
    
    _contentView = contentView;
}

@end
