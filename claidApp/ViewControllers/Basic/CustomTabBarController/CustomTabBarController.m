//
//  CustomTabBarController.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "CustomTabBarController.h"
#import "UIColor+Utility.h"
#import "UIImage+Utility.h"
@implementation TabBarItemImageGroup

- (instancetype)init {
    return [super init];
}

@end

@implementation CustomTabBarController

- (id)initWithControllers:(NSArray *)controllers andImageGroups:(NSArray *)imageGroups {
    if (self = [super init]) {
        self.controllers = controllers;
        self.imageGroups = imageGroups;
        self.tabBar.translucent = NO;
        self.tabBar.tintColor = [UIColor setipBlueColor];
        [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        [self.tabBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createControllers];
}

#pragma mark - PrivateMethod
- (void)createControllers {
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.controllers.count; i ++) {
        UIViewController *controller = [self.controllers objectAtIndex:i];
        TabBarItemImageGroup *imageGroup = [self.imageGroups objectAtIndex:i];
        controller.tabBarItem = [self createTabBarItemWithTitle:imageGroup.title withUnSelectedImage:imageGroup.unSelectImage withSelectedImage:imageGroup.selectImage withTag:i];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        navigationController.navigationBarHidden = YES;
        [viewControllers addObject:navigationController];
    }
    
    [self setViewControllers:viewControllers];
}

- (UITabBarItem *)createTabBarItemWithTitle:(NSString *)title withUnSelectedImage:(NSString *)unSelectedImage withSelectedImage:(NSString *)selectedImage withTag:(int)tag {
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:nil tag:tag];
    item.image = [[UIImage imageNamed:unSelectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return item;
}

@end
