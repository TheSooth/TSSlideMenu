//
//  TSSlideMenuController.h
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSSlideMenuController : UIViewController

@property (nonatomic, strong, readonly) UINavigationController *contentController;

- (void)addViewController:(UIViewController *)aViewController withTitle:(NSString *)aTitle;
- (void)addViewController:(UIViewController *)aViewController withTitle:(NSString *)aTitle imageName:(NSString *)aImageName;

- (void)addViewControllerClass:(Class)aViewControllerClass withTitle:(NSString *)aTitle;
- (void)addViewControllerClass:(Class)aViewControllerClass withTitle:(NSString *)aTitle imageName:(NSString *)aImageName;

- (void)addCallbackBlock:(void(^)(void))aCallbackBlock withTitle:(NSString *)aTitle;
- (void)addCallbackBlock:(void(^)(void))aCallbackBlock withTitle:(NSString *)aTitle imageName:(NSString *)aImageName;

- (void)addSectionWithTitle:(NSString *)aTitle;

- (void)presentControllerWithClass:(Class)aClass presentedCallbackBlock:(void(^)(UIViewController *viewController))aCallbackBlock;

@end
