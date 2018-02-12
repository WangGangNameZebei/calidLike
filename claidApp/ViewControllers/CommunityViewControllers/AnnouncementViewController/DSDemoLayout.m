//
//  DSDemoLayout.m
//  DSImageBrowse
//
//  Created by Zebei on 2017/8/29.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "DSDemoLayout.h"
#import "NSString+DSCategory.h"
#import "UIScreen+Utility.h"

@implementation DSDemoLayout

- (instancetype)initWithDSDemoMode:(DSDemoModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self layout];
    }
    return self;
}

- (void)layout {
    
    _imageLayout = [[DSImageLayout alloc] initWithImageData:_model.imageDataArray];
    _imageLayout.leftPadding = 0;
    _imageLayout.rightPadding = 0;
    _imageLayout.imageBrowseWidth = [UIScreen screenWidth] - 20;
    [_imageLayout layout];
    
    _descHeight = [_model.describe ds_sizeForFont:[UIFont systemFontOfSize:17] size:CGSizeMake([UIScreen screenWidth] - 20, HUGE) mode:NSLineBreakByWordWrapping].height;
    
    _titleHeight = [_model.titlebe ds_sizeForFont:[UIFont systemFontOfSize:19] size:CGSizeMake([UIScreen screenWidth] - 18, HUGE) mode:NSLineBreakByWordWrapping].height;
    
    _cellHeight = _titleHeight+_descHeight + _imageLayout.imageBrowseHeight + 28;
}

@end
