//
//  MyInfoTableViewCell.h
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MY_INFO_TABLEVIEW_CELL @"MyInfoTableViewCell"

@protocol MyInfoTableViewCellDelegate <NSObject>
@optional
- (void)myInfoTableViewCellDelegate:(NSString *)dataStr;
@end

@interface MyInfoTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *infoKeyLabel;
@property (strong, nonatomic) IBOutlet UITextField *infoValueTextField;

@property (nonatomic, assign) id <MyInfoTableViewCellDelegate> delegate;

- (void)returntextFieldDelegate;
@end
