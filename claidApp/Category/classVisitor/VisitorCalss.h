//
//  VisitorCalss.h
//  claidApp
//
//  Created by kevinpc on 2017/3/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisitorCalss : NSObject
@property (assign, nonatomic) NSInteger visitorName;            //实际名字
@property (strong, nonatomic) NSString *visitorRemarks;         //备注
@property (strong, nonatomic) NSString *visitorData;            //刷卡数据
@property (assign, nonatomic) NSInteger visitorFrequency;       //刷卡次数

+(instancetype)assignmentVisitorName:(NSInteger)visitorNameint visitorRemarks:(NSString *)visitorRemarksStr visitorData:(NSString *)visitorDataStr visitorFrequency:(NSInteger)visitorFrequency;

@end
