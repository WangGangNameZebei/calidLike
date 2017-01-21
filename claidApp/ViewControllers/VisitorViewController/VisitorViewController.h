//
//  VisitorViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/1/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "VisitorSingleTon.h"

@interface VisitorViewController : BaseViewController <UITextFieldDelegate,VisitorDataToVCDelegate>
@property (strong, nonatomic) IBOutlet UIButton *returnButton;
@property (strong, nonatomic) IBOutlet UIView *visitorView;
@property (strong, nonatomic) IBOutlet UITextField *visitorTextField;
@property (strong, nonatomic) IBOutlet UIImageView *visitorImageView;
@property (strong, nonatomic) IBOutlet UIButton *shukaButton;


@property (strong, nonatomic) VisitorSingleTon *visitorton;
@end
