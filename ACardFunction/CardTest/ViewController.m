//
//  CardScrollViewController.m
//  test
//
//  Created by wangyapu on 16/4/12.
//  Copyright © 2016年 wangyapu. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "CardModel.h"
#import "CardView.h"
#import "DishModel.h"
@interface ViewController ()
@property (nonatomic , strong) UIScrollView * scrollView;
/**
 *  Array to contain card view
 */
@property (nonatomic , strong) NSMutableArray * cardsArray;

@property (nonatomic , strong) NSMutableArray * constraints;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    [self addCards];
}


- (void)addCards{
    NSArray *colors = @[
                        [UIColor colorWithRed:0.62 green:0.89 blue:0.68 alpha:1.00],
                        [UIColor colorWithRed:0.29 green:0.68 blue:0.66 alpha:1.00],
                        [UIColor colorWithRed:0.33 green:0.47 blue:0.50 alpha:1.00]];
    
    
    NSMutableArray *models = [self makeFakeModels];
    
    for (int i = 0; i < 3; i++) {
        
        CardView *cardView = [CardView new];
        cardView.backgroundColor = colors[i];
        cardView.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
        cardView.layer.shadowOffset = CGSizeMake(0,-1);//偏移距离
        cardView.layer.shadowOpacity = 0.8;//不透明度
        cardView.layer.shadowRadius = 10.0;//半径
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCard:)];
        [cardView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:cardView];
        [self.cardsArray addObject:cardView];
        [self.scrollView sendSubviewToBack:cardView];
        
        cardView.cardModel = models[i];
    }
    
    // The initial layout of cards(without animation)
    [self layoutCardsWithSelectedCard:nil animation:NO];
    
    
}


/**
 *  The tap gesture handle
 */
- (void)tapCard:(UIGestureRecognizer *)tap{
    CardView *senderView = (CardView *)tap.view;
    if (!senderView.fold) {
        [self layoutCardsWithSelectedCard:nil animation:YES];
    }else{
        [self layoutCardsWithSelectedCard:senderView animation:YES];
    }
    
}

/**
 *  The method of layout cards with or without animation
 *
 *  @param selectedCard    The card which has been selected
 *  @param animation       Boolen value to decide animation or not
 */
- (void)layoutCardsWithSelectedCard:(UIView *)selectedCard animation:(BOOL)animation{
    UIView *lastCard ;
    self.constraints = [NSMutableArray arrayWithCapacity:1];
    
    for (int i = 0; i < self.cardsArray.count; i++) {
        
        CardView *card = _cardsArray[i];
        NSNumber *height;
        if (!selectedCard) {
            height = @100;
        }else{
            height = @50;
        }
        
        if ([selectedCard isEqual:card]) {
            height = @400;
            card.fold = NO;
        }else{
            card.fold = YES;
        }
        
        
        if (!lastCard) {
            [_constraints addObject: [card mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).with.offset(0);
                make.left.equalTo(self.view.mas_left).with.offset(0);
                make.right.equalTo(self.view.mas_right).with.offset(0);
                make.height.mas_equalTo(height);
            }]];
            lastCard = card;
        }else{
            [_constraints addObject: [card mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastCard.mas_bottom).with.offset(0);
                make.left.equalTo(self.view.mas_left).with.offset(0);
                make.right.equalTo(self.view.mas_right).with.offset(0);
                make.height.mas_equalTo(height);
            }]];
            lastCard = card;
        }
        
        
        
        
    }
    if (animation) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}



- (NSMutableArray *)makeFakeModels{
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *titles = [@[@"Entrees",@"Plats chauds",@"Desserts"]mutableCopy];
    NSMutableArray *icons = [@[
                               [UIImage imageNamed:@"Entree"],
                               [UIImage imageNamed:@"Plats"],
                               [UIImage imageNamed:@"Dessert"]
                               ]mutableCopy];
    for (int i = 0; i < 3; i++) {
        CardModel * card = [[CardModel alloc]init];
        card.title = titles[i];
        card.icon = icons[i];
        NSMutableArray * dishes = [NSMutableArray arrayWithCapacity:1];
        for (int j = 0; j < 4; j++) {
            DishModel * dish = [[DishModel alloc]init];
            dish.name = [NSString stringWithFormat:@"Dish number %d %d",i,j];
            [dishes addObject:dish];
        }
        card.dishes = dishes;
        [models addObject:card];
    }
    return models;
}


#pragma -mark setter and getter

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor colorWithRed:0.9 green:1.0 blue:0.76 alpha:1];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height+5);
        
    }
    return _scrollView;
}

- (NSMutableArray *)cardsArray{
    if (!_cardsArray) {
        _cardsArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _cardsArray ;
}
@end
