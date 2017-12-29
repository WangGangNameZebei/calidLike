//
//  ViewRepairLayout.m
//  claidApp
//
//  Created by Zebei on 2017/12/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ViewRepairLayout.h"
#import "NSString+DSCategory.h"
#import "UIScreen+Utility.h"

@implementation ViewRepairLayout
- (instancetype)initWithDSDemoMode:(ViewRepairModel *)model {
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
    
    
    _cellHeight = _descHeight + _imageLayout.imageBrowseHeight + 116;
}
@end
