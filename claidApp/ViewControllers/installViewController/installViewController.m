//
//  installViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewController.h"
#import "installViewController+Configuration.h"

@implementation installViewController

+ (instancetype) create {
    installViewController *installVC = [[installViewController alloc] initWithNibName:@"installViewController" bundle:nil];
    return installVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.setupBool){
        self.lingminduBool = NO;
        self.selectIndexPath = indexPath;
        NSString *message = @"0180010101FF3344556601000000000000000000000000000000000000000000000000000000000000";
        message = [NSString stringWithFormat:@"%@%@",@"cc",message];
        [self.sinTon iwsendCommand:message];       //发送数据
    }
   
}

- (IBAction)installReturnButtonAction:(id)sender {
    NSString *message = @"d0446973636f6e6e656374696e67000000000000";
    [self.sinTon iwsendCommand:message];       //发送数据
    [self.sinTon iwdisConnection];  //断开蓝牙
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)emptyButtonAction:(id)sender {
       [self.tool dropTableWithClass:[InstallCardData class]];
       [self refreshInstallTableView];
}

- (IBAction)scanLanyaButton:(id)sender {
    if ([self.installLanyaLabel.text isEqualToString:@"已连接"]){
        [self.sinTon iwdisConnection];       // 退出前 断开蓝牙
    } else {
        NSString  *strLanya = FAKAQI_TON_UUID_STR;
        if (strLanya.length < 3) {
            [self.sinTon iwstartScan]; // 扫描
        } else {
            [self.sinTon iwshoudongConnectClick:strLanya];
        }
    }
}
#pragma mark - Tasks
- (void)doSomeWork {
    // Simulate by just waiting.
    sleep(3.);
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
