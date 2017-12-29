//
//  CommunityAnnounityCell.m
//  claidApp
//
//  Created by Zebei on 2017/12/21.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "CommunityAnnounityCell.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"
#import "AnnouncementViewController.h"      //  查看公告
#import "CommunityViewController.h"

@implementation CommunityAnnounityCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self carouselViewEdit];
}
#pragma mark  滚动视图
- (void)carouselViewEdit {
    self.caimageViewWidth.constant = [UIScreen screenWidth];
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithArray: @[@"advertisment_1.jpg",@"advertisment_2.jpg",@"advertisment_3.jpg"]];
    if (!self.carouselView) {
        self.carouselView = [[JYCarousel alloc] initWithFrame:CGRectMake(8, 0, [UIScreen screenWidth] - 16 , self.caImageView.frame.size.height)
                                                  configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
                                                      carouselConfig.pageContollType = NonePageControl;
                                                      carouselConfig.pageTintColor = [UIColor whiteColor];
                                                      carouselConfig.currentPageTintColor = [UIColor setipBlueColor];
                                                      carouselConfig.pushAnimationType = PushDefault;
                                                      carouselConfig.placeholder = [UIImage imageNamed:@"zhanweiImage.png"];
                                                      carouselConfig.faileReloadTimes = 3;
                                                      carouselConfig.interValTime = 4.0f;
                                                      return carouselConfig;
                                                      
                                                  } target:self];
        
        [self.caImageView addSubview:self.carouselView];
        
    }
    self.caTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,self.carouselView.frame.origin.x + self.carouselView.frame.size.height - 22,[UIScreen screenWidth] - 16, 25)];
    self.caTimeLabel.backgroundColor = [UIColor blackColor];
    self.caTimeLabel.textColor = [UIColor whiteColor];
    self.caTimeLabel.alpha = 0.5f;
    [self addSubview:self.caTimeLabel];
    //开始轮播
    [self.carouselView startCarouselWithArray:imageArray];
    
}

- (void)animationImplementationAction:(NSMutableArray *)dataImageArr {
    [self.carouselView startCarouselWithArray:dataImageArr];
}
- (void)carouselViewClick:(NSInteger)index{
    AnnouncementViewController *annoucementVC = [AnnouncementViewController create];
    [[self getCurrentViewController] hideTabBarAndpushViewController:annoucementVC];
}

- (CommunityViewController *)getCurrentViewController {
    CommunityViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    if (window.rootViewController.childViewControllers.count > 1) {
        UINavigationController *nav = window.rootViewController.childViewControllers[1];
        if (nav.childViewControllers[0]) {
            result = nav.childViewControllers[0];
        }
    }
    return result;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
