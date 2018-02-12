//
//  TypeCollectionViewCell.h
//  SameLike
//
//  Created by 王刚 on 15/10/27.
//  Copyright © 2015年 zebei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TYPE_COLLECTIONVIEW_CELL @"TypeCollectionViewCell"
@interface TypeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeTextLabel;

- (void)updateWithImageView:(NSString *)typeImageString textLabel:(NSString *)typeLabelString;
@end
