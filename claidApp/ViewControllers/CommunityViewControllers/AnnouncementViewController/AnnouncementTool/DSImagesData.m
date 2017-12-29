//
//  DSImagesData.m
//  DSImageBrowse
//
//  Created by Zebei on 2017/7/15.
//  Copyright © 2017年 Zebei. All rights reserved.
//

#import "DSImagesData.h"

@implementation DSImageData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _badgeType = DSImageBadgeTypeNone;
    }
    return self;
}


@end

@implementation DSImagesData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _thumbnailImage = [[DSImageData alloc] init];
        _largeImage = [[DSImageData alloc] init];
    }
    return self;
}
@end
