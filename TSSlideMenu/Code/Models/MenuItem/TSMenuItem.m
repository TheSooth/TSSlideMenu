//
//  TSMenuItem.m
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSMenuItem.h"

@interface TSMenuItem ()

@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, unsafe_unretained) Class controllerClass;

@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemImageName;

@end

@implementation TSMenuItem

- (void)addController:(UIViewController *)aController itemTitle:(NSString *)aItemTitle itemImageName:(NSString *)aImageName
{
    [self addController:aController itemTitle:aItemTitle];
    
    self.itemImageName = aImageName;
}

- (void)addController:(UIViewController *)aController itemTitle:(NSString *)aItemTitle
{
    NSParameterAssert(aController);
    NSParameterAssert(aItemTitle);
    
    NSParameterAssert([aController isKindOfClass:[UIViewController class]]);
    
    self.viewController = aController;
    self.itemTitle = aItemTitle;
}

- (void)addControllerClass:(Class)aControllerClass withTitle:(NSString *)aItemTitle itemImageName:(NSString *)aImageName
{
    [self addControllerClass:aControllerClass withTitle:aItemTitle];
    
    self.itemImageName = aImageName;
}

- (void)addControllerClass:(Class)aControllerClass withTitle:(NSString *)aItemTitle
{
    NSParameterAssert(aControllerClass);
    NSParameterAssert(aItemTitle);
    NSParameterAssert([aControllerClass isSubclassOfClass:[UIViewController class]] || aControllerClass == [UIViewController class]);
    
    self.controllerClass = aControllerClass;
    self.itemTitle = aItemTitle;
}

- (UIViewController *)menuItemViewController
{
    if (self.viewController) {
        return self.viewController;
    } else if (self.controllerClass) {
        self.viewController = [self.controllerClass new];
        return self.viewController;
    }
    
    assert(false);
}


@end
