//
//  TypeCollectionViewCell.m
//  SameLike
//
//  Created by 王刚 on 15/10/27.
//  Copyright © 2015年 guoshencheng. All rights reserved.
//

#import "TypeCollectionViewCell.h"

@implementation TypeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)updateWithImageView:(NSString *)typeImageString textLabel:(NSString *)typeLabelString {
    self.typeImageView.image = [UIImage imageNamed:typeImageString];
    self.typeTextLabel.text = typeLabelString;
}
@end
