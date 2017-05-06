//
//  AppDelegate.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol minLitdelegate <NSObject>           // 蓝牙连接
@optional
- (void)minlitdelegateAction;     // 扫描设备代理
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) id <minLitdelegate> delegate;
@end

