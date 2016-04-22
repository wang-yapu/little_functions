//
//  MainTableViewController.m
//  UIButtonHighlightOnTableViewDemo
//
//  Created by wangyapu on 16/4/21.
//  Copyright © 2016年 Yapu. All rights reserved.
//

#import "ButtonHighlightedTableViewController.h"
#import "UIImage+Common.h"
#import <Masonry/Masonry.h>
#import "CustomTableView.h"
@interface ButtonHighlightedTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)CustomTableView  * tableView;
@end


#define CellIdentifier @"CellIdentifier"

@implementation ButtonHighlightedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 50;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 5, 200, 30);
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
    [button setTitle:@"快速点我 Click me fast!" forState:UIControlStateNormal];
    
    
    for (id obj in cell.subviews)
    {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"])
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            scroll.delaysContentTouches = NO;
            break;
        }
    }
    
    
    
    [cell.contentView addSubview:button];
    
    return cell;
}




- (CustomTableView *)tableView{
    if (!_tableView) {
        _tableView = [[CustomTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.and.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
    }
    return _tableView;
}

@end
