//
//  ConditionInquiryView+Configuration.m
//  claidApp
//
//  Created by Zebei on 2018/1/8.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "ConditionInquiryView+Configuration.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"

@implementation ConditionInquiryView (Configuration)
- (void)configureViews {
    [self textFieldViewEdit];
    [self loadBaseUI];
    [self addGestRecognizer];
}

- (void)textFieldViewEdit{
    self.accountsTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.accountsTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.swipingAddressTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.swipingAddressTextField.delegate = self;
}


- (void)loadBaseUI{
    self.itemArray = [NSMutableArray arrayWithObjects:@"重置",@"提交", nil];
    self.pageMenuView = [[UIView alloc]initWithFrame:CGRectMake(0,[UIScreen screenHeight] -44, [UIScreen mainScreen].bounds.size.width, 44)];
    
    SPPageMenu  *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0 ,[UIScreen screenWidth], 44) trackerStyle:SPPageMenuTrackerStyleRect];
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.selectedItemTitleColor = [UIColor blackColor];
    pageMenu.unSelectedItemTitleColor = [UIColor colorFromHexCode:@"#999999"];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.itemArray selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    [self.pageMenuView addSubview:pageMenu];
    self.pageMenu = pageMenu;
    [self addSubview:self.pageMenuView];
    
}
#pragma mrak- pageMenu DeleGate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    if (index == 1) {
        if (self.accountsTextField.text.length >13){
            [self promptInformationActionWarningString:@"账号长度请小于13"];
            return;
        } else if (self.swipingAddressTextField.text.length >3){
            [self promptInformationActionWarningString:@"地址长度请小于3"];
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(conditionInquiryViewAccounts:swipingTime:swipingEndTime:swipingStatusText:swipingAddressText:)]){
            [self.delegate conditionInquiryViewAccounts:self.accountsTextField.text  swipingTime:self.swipingTimeLabel.text swipingEndTime:self.swipingEndTimeLabel.text swipingStatusText:@"" swipingAddressText:self.swipingAddressTextField.text];
        }
    } else {
        self.accountsTextField.text = @"";
        self.swipingTimeLabel.text = @"";
        self.swipingEndTimeLabel.text = @"";
        self.swipingAddressTextField.text= @"";
    }
}
#pragma mark - 空白处收起键盘
- (void)addGestRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTouchesRequired =1;
    tap.numberOfTapsRequired =1;
    tap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tap];
}
- (void)tapped:(UIGestureRecognizer *)gestureRecognizer{
    [self endEditing:YES];
}

@end
