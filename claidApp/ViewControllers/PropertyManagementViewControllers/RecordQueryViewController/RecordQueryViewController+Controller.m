//
//  RecordQueryViewController+Controller.m
//  claidApp
//
//  Created by Zebei on 2017/11/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "RecordQueryViewController+Controller.h"
#import "UIScreen+Utility.h"

@implementation RecordQueryViewController (Controller)

- (void)configureViews {
    [self buttonsViewEdit];
    [self searchViewEdit];
}

- (void)buttonsViewEdit {
    self.yhButton.frame = CGRectMake(0, 0, [UIScreen screenWidth]/3, 30);
    self.timeButton.frame = CGRectMake([UIScreen screenWidth]/3, 0, [UIScreen screenWidth]/3, 30);
    self.dzButton.frame = CGRectMake([UIScreen screenWidth]/3 *2, 0, [UIScreen screenWidth]/3, 30);
    self.recordQueryViewheight.constant = 32;
}
- (void)searchViewEdit {
    self.searchView.frame = CGRectMake(0, 30, [UIScreen screenWidth], 35);
}

@end
