//
//  CustomTableView.m
//  LittleFunctions
//
//  Created by wangyapu on 16/4/22.
//  Copyright © 2016年 Yapu. All rights reserved.
//

#import "CustomTableView.h"

@implementation CustomTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delaysContentTouches = NO;
        
        // iterate over all the UITableView's subviews
        for (id view in self.subviews)
        {
            // looking for a UITableViewWrapperView
            if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewWrapperView"])
            {
                // this test is necessary for safety and because a "UITableViewWrapperView" is NOT a UIScrollView in iOS7
                if([view isKindOfClass:[UIScrollView class]])
                {
                    // turn OFF delaysContentTouches in the hidden subview
                    UIScrollView *scroll = (UIScrollView *) view;
                    scroll.delaysContentTouches = NO;
                }
                break;
            }
        }
        
    }
    return self;
}



- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ([view isKindOfClass:[UIButton class]])
    {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

@end
