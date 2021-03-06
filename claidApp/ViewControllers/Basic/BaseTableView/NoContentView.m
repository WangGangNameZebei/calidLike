//
//  NoContentView.m
//  iDeliver
//
//  Created by 蔡强 on 2017/3/27.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

//========== 无内容占位图 ==========//

#import "NoContentView.h"
#import "UIColor+Utility.h"
#import "Masonry.h"

@interface NoContentView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *topLabel;

@end

@implementation NoContentView

#pragma mark - 构造方法

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    //------- 图片 -------//
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    //------- 内容描述 -------//
    self.topLabel = [[UILabel alloc]init];
    [self addSubview:self.topLabel];
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    self.topLabel.font = [UIFont systemFontOfSize:15];
    self.topLabel.textColor =[UIColor colorFromHexCode:@"#484848"];
    
    
    //------- 建立约束 -------//
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_offset(-100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(10);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(20);
    }];
    
}

#pragma mark - 根据传入的值创建相应的UI
/** 根据传入的值创建相应的UI */
- (void)setType:(NSInteger)type{
    switch (type) {
            
        case NoContentTypeNetwork: // 加载失败
        {
            [self setImage:@"loadd_error.png" topLabelText:@""];
        }
            break;
            
        case NoContentTypeOrder:
        {
            [self setImage:@"loadd_not_data.png" topLabelText:@""];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 设置图片和文字
/** 设置图片和文字 */
- (void)setImage:(NSString *)imageName topLabelText:(NSString *)topLabelText{
    self.imageView.image = [UIImage imageNamed:imageName];
    self.topLabel.text = topLabelText;
}

@end
