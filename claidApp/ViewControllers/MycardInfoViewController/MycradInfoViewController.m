//
//  MycradInfoViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/5/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MycradInfoViewController.h"
#import "MycradInfoViewController+Configuration.h"

@implementation MycradInfoViewController

+ (instancetype) create {
    MycradInfoViewController *mycradinfoVC = [[MycradInfoViewController alloc] initWithNibName:@"MycradInfoViewController" bundle:nil];
    return mycradinfoVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)myinforeturnButtonAction:(id)sender {
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
