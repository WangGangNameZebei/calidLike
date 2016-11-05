//
//  OpenCardView.h
//  claidApp
//
//  Created by kevinpc on 2016/11/3.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseView.h"
#import "HcdDateTimePickerView.h"
@class OpenCardView;
@protocol OpenCardViewDelegate<NSObject>
- (void)openCardViewDidview:(OpenCardView *)openCard;
@end

@interface OpenCardView : BaseView
@property (weak, nonatomic) IBOutlet UIView *youXiaoQiView;
@property (weak, nonatomic) IBOutlet UILabel *youXiaoQiLabel;
@property (weak, nonatomic) IBOutlet UIImageView *youXiaoQiImageView;
@property (weak, nonatomic) IBOutlet UIView *zhunShiDuanView;
@property (weak, nonatomic) IBOutlet UILabel *zhunShiDuanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *zhunShiDuanImageView;
@property (weak, nonatomic) IBOutlet UIView *ciShiView;
@property (weak, nonatomic) IBOutlet UILabel *ciShiLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ciShuImageView;
@property (weak, nonatomic) IBOutlet UIView *cengShuView;
@property (weak, nonatomic) IBOutlet UILabel *cengShuLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cengShuImageView;

@property (weak, nonatomic) id<OpenCardViewDelegate>delegate;

+ (instancetype)create;

@property (strong, nonatomic) HcdDateTimePickerView *dateTimePickerView;

@end
