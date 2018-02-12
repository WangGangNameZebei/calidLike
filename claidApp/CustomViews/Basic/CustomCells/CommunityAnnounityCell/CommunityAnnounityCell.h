//
//  CommunityAnnounityCell.h
//  claidApp
//
//  Created by Zebei on 2017/12/21.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYCarousel.h"
#import "LMJScrollTextView.h"
#define COMMUNITY_ANNOUNITY_CELL @"CommunityAnnounityCell"
@interface CommunityAnnounityCell : UITableViewCell<JYCarouselDelegate>

@property (strong, nonatomic) IBOutlet UIView *caImageView;


@property (strong, nonatomic) UILabel *caTimeLabel;
@property (strong, nonatomic) IBOutlet UIView *caTitleView;
@property (strong, nonatomic) IBOutlet UILabel *catextInfoLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *caimageViewWidth;

@property (strong, nonatomic) LMJScrollTextView *lmjScrollTextView;
@property (nonatomic, strong) JYCarousel *carouselView;     // 滚动页面

- (void)setinfocaTimeText:(NSString *)timeText caTitleText:(NSString *)titleText caTextinfo:(NSString *)textInfo dataImageArr:(NSMutableArray *)dataImageArr;

@end
