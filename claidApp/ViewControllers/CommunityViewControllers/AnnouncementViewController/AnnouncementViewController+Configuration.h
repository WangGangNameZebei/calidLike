//
//  AnnouncementViewController+Configuration.h
//  claidApp
//
//  Created by Zebei on 2017/12/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AnnouncementViewController.h"

@interface AnnouncementViewController (Configuration)
- (void)configureViews;
- (void)present:(DSImageBrowseView *)imageView index:(NSInteger)index;
@end
