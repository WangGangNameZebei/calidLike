//
//  VisitorCalss.m
//  claidApp
//
//  Created by kevinpc on 2017/3/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "VisitorCalss.h"

@implementation VisitorCalss

+(instancetype)assignmentVisitorName:(NSInteger)visitorNameint visitorRemarks:(NSString *)visitorRemarksStr visitorData:(NSString *)visitorDataStr {
    VisitorCalss *visitor = [[VisitorCalss alloc] init];
    visitor.visitorName = visitorNameint;
    visitor.visitorRemarks = visitorRemarksStr;
    visitor.visitorData = visitorDataStr;
    visitor.visitorFrequency = 2;
    return visitor;
}

@end
