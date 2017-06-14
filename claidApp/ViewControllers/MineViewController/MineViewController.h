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
@property (strong, nonatomic) IBOutlet UILabel *ziDongLabei;
@property (strong, nonatomic) IBOutlet UIView *JYimageView;
@property (assign, nonatomic) BOOL litBool;                 // 手机亮屏幕标识


@property (strong, nonatomic) MinViewControllerDataSource *minViewControllerDataSource;
@property (strong, nonatomic) SingleTon *ton;       //蓝牙
@property (strong, nonatomic) NSString *message;
@property (assign, nonatomic) BOOL SDshukaBiaoshi; // 手动刷卡 标识
@property (strong, nonatomic) NSTimer * paybycardTimer;  //刷卡定时器

@property (nonatomic, strong) JYCarousel *carouselView;     // 滚动页面
- (void)switchEditInit;         // 自动刷卡  初始化
@end
