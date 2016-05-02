//
//  CardView.m
//  CardTest
//
//  Created by wangyapu on 16/4/13.
//  Copyright © 2016年 Yapu. All rights reserved.
//

#import "CardView.h"
#import "Masonry.h"
#import "CardModel.h"
@interface CardView ()
@property (nonatomic , strong) UIImageView * iconView;
@property (nonatomic , strong) UILabel *titleLabel;
@end

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconView];
        [self addSubview:self.titleLabel];
        
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(20);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconView.mas_right).with.offset(20);
            make.centerY.equalTo(self);
        }];
        
    }
    return self;
}


- (void)foldMethod{
    [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).with.offset(20);
        make.centerY.equalTo(self);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}



- (void)unfoldMethod{
    [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_iconView.mas_bottom).with.offset(10);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
    
}

#pragma mark- setter and getter
- (void)setCardModel:(CardModel *)cardModel{
    _cardModel = cardModel;
    self.iconView.image = _cardModel.icon;
    self.titleLabel.text = _cardModel.title;
}
- (void)setFold:(BOOL)fold{
    _fold = fold;
    if (_fold) {
        [self foldMethod];
    }else{
        [self unfoldMethod];
    }
}


- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [UIImageView new];
        
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:26];
        _titleLabel.textColor = [UIColor colorWithRed:0.37 green:0.53 blue:0.40 alpha:1.00];
        
    }
    return _titleLabel;
}
@end
