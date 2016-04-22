//
//  MainEnterTableViewController.m
//  LittleFunctions
//
//  Created by wangyapu on 16/4/22.
//  Copyright © 2016年 Yapu. All rights reserved.
//

#import "MainEnterTableViewController.h"
#import "ButtonHighlightedTableViewController.h"
@interface MainEnterTableViewController ()
@property (nonatomic , strong) NSMutableArray * itemsArray;
@end
#define CellIdentifier @"CellIdentifier"
@implementation MainEnterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = UIView.new;
    self.title = @"Demos";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.itemsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.itemsArray[indexPath.row];
    return cell;
}


#pragma mark  Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            ButtonHighlightedTableViewController *VC = ButtonHighlightedTableViewController.new;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        default:
            break;
    }
}




#pragma mark - getter and setter
#pragma mark getter
- (NSMutableArray *)itemsArray{
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray arrayWithCapacity:1];
        _itemsArray = [@[@"tableview上的button高亮状态立即响应"]mutableCopy];
    }
    return _itemsArray;
}

@end
