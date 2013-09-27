//
//  TSMenuTableView.m
//  SlideMenu
//
//  Created by TheSooth on 9/27/13.
//  Copyright (c) 2013 TheSooth. All rights reserved.
//

#import "TSMenuTableView.h"

@implementation TSMenuTableView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                         cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;	
    self.layer.mask = maskLayer;
}

@end
