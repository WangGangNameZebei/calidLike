//
//  UploadViewController.h
//  claidApp
//
//  Created by Zebei on 2017/11/21.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "LLImagePickerView.h"

@interface UploadViewController : BaseViewController<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *textTitleField;
@property (strong, nonatomic) IBOutlet UIButton *barbutton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleLaber;
@property (strong, nonatomic) IBOutlet UITextView *uploadTextView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tijiaoButtonTop;
@property (strong, nonatomic) IBOutlet UILabel *textNumberLaber;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *textTitleFieldHelght;
@property (strong, nonatomic) UILabel *feedbacklabel;
@property (strong, nonatomic) NSString *titleString;
@property (nonatomic,weak) LLImagePickerView * pickerV;

@property (strong, nonatomic)NSMutableArray *imageDataArray;

@end
