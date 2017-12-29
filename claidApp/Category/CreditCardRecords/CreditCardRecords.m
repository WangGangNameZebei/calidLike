//
//  CreditCardRecords.m
//  claidApp
//
//  Created by Zebei on 2017/11/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "CreditCardRecords.h"

@implementation CreditCardRecords

+ (instancetype)initCreditCardRecordsswipeNumbering:(NSInteger)swipeNumbering communityNumber:(NSString *)communityNumber swipeTime:(NSString *)swipeTime swipeStatus:(NSString *)swipeStatus swipeAddress:(NSString *)swipeAddress swipeSensitivity:(NSString *)swipeSensitivity {
    CreditCardRecords *creditCardRecords = [[CreditCardRecords alloc] init];
    creditCardRecords.swipeNumbering = swipeNumbering;
    creditCardRecords.communityNumber =communityNumber;
    creditCardRecords.swipeTime = swipeTime;
    creditCardRecords.swipeStatus = swipeStatus;
    creditCardRecords.swipeAddress = swipeAddress;
    creditCardRecords.swipeSensitivity = swipeSensitivity;
    return creditCardRecords;
}

@end
