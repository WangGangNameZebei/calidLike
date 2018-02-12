//
//  ConditionInquiryView.m
//  claidApp
//
//  Created by Zebei on 2018/1/3.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "ConditionInquiryView.h"
#import "ConditionInquiryView+Configuration.h"

@implementation ConditionInquiryView
+ (instancetype)create {
    ConditionInquiryView *conditionInquiryView = [[[NSBundle mainBundle] loadNibNamed:@"ConditionInquiryView" owner:nil options:nil] lastObject];
    return conditionInquiryView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureViews];
}


- (IBAction)swipingTimeButtonAction:(id)sender {
    __block ConditionInquiryView *weakSelf = self;
    self.dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateHourMinuteMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
    self.dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        weakSelf.swipingTimeLabel.text = datetimeStr;
    };
    [self addSubview:self.dateTimePickerView];
    [self.dateTimePickerView showHcdDateTimePicker];
}

- (IBAction)swipingEndTimeButtonAction:(id)sender {
    __block ConditionInquiryView *weakSelf = self;
    self.dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateHourMinuteMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
    self.dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        weakSelf.swipingEndTimeLabel.text = datetimeStr;
    };
    [self addSubview:self.dateTimePickerView];
    [self.dateTimePickerView showHcdDateTimePicker];
}

@end
