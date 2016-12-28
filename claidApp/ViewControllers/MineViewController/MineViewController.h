//
//  MineViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "SingleTon.h"
#import "MinViewControllerDataSource.h"
#import "JYCarousel.h"
#import "TTSwitch.h"
@interface MineViewController : BaseViewController<mindsendDataToVCDelegate,UITableViewDelegate,JYCarouselDelegate>


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *shuaKaButton;

@property (weak, nonatomic) IBOutlet TTSwitch *ziDongSwitch;
@property (strong, nonatomic) IBOutlet UIView *ziDongView;



@property (strong, nonatomic) MinViewControllerDataSource *minViewControllerDataSource;
@property (strong, nonatomic) NSMutableArray *peripherArray;
@property (strong, nonatomic) SingleTon *ton;
@property (strong, nonatomic) NSString *message;

@property (nonatomic, strong) JYCarousel *carouselView;
- (void)switchEditInit;
@end
