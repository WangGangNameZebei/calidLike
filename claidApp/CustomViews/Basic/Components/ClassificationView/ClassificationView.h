//
//  ClassificationView.h
//  SameLike
//
//  Created by 王刚 on 15/10/27.
//  Copyright © 2015年 guoshencheng. All rights reserved.
//

#import "BaseView.h"
#import "PresentTransitionAnimated.h"
#import "DismissTransitionAnimated.h"

@interface ClassificationView : BaseView <UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *classificationCollectionView;
@property (strong, nonatomic) NSMutableArray *imageDataArray;
@property (strong, nonatomic) NSMutableArray *nameDataArray;
@end
