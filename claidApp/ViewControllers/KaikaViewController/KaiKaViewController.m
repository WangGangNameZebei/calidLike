//
//  KaiKaViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/11/4.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "KaiKaViewController.h"
#import "KaiKaViewController+Configuration.h"
#import "KaiKaViewController+Animation.h"

@implementation KaiKaViewController

+ (instancetype) create {
    KaiKaViewController *kaiKaViewController = [[KaiKaViewController alloc] initWithNibName:@"KaiKaViewController" bundle:nil];
    return kaiKaViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
- (IBAction)youXiaoQiButtonAction:(id)sender {
      [self imageViewOpenAnimationimageView:self.youXiaoQiImageView];
      __block KaiKaViewController *youXiaoqiSelf = self;
     self.hcdDateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateHourMinuteMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
     self.hcdDateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
          [youXiaoqiSelf imageViewCloseAnimationimageView:youXiaoqiSelf.youXiaoQiImageView];
           youXiaoqiSelf.youXiaoqiLable.text = datetimeStr;
    };
    
    if (self.hcdDateTimePickerView) {
        [self.view addSubview:self.hcdDateTimePickerView];
        [self.hcdDateTimePickerView showHcdDateTimePicker];
    }
}

- (IBAction)kaiKaReturnButtonAction:(id)sender {
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
