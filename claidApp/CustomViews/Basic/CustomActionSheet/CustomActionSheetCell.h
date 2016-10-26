//
//  CustomActionSheetCell.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CUSTOM_ACTIONSHEET_TABLEVIEW_VELL_ID @"CustomActionSheetCell"
#define CUSTOM_ACTIONSHEET_TABLEVIEW_VELL_NIBNAME @"CustomActionSheetCell"
@interface CustomActionSheetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (void)updateWithContentText:(NSString *)contentText color:(UIColor *)color;

@end
