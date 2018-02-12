//
//  RecordQueryViewController.m
//  claidApp
//
//  Created by Zebei on 2017/11/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "RecordQueryViewController.h"
#import "RecordQueryViewController+Controller.h"
#import "RecordQueryViewController+LogicalFlow.h"
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

- (IBAction)conditionLnquiryButtonAction:(id)sender {
     [[CQSideBarManager sharedInstance] openSideBar:self];
}
#pragma mark - CQSideBarManagerDelegate
- (UIView *)viewForSideBar
{
    self.conditionInquiryView = [ConditionInquiryView create];
    self.conditionInquiryView.delegate = self;
    self.conditionInquiryView.cq_width = self.view.cq_width - 45.f;
    return self.conditionInquiryView;
}

- (BOOL)canCloseSideBar
{
    return YES;
}

- (void)conditionInquiryViewAccounts:(NSString *)accounts swipingTime:(NSString *)swipingTime swipingEndTime:(NSString *)swipingEndTime swipingStatusText:(NSString *)swipingStatusText swipingAddressText:(NSString *)swipingAddress {
    
    self.accounts = accounts;
    self.swipingTime = swipingTime;
    self.swipingEndTime = swipingEndTime;
    self.swipingStatusText = swipingStatusText;
    self.swipingAddressText = swipingAddress;
    
    self.mjBool = YES;
    [self.indicator startAnimating];
    [self getPOSTConditionRecordQuerypageNum:1 accounts:accounts swipingTime:swipingTime swipingEndTime:swipingEndTime swipingStatus:swipingStatusText swipingAddress:swipingAddress];
    
    [[CQSideBarManager sharedInstance] closeSideBar];
}

#pragma mark-点击TableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
