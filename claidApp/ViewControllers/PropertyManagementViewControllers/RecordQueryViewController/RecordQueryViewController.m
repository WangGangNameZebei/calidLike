//
//  RecordQueryViewController.m
//  claidApp
//
//  Created by Zebei on 2017/11/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "RecordQueryViewController.h"
#import "RecordQueryViewController+Controller.h"
#import "UIScreen+Utility.h"

@implementation RecordQueryViewController
+(instancetype)create {
    RecordQueryViewController *recordQueryVC = [[RecordQueryViewController alloc] initWithNibName:@"RecordQueryViewController" bundle:nil];
    return recordQueryVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
- (IBAction)returnButtonAction:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)viewButtonAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 100){
        [self.recordQueryView addSubview:self.searchView];
        self.recordQueryViewheight.constant = 60;
    } else if (btn.tag == 200) {
        [self.searchView removeFromSuperview];
        self.recordQueryViewheight.constant = 32;
    } else {
       
    }
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
