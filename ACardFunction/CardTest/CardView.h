//
//  CardView.h
//  CardTest
//
//  Created by wangyapu on 16/4/13.
//  Copyright © 2016年 Yapu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardModel;
@interface CardView : UIView
@property (nonatomic , strong) CardModel * cardModel;
@property (nonatomic , assign) BOOL fold;

@end
