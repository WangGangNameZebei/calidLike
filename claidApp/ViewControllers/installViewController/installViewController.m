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
    self.lingminduBool = NO;
    self.selectIndexPath = indexPath;
    SingleTon *ton = [SingleTon sharedInstance];
   NSString *uuidstr = SINGLE_TON_UUID_STR;
    if (!uuidstr) {
        [ton startScan]; //扫描
        return;
    }
     [ton installShoudongConnectClick:SINGLE_TON_UUID_STR];
    
}

- (IBAction)installReturnButtonAction:(id)sender {
    [[SingleTon sharedInstance] disConnection];  //断开蓝牙
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)emptyButtonAction:(id)sender {
       [self.tool dropTableWithClass:[InstallCardData class]];
       [self refreshInstallTableView];
}

- (IBAction)scanLanyaButton:(id)sender {
    if ([self.installLanyaLabel.text isEqualToString:@"已连接"]){
        [self.sinTon disConnection];       // 退出前 断开蓝牙
    } else {
        NSString  *strLanya = FAKAQI_TON_UUID_STR;
        if (strLanya.length < 3) {
            [self.sinTon startScan]; // 扫描
        } else {
            [self.sinTon shoudongConnectClick:strLanya];
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
