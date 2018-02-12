//
//  ConditionInquiryView.h
//  claidApp
//
//  Created by Zebei on 2018/1/3.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "BaseView.h"
#import "SPPageMenu.h"
#import "HcdDateTimePickerView.h"
@protocol ConditionInquiryViewDelegate <NSObject>
@optional
- (void)conditionInquiryViewAccounts:(NSString *)accounts swipingTime:(NSString *)swipingTime swipingEndTime:(NSString *)swipingEndTime swipingStatusText:(NSString *)swipingStatusText swipingAddressText:(NSString *)swipingAddress;
@end

@interface ConditionInquiryView : BaseView<SPPageMenuDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UIView *pageMenuView;
@property (strong, nonatomic) NSMutableArray *itemArray;
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (strong ,nonatomic)HcdDateTimePickerView * dateTimePickerView;
@property (nonatomic, assign) id <ConditionInquiryViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITextField *accountsTextField;
@property (strong, nonatomic) IBOutlet UILabel *swipingTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *swipingEndTimeLabel;
@property (strong, nonatomic) IBOutlet UITextField *swipingAddressTextField;


@end
