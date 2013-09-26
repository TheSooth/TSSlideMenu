//
//  TSDataSource.h
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSSlideMenuDataProvider.h"
#import "TSDataSourceDelegate.h"

@interface TSSlideMenuDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TSSlideMenuDataProvider *dataProvider;

@property (nonatomic, weak) id <TSDataSourceDelegate> delegate;

@property (nonatomic, weak) UITableView *contentView;

@end
