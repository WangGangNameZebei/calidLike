//
//  AboutUsViewController+LogicalFlow.h
//  claidApp
//
//  Created by Zebei on 2017/11/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController (LogicalFlow)
- (void)administratorApplicationPOSTdataaccountsstr:(NSString *)accounts pptCellId:(NSString *)pptCellId role:(NSString *)role;
- (void)checkStatusOfCardPOSTdataStr:(NSString *)dataStr;       //效验发卡器
@end
