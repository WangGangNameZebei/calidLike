//
//  RecordQueryTableViewCell.h
//  claidApp
//
//  Created by Zebei on 2018/1/4.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RECORD_QUERY_TABLEVIEW_CELL @"RecordQueryTableViewCell"

@interface RecordQueryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *swipingTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *accountsLabel;
@property (strong, nonatomic) IBOutlet UILabel *swipingAddress;
@property (strong, nonatomic) IBOutlet UILabel *swipingStatusLabel;

@property (strong, nonatomic) IBOutlet UILabel *swipingSensitivityLabel;
@end
