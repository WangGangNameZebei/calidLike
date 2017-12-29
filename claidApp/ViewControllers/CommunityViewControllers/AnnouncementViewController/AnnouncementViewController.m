//
//  AnnouncementViewController.m
//  claidApp
//
//  Created by Zebei on 2017/12/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AnnouncementViewController.h"
#import "AnnouncementViewController+Configuration.h"

@implementation AnnouncementViewController

+ (instancetype)create {
    AnnouncementViewController *announcementViewController = [[AnnouncementViewController alloc] initWithNibName:@"AnnouncementViewController" bundle:nil];
    return announcementViewController;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (IBAction)returnButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    DSImageDemoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DSImageDemoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    [cell setLayout:self.layouts[indexPath.row]];
    return cell;
}
- (void)didClick:(DSImageBrowseView *)imageView atIndex:(NSInteger)index {
    
    NSLog(@"点击第%ld图片",index + 1);
    [self present:imageView index:index];
}

//缩略图的时候长按
- (void)longPress:(DSImageBrowseView *)imageView atIndex:(NSInteger)index {
    NSLog(@"长按第%ld图片",index + 1);
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
