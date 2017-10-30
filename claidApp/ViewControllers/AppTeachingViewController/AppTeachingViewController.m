//
//  AppTeachingViewController.m
//  claidApp
//
//  Created by Zebei on 2017/10/25.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AppTeachingViewController.h"
#import "UIScreen+Utility.h"

@implementation AppTeachingViewController

+ (instancetype)create {
    AppTeachingViewController *appteachViewController = [[AppTeachingViewController alloc] initWithNibName:@"AppTeachingViewController" bundle:nil];
    return appteachViewController;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self appteachingViewEdit];
    
}
- (void)appteachingViewEdit {
    self.appTeachScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen screenWidth] , [UIScreen screenHeight])];
    UIImage  *imagetea = [UIImage imageNamed:@"appteachimage.jpg"];
    self.appTeachImageView = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth] , imagetea.size.height * ([UIScreen screenWidth] / imagetea.size.width))];
    self.appTeachImageView.image  = imagetea;
    self.appTeachScrollView.contentSize = self.appTeachImageView.bounds.size;
    [self.appTeachScrollView addSubview:self.appTeachImageView];
    [self.view addSubview:self.appTeachScrollView];
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
