//
//  VisitorTabPagerViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/8/11.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "VisitorViewController.h"
#import "VisitorCarViewController.h"

@interface VisitorTabPagerViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *pagerView;

@property (strong, nonatomic) VisitorCarViewController *visitorCarViewController;
@property (strong, nonatomic) VisitorViewController *visitorViewController;
@property (nonatomic, strong) UIViewController *currentVC; 

@property (nonatomic, strong) UIScrollView *headScrollView;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) UIView *contentView;

@end
