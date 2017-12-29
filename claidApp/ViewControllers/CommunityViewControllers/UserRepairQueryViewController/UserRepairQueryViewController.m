//
//  UserRepairQueryViewController.m
//  claidApp
//
//  Created by Zebei on 2017/12/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "UserRepairQueryViewController.h"
#import "UserRepairQueryViewController+Configuration.h"

@implementation UserRepairQueryViewController


+ (instancetype)create {
    UserRepairQueryViewController *userRepairQueryViewController = [[UserRepairQueryViewController alloc] initWithNibName:@"UserRepairQueryViewController" bundle:nil];
    return userRepairQueryViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserRepairTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:USER_REPAIR_TABLEVIEW_CELL];
    cell.delegate = self;
    [cell setLayout:self.layouts[indexPath.row]];
    return cell;
}
#pragma mark- cell DeleGate
- (void)didClick:(DSImageBrowseView *)imageView atIndex:(NSInteger)index {
    
    NSLog(@"点击第%ld图片",index + 1);
    [self present:imageView index:index];
}

//缩略图的时候长按
- (void)longPress:(DSImageBrowseView *)imageView atIndex:(NSInteger)index {
    NSLog(@"长按第%ld图片",index + 1);
}
- (IBAction)returnButtonAction:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
