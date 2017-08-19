//
//  MyFeedBackViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/6/30.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MyFeedBackViewController.h"
#import "UIColor+Utility.h"
#import "MyFeedBackViewController+logicalFlow.h"

@implementation MyFeedBackViewController

+ (instancetype)create {
    MyFeedBackViewController *feedBackViewController = [[MyFeedBackViewController alloc] initWithNibName:@"MyFeedBackViewController" bundle:nil];
    return feedBackViewController;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self textViewEdit];
    [self addGestRecognizer];
}

- (void)textViewEdit {
    self.feedbackTextView.layer.borderColor =  [[UIColor setipBlueColor] CGColor];
    self.feedbackTextView.layer.borderWidth = 2;
    self.feedbackTextView.layer.cornerRadius = 6;
    self.feedbackTextView.layer.masksToBounds = YES;
    self.feedbackTextView.delegate = self;
    _feedbacklabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.feedbackTextView.frame.size.width, 40)];
    _feedbacklabel.text = @"请输入10 - 200 字符的意见反馈";
    _feedbacklabel.enabled = NO;
    [self.feedbackTextView addSubview:_feedbacklabel];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];//按回车取消第一相应者
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _feedbacklabel.alpha = 0;//开始编辑时
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{//将要停止编辑(不是第一响应者时)
    if (textView.text.length == 0) {
        _feedbacklabel.alpha = 1;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)returnButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submitButtonAction:(id)sender {
    if (self.feedbackTextView.text.length < 10 || self.feedbackTextView.text.length > 200){
        [self promptInformationActionWarningString:@"反馈信息不符合要求!"];
        return;
    }
    [self feedbackPOSTtextString:self.feedbackTextView.text];
}


#pragma mark - 空白处收起键盘
- (void)addGestRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTouchesRequired =1;
    tap.numberOfTapsRequired =1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}
- (void)tapped:(UIGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}


@end
