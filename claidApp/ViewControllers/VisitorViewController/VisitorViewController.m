//
//  VisitorViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/1/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "VisitorViewController.h"
#import "VisitorViewController+Configuration.h"
#import "LanyaViewController.h"


@implementation VisitorViewController

+ (instancetype) create {
    VisitorViewController *visitorVC = [[VisitorViewController alloc] initWithNibName:@"VisitorViewController" bundle:nil];
    return visitorVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (IBAction)returnButtonAction:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)plusLanyaButtonAction:(id)sender {
    LanyaViewController *lanyaVC = [LanyaViewController create];
    [self hideTabBarAndpushViewController:lanyaVC];
}

- (IBAction)submitButtonAction:(id)sender {
    
}

- (IBAction)paybyCardButtonAction:(id)sender {
//    VisitorSingleTon *ton = [VisitorSingleTon sharedInstance];
//    NSString *uuidstr = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifierStr"];
//    
//    if (!uuidstr) {
//        [self promptInformationActionWarningString:@"没有本地保存的蓝牙!"];
//        NSLog(@"没有本地保存外设identifierStr");
//        return;
//    }
//    [ton getPeripheralWithIdentifierAndConnect:uuidstr];
    
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
