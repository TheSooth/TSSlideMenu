//
//  TSSlideMenuController.m
//  SlideMenu
//
//  Created by TheSooth on 9/26/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSSlideMenuController.h"
#import "TSSlideMenuDataProvider.h"
#import "TSSlideMenuDataSource.h"
#import "TSMenuItem.h"
#import "TSMenuSection.h"
#import "TSSlideMenuBaseConfiguration.h"
#import "TSDimmedView.h"
#import "TSMenuTableView.h"

static const NSInteger kAlphaDivideCoefficient = 500;

@interface TSSlideMenuController () <TSDataSourceDelegate>

@property (nonatomic, strong) TSSlideMenuDataProvider *dataProvider;
@property (nonatomic, strong) TSSlideMenuDataSource *dataSource;

@property (nonatomic, strong) NSMutableArray *sections;

@property (nonatomic, strong) TSMenuTableView *tableView;

@property (nonatomic, strong) UIBarButtonItem *menuBarButton;

@property (nonatomic, strong) UINavigationController *contentController;

@property (nonatomic, assign) BOOL menuIsVisible;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, assign) CGFloat animationDuration;

@property (nonatomic, strong) TSDimmedView *dimmedView;

@end

@implementation TSSlideMenuController

- (id)init
{
    self = [super init];
    if (self) {
        self.sections = [NSMutableArray new];
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

#pragma mark -
#pragma mark - Configuration

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupConfiguration];
    [self setupTableView];
    
    [self.dataProvider commitSections:self.sections];
    
    [self setupNavigationItem];
    
    [self setupContentController];
    [self presentFirstController];
    
    [self.view addSubview:self.tableView];
    
    self.dimmedView = [[TSDimmedView alloc] initWithFrame:self.view.bounds];
    self.dimmedView.alpha = 0;
}

- (void)setupConfiguration
{
    TSSlideMenuBaseConfiguration *confiugration = [TSSlideMenuBaseConfiguration sharedConfiguration];
    if (!confiugration) {
        confiugration = [TSSlideMenuBaseConfiguration defaultConfiguration];
        [TSSlideMenuBaseConfiguration setSharedConfiguration:confiugration];
    }
    
    self.animationDuration = [[confiugration valueForConfigKey:TSMenuAnimationDurationCKey] floatValue];
}

- (void)setupTableView
{
    TSSlideMenuBaseConfiguration *configuration = [TSSlideMenuBaseConfiguration sharedConfiguration];
    
    CGFloat tableViewWidth = [[configuration valueForConfigKey:TSMenuWidthCKey] floatValue];
    CGFloat tableHeight = [[configuration valueForConfigKey:TSMenuHeightCKey] floatValue];
    CGFloat tableOffsetByY = [[configuration valueForConfigKey:TSMenuOffsetByYCKey] floatValue];
    
    self.tableView = [[TSMenuTableView alloc] initWithFrame:CGRectMake(-tableViewWidth, tableOffsetByY, tableViewWidth, tableHeight) style:UITableViewStylePlain];
    self.tableView.cornerRadius = [[configuration valueForConfigKey:TSMenuCornerRadiusCKey] floatValue];
    
    self.dataProvider = [TSSlideMenuDataProvider new];
    self.dataSource = [TSSlideMenuDataSource new];
    
    self.dataSource.contentView = self.tableView;
    self.dataSource.dataProvider = self.dataProvider;
    self.dataSource.delegate = self;
    
    self.tableView.backgroundColor = [configuration valueForConfigKey:TSMenuBackgroundCKey];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *backgroundView = [configuration valueForConfigKey:TSMenuBackgroundViewCKey];
    
    if (backgroundView) {
        self.tableView.backgroundView = backgroundView;
    }
    
    BOOL shouldShowScrollIndicators = [configuration valueForConfigKey:TSMenuShouldShowScrollIndicatorsCKey];
    
    self.tableView.showsHorizontalScrollIndicator = shouldShowScrollIndicators;
    self.tableView.showsVerticalScrollIndicator = shouldShowScrollIndicators;
}

- (void)setupNavigationItem
{
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *menuIconName = [[TSSlideMenuBaseConfiguration sharedConfiguration] valueForConfigKey:TSMenuIconCKey];
    UIImage *menuIcon = [UIImage imageNamed:menuIconName];
    
    [menuButton addTarget:self action:@selector(presentSlideMenu) forControlEvents:UIControlEventTouchUpInside];
    
    [menuButton setBackgroundImage:menuIcon forState:UIControlStateNormal];
    menuButton.frame = CGRectMake(0, 0, menuIcon.size.width, menuIcon.size.height);
    
    self.menuBarButton = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
}

- (void)setupContentController
{
    self.contentController = [UINavigationController new];
    
    [self.view addSubview:self.contentController.view];
}

- (void)presentFirstController
{
    TSMenuSection *firstSection = self.sections[0];
    TSMenuItem *firstItem = [firstSection objectForRow:0];
    
    [self presentViewController:firstItem.menuItemViewController];
}

#pragma mark -
#pragma mark - Adding view controllers

- (void)addViewController:(UIViewController *)aViewController withTitle:(NSString *)aTitle
{
    [self addViewController:aViewController withTitle:aTitle imageName:nil];
}

- (void)addViewController:(UIViewController *)aViewController withTitle:(NSString *)aTitle imageName:(NSString *)aImageName
{
    TSMenuItem *menuItem = [TSMenuItem new];
    
    [menuItem addController:aViewController itemTitle:aTitle itemImageName:aImageName];
    
    [self addMenuItemToLastSection:menuItem];
}

- (void)addViewControllerClass:(Class)aViewControllerClass withTitle:(NSString *)aTitle
{
    [self addViewControllerClass:aViewControllerClass withTitle:aTitle imageName:nil];
}

- (void)addViewControllerClass:(Class)aViewControllerClass withTitle:(NSString *)aTitle imageName:(NSString *)aImageName
{
    TSMenuItem *menuItem = [TSMenuItem new];
    
    [menuItem addControllerClass:aViewControllerClass withTitle:aTitle itemImageName:aImageName];
    
    [self addMenuItemToLastSection:menuItem];
}

- (void)addCallbackBlock:(void(^)(void))aCallbackBlock withTitle:(NSString *)aTitle
{
    [self addCallbackBlock:aCallbackBlock withTitle:aTitle imageName:nil];
}

- (void)addCallbackBlock:(void(^)(void))aCallbackBlock withTitle:(NSString *)aTitle imageName:(NSString *)aImageName
{
    TSMenuItem *menuItem = [TSMenuItem new];
    
    [menuItem addCallbackBlock:aCallbackBlock withTitle:aTitle itemImageName:aImageName];
    
    [self addMenuItemToLastSection:menuItem];
}

- (void)addMenuItemToLastSection:(TSMenuItem *)aMenuItem
{
    TSMenuSection *section = nil;
    
    if (self.sections.count > 0) {
        section = self.sections.lastObject;
    } else {
        section = [TSMenuSection new];
        
        [self.sections addObject:section];
    }
    
    [section addMenuItem:aMenuItem];
}

- (void)addSectionWithTitle:(NSString *)aTitle
{
    TSMenuSection *menuSection = [TSMenuSection new];
    menuSection.sectionTitle = aTitle;
    
    [self.sections addObject:menuSection];
}

#pragma mark -
#pragma mark - Menu Logic

- (void)presentViewController:(UIViewController *)aViewController
{
    self.contentController.viewControllers = @[aViewController];
    aViewController.navigationItem.leftBarButtonItem = self.menuBarButton;
}

#pragma mark -
#pragma mark - SlideMenu actions

- (void)presentSlideMenu
{
    __weak typeof(self) weakSelf = self;
    [self.view insertSubview:self.dimmedView belowSubview:self.tableView];
    
    [self performPresentMenuAnimationWithCompletionBlock:^{
        weakSelf.menuIsVisible = YES;
        [weakSelf.tableView setScrollsToTop:YES];
        [weakSelf setupPanGesture];
    }];
}

- (void)hideSlideMenu
{
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        CGRect tableFrame = weakSelf.tableView.frame;
        tableFrame.origin.x = -CGRectGetWidth(tableFrame);
        weakSelf.dimmedView.alpha = 0.f;
        [self.dimmedView removeFromSuperview];
        weakSelf.tableView.frame = tableFrame;
    } completion:^(BOOL finished) {
        weakSelf.menuIsVisible = NO;
    }];
}

- (void)performPresentMenuAnimationWithCompletionBlock:(void(^)(void))aCompletionBlock
{
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        CGRect frame = self.tableView.frame;
        frame.origin.x = 0;
        weakSelf.tableView.frame = frame;
        weakSelf.dimmedView.alpha = 0.58f;
    } completion:^(BOOL finished) {
        if (aCompletionBlock) {
            aCompletionBlock();
        }
    }];
}

#pragma mark -
#pragma mark - PanGesture

- (void)setupPanGesture
{
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.panGesture setMaximumNumberOfTouches:2];
    
    [self.view addGestureRecognizer:self.panGesture];
}

- (void)removePanGesture
{
    [self.view removeGestureRecognizer:self.panGesture];
}


- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    if (!self.menuIsVisible) {
        return;
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self.tableView.superview];
        CGPoint center = CGPointMake(self.tableView.center.x + translation.x, self.tableView.center.y);
        
        self.tableView.center = center;
        
		if (self.tableView.frame.origin.x > 0) {
            CGRect currentFrame = self.tableView.frame;
            currentFrame.origin.x = 0;
            
            self.tableView.frame = currentFrame;
		}
        
        self.dimmedView.alpha = (CGRectGetMinX(self.tableView.frame) + CGRectGetWidth(self.tableView.frame))  / kAlphaDivideCoefficient;
        
        [gesture setTranslation:CGPointZero inView:self.tableView.superview];
    } else if ([gesture state] == UIGestureRecognizerStateEnded) {
        if (CGRectGetMinX(self.tableView.frame) <= -(CGRectGetWidth(self.tableView.frame) / 2)) {
            [self hideSlideMenu];
        } else {
            [self performPresentMenuAnimationWithCompletionBlock:nil];
        }
	}
}

#pragma mark -
#pragma mark - DataSource delegate

- (void)didSelectObject:(TSMenuItem *)aObject
{
    NSParameterAssert(self.contentController);
    
    [self hideSlideMenu];
    if (aObject.callbackBlock) {
        aObject.callbackBlock();
    } else {
        [self presentViewController:aObject.menuItemViewController];
    }
}

@end
