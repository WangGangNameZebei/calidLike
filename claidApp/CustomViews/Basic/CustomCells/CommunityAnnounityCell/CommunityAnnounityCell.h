//
//  CommunityAnnounityCell.h
//  claidApp
//
//  Created by Zebei on 2017/12/21.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYCarousel.h"

#define COMMUNITY_ANNOUNITY_CELL @"CommunityAnnounityCell"
@interface CommunityAnnounityCell : UITableViewCell<JYCarouselDelegate>

@property (strong, nonatomic) IBOutlet UIView *caImageView;


@property (strong, nonatomic) UILabel *caTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *caTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *catextInfoLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *caimageViewWidth;
@property (nonatomic, strong) JYCarousel *carouselView;     // 滚动页面


- (void)animationImplementationAction:(NSMutableArray *)dataImageArr;
@end
