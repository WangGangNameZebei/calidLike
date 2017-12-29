//
//  UploadViewController+LogicalFlow.h
//  claidApp
//
//  Created by Zebei on 2017/12/13.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "UploadViewController.h"

@interface UploadViewController (LogicalFlow)
- (void)uploadRepairdataTextStr:(NSString *)textString;     //报修
- (void)uploadAnnouncementdataTitleStr:(NSString *)datatitlestr dataTextStr:(NSString *)textString;     //公告
@end
