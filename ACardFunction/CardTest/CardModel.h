//
//  CardModel.h
//  CardTest
//
//  Created by wangyapu on 16/4/13.
//  Copyright © 2016年 Yapu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CardModel : NSObject

@property (nonatomic , strong) UIImage * icon;
@property (nonatomic , copy) NSString * title;
@property (nonatomic , strong) NSMutableArray * dishes;
@end
