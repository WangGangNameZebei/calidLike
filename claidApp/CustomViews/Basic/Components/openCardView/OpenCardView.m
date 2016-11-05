//
//  OpenCardView.m
//  claidApp
//
//  Created by kevinpc on 2016/11/3.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "OpenCardView.h"

@implementation OpenCardView
+ (instancetype)create {
    OpenCardView *openCardView = [[[NSBundle mainBundle] loadNibNamed:@"OpenCardView" owner:nil options:nil] lastObject];
    return openCardView;
}
- (IBAction)removeButtonAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(openCardViewDidview:)]) {
        [self.delegate openCardViewDidview:self];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
