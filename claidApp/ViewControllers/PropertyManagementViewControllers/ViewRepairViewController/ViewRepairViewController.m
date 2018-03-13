//
//  ViewRepairViewController.m
//  claidApp
//
//  Created by Zebei on 2017/12/22.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ViewRepairViewController.h"
#import "ViewRepairViewController+Configuration.h"
#import "ViewRepairViewController+LogicalFow.h"

@implementation ViewRepairViewController

+ (instancetype)create {
    ViewRepairViewController *viewrepairVC = [[ViewRepairViewController alloc] initWithNibName:@"ViewRepairViewController" bundle:nil];
    return viewrepairVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewRepairTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VIEW_REPAIR_TABLEVIEW_CELL];
    cell.dealWithbutton.tag = indexPath.row;
    cell.refuseButton.tag = indexPath.row;
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
- (void)dealWithButton:(id)sender{
    UIButton *button = (UIButton *)sender;
    ViewRepairLayout *layoutData =self.layouts[button.tag];
    self.cellButtonTag =button.tag;
    self.cellButtonName = [button currentTitle];
    if([[button currentTitle] isEqualToString:@"处理"]) {
      [self getDataPostPropertyOperationsSubmittedid:layoutData.model.idtextString repairsStatus:2];
    } else if([[button currentTitle] isEqualToString:@"完成"]) {
      [self getDataPostPropertyOperationsSubmittedid:layoutData.model.idtextString repairsStatus:5];
    } else  {
        
    }
}
- (void)refuseWithButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    ViewRepairLayout *layoutData =self.layouts[button.tag];
    self.cellButtonTag =button.tag;
    self.cellButtonName = [button currentTitle];
    if([[button currentTitle] isEqualToString:@"拒绝"]) {
        [self getDataPostPropertyOperationsSubmittedid:layoutData.model.idtextString repairsStatus:3];
    }
}
@end
