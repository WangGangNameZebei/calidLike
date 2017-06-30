//
//  MyFeedBackViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/6/30.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"

@interface MyFeedBackViewController : BaseViewController<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (strong , nonatomic) UILabel *feedbacklabel;
@end
