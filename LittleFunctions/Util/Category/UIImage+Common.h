//
//  UIImage+Common.h
//  imfine
//
//  Created by wangyapu on 15/7/21.
//  Copyright (c) 2015年 wangyapu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)

+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


@end
