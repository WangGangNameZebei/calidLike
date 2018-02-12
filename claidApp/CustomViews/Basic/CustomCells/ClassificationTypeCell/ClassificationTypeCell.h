//
//  ClassificationTypeCell.h
//  SameLike
//
//  Created by 王刚 on 15/10/27.
//  Copyright © 2015年 zebei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassificationView.h"

#define CLASSIFCATION_TYPE_CELL @"ClassificationTypeCell"
@interface ClassificationTypeCell : UITableViewCell
@property (strong, nonatomic) ClassificationView *classificationView;
@end
