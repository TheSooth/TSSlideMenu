//
//  TSMenuItem.h
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TSMenuCallbackBlock)(void);

@interface TSMenuItem : NSObject

@property (nonatomic, strong, readonly) NSString *itemTitle;
@property (nonatomic, strong, readonly) NSString *itemImageName;

- (void)addController:(UIViewController *)aController itemTitle:(NSString *)aItemTitle itemImageName:(NSString *)aImageName;
- (void)addController:(UIViewController *)aController itemTitle:(NSString *)aItemTitle;

- (void)addControllerClass:(Class)aControllerClass withTitle:(NSString *)aItemTitle itemImageName:(NSString *)aImageName;
- (void)addControllerClass:(Class)aControllerClass withTitle:(NSString *)aItemTitle;

- (UIViewController *)menuItemViewController;

@end
