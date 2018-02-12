//
//  RecordQueryViewController+LogicalFlow.h
//  claidApp
//
//  Created by Zebei on 2018/1/2.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "RecordQueryViewController.h"

@interface RecordQueryViewController (LogicalFlow)
- (void)getPOSTConditionRecordQuerypageNum:(NSInteger)pageNum accounts:(NSString *)accounts swipingTime:(NSString *)swipingTime swipingEndTime:(NSString *)swipingEndTime swipingStatus:(NSString *)swipingStatus swipingAddress:(NSString *)swipingAddress;
@end
