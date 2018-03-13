//
//  DSImageDemoCell.h
//  DSImageBrowse
//
//  Created by Zebei on 2017/8/9.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSImageBrowseView.h"
#import "DSDemoLayout.h"
#import "LMJScrollTextView.h"
@class DSImageDemoCell;

@protocol DSImageBrowseCellDelegate <NSObject>

- (void)didClick:(DSImageBrowseView *)imageView atIndex:(NSInteger)index;
- (void)longPress:(DSImageBrowseView *)imageView atIndex:(NSInteger)index;

@end

@interface DSImageDemoCell : UITableViewCell<DSImageBrowseDelegate>

@property (nonatomic, weak) id<DSImageBrowseCellDelegate> delegate;
@property (nonatomic, strong) DSImageBrowseView *imageBrowseView;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) LMJScrollTextView *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *announcerLabel;
@property (nonatomic, strong) UIView *bottomLineView;
- (void)setLayout:(DSDemoLayout *)layout;

@end
