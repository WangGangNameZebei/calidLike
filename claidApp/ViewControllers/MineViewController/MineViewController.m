//
//  MineViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MineViewController.h"
#import "MineViewController+Configuration.h"
#import "MineViewController+Animation.h"
@implementation MineViewController

+ (instancetype)create {
    MineViewController *minViewController = [[MineViewController alloc] initWithNibName:@"MineViewController" bundle:nil];
    return minViewController;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self switchEditInit];
    [self configureViews];
  
}
- (void)switchEditInit {
    if ([[self userInfoReaduserkey:@"switch"] isEqualToString:@"YES"]){
        NSString *strUUid = SINGLE_TON_UUID_STR;
        if (!strUUid) {
            [self.ton startScan]; // 扫描
            return;
        }
        [self.ton getPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];
    }
}

//出现的时候调用
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[self userInfoReaduserkey:@"districtName"] isEqualToString:@""]){
        self.ziDongLabei.text = @"当前小区  ：   无";
    } else {
        self.ziDongLabei.text = [NSString stringWithFormat:@"当前小区  ：   %@",[self userInfoReaduserkey:@"districtName"]];
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
