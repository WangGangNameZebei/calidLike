//
//  CreditCardRecords.h
//  claidApp
//
//  Created by Zebei on 2017/11/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditCardRecords : NSObject
@property (assign, nonatomic)NSInteger swipeNumbering;         //   刷卡编号
@property (strong, nonatomic)NSString *communityNumber;         //   小区号码
@property (strong, nonatomic)NSString *swipeTime;               //   时间
@property (strong, nonatomic)NSString *swipeStatus;             //   状态
@property (strong, nonatomic)NSString *swipeAddress;            //   地址
@property (strong, nonatomic)NSString *swipeSensitivity;        //   灵敏度

+ (instancetype)initCreditCardRecordsswipeNumbering:(NSInteger)swipeNumbering communityNumber:(NSString *)communityNumber swipeTime:(NSString *)swipeTime swipeStatus:(NSString *)swipeStatus swipeAddress:(NSString *)swipeAddress swipeSensitivity:(NSString *)swipeSensitivity;
@end
