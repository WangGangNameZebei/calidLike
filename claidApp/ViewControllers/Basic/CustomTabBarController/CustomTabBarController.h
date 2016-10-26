//
//  CustomTabBarController.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarItemImageGroup : NSObject
@property (strong, nonatomic) NSString *unSelectImage;
@property (strong, nonatomic) NSString *selectImage;
@property (strong, nonatomic) NSString *title;
@end

@interface CustomTabBarController : UITabBarController
@property (strong, nonatomic)NSMutableArray *navControllers;
@property (strong, nonatomic) NSArray *controllers;
@property (strong, nonatomic) NSArray *imageGroups;
- (id)initWithControllers:(NSArray *)controllers andImageGroups:(NSArray *)imageGroups;
@end
