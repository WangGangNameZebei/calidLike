//
//  MyTableViewCell.h
//  claidApp
//
//  Created by kevinpc on 2016/10/24.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define My_TABLEVIEW_CELL @"MyTableViewCell"
@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *myCellLabel;

@end
