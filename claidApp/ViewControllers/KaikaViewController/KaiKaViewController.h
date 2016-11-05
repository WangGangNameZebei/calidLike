//
//  KaiKaViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/11/4.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "HcdDateTimePickerView.h"

@interface KaiKaViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *youXiaoqiView;
@property (weak, nonatomic) IBOutlet UIView *youXiaoqiLabelView;
@property (weak, nonatomic) IBOutlet UILabel *youXiaoqiLable;
@property (weak, nonatomic) IBOutlet UIImageView *youXiaoQiImageView;

@property (strong, nonatomic) HcdDateTimePickerView *hcdDateTimePickerView;

@end
