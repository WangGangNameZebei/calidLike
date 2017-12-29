//
//  ClassificationView.m
//  SameLike
//
//  Created by 王刚 on 15/10/27.
//  Copyright © 2015年 guoshencheng. All rights reserved.
//

#import "ClassificationView.h"
#import "TypeCollectionViewCell.h"
#import "UIScreen+Utility.h"
#import "UploadViewController.h"
#import "UserRepairQueryViewController.h"
#import "CommunityViewController.h"
@implementation ClassificationView
+ (instancetype)create {
    ClassificationView *classificationView = [[[NSBundle mainBundle] loadNibNamed:@"ClassificationView" owner:nil options:nil] lastObject];
    return classificationView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initDataArray];
    [self classificationCollectionViewEdit];

}

- (void)initDataArray {
    self.nameDataArray = [NSMutableArray arrayWithObjects:@"我要报修",@"报修记录", nil];
    self.imageDataArray = [NSMutableArray arrayWithObjects:@"community_blue",@"community_blue", nil];
}

- (void)classificationCollectionViewEdit {
    self.classificationCollectionView.delegate = self;
    self.classificationCollectionView.dataSource = self;
   [self.classificationCollectionView registerNib:[UINib nibWithNibName:@"TypeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:TYPE_COLLECTIONVIEW_CELL];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen screenWidth] / 4 - 10, 80);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TYPE_COLLECTIONVIEW_CELL forIndexPath:indexPath];
    [cell updateWithImageView:[self.imageDataArray objectAtIndex:indexPath.row] textLabel:[self.nameDataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self pushChannelSortViewControllerWithIndexpath:indexPath];

}

- (void)pushChannelSortViewControllerWithIndexpath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        UploadViewController *uploadVC = [UploadViewController create];
        uploadVC.titleString = @"我要报修";
        [uploadVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [[self getCurrentViewController] presentViewController:uploadVC animated:NO completion:nil];
    } else {
        UserRepairQueryViewController *userRepairQueryVC = [UserRepairQueryViewController create];
        [[self getCurrentViewController] hideTabBarAndpushViewController:userRepairQueryVC];
    }
    
}
- (CommunityViewController *)getCurrentViewController {
    CommunityViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    if (window.rootViewController.childViewControllers.count > 1) {
        UINavigationController *nav = window.rootViewController.childViewControllers[1];
        if (nav.childViewControllers[0]) {
            result = nav.childViewControllers[0];
        }
    }
    return result;
}

@end
