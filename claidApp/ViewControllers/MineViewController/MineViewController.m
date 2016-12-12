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
    [self configureViews];
    [self switchEditInit];
}
- (void)switchEditInit {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"switch"] isEqualToString:@"YES"]){
        [self.ziDongSwitch setOn:YES];
        [self zidongAction:self.ziDongSwitch];
    } else {
        [self.ziDongSwitch setOn:NO];
    }
}

- (IBAction)zidongAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        SingleTon *ton = [SingleTon sharedInstance];
        NSString *uuidstr = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifierStr"];
        
        if (!uuidstr) {
            [self promptInformationActionWarningString:@"没有本地保存的蓝牙!"];
            NSLog(@"没有本地保存外设identifierStr");
            return;
        }
        
        [ton getPeripheralWithIdentifierAndConnect:uuidstr];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"switch"];
    } else {
        [self.ton.manager stopScan];  //停止  扫描
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"switch"];
    }

    
}

//出现的时候调用
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
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
