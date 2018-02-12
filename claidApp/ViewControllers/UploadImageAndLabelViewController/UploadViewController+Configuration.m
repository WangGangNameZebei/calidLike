//
//  UploadViewController+Configuration.m
//  claidApp
//
//  Created by Zebei on 2017/11/22.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "UploadViewController+Configuration.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"
#import "LLImagePickerView.h"

@implementation UploadViewController (Configuration)
- (void)configureViews {
    [self uploadviewEdit];
    [self textViewEdit];
    [self addGestRecognizer];
    [self llImagePickerViewEdit];
}

- (void)uploadviewEdit{
    if ([self.titleString isEqualToString:@"我要报修"]) {
        self.textTitleFieldHelght.constant = 0;
        self.textNumberLaber.text = @"0/200";
    } else {
        self.textTitleFieldHelght.constant = 30;
        self.textNumberLaber.text = @"0/500";
    }
}

#pragma mark- 图片添加
- (void)llImagePickerViewEdit {
    UIView *headerV = [UIView new];
    LLImagePickerView *pickerV = [LLImagePickerView ImagePickerViewWithFrame:CGRectMake(0, 0, [UIScreen screenWidth],0) CountOfRow:5];
    pickerV.showAddButton = YES;
    pickerV.showDelete = YES;
    pickerV.allowMultipleSelection = NO;
    pickerV.allowPickingVideo = YES;
    // 如果在预览的基础上又要添加照片 则需要调用此方法 来动态变换高度
    [pickerV observeViewHeight:^(CGFloat height) {
        CGRect rect = headerV.frame;
        rect.size.height = CGRectGetMaxY(pickerV.frame);
        headerV.frame = rect;
        self.tijiaoButtonTop.constant = height +20;
    }];
    self.imageDataArray = [NSMutableArray new];
    [pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
        
        [self.imageDataArray removeAllObjects];
        for (LLImagePickerModel *model in list) {
            // 在这里取到模型的数据
            [self.imageDataArray addObject:model.image];
        }
    }];
    self.tijiaoButtonTop.constant = CGRectGetMaxY(pickerV.frame) +20;
    [headerV addSubview:pickerV];
    headerV.frame = CGRectMake(0, 247, self.view.frame.size.width, CGRectGetMaxY(pickerV.frame));
    [self.view addSubview:headerV];
}
#pragma mark -  textView 编辑
- (void)textViewEdit {
    self.titleLabel.text = self.titleString;
    //self.uploadTextView.layer.borderColor =  [[UIColor setipBlueColor] CGColor];
   // self.uploadTextView.layer.borderWidth = 1;
    self.uploadTextView.layer.masksToBounds = YES;
    self.uploadTextView.delegate = self;
    self.feedbacklabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.uploadTextView.frame.size.width, 40)];
    self.feedbacklabel.text = @"请输入信息...";
    self.feedbacklabel.enabled = NO;
    [self.uploadTextView addSubview:self.feedbacklabel];
}
#pragma mark -textView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];//按回车取消第一相应者
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {

    if (textView.text.length > 200 && [self.titleString isEqualToString:@"我要报修"]){
      self.textNumberLaber.text = [NSString stringWithFormat:@"%lu/200",  (unsigned long)textView.text.length];
        self.textNumberLaber.textColor = [UIColor redColor];
    } else {
        self.textNumberLaber.text = [NSString stringWithFormat:@"%lu/500",  (unsigned long)textView.text.length];
        self.textNumberLaber.textColor = [UIColor grayColor];
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.feedbacklabel.alpha = 0;//开始编辑时
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{//将要停止编辑(不是第一响应者时)
    if (textView.text.length == 0) {
        self.feedbacklabel.alpha = 1;
    } else if ([self.titleString isEqualToString:@"我要报修"] && textView.text.length > 200) {
        textView.text =[textView.text substringWithRange:NSMakeRange(0, 200)];
       self.textNumberLaber.text = [NSString stringWithFormat:@"%lu/200",  (unsigned long)textView.text.length];
       self.textNumberLaber.textColor = [UIColor grayColor];
    } else if ([self.titleString isEqualToString:@"公告上传"] && textView.text.length > 500) {
        textView.text =[textView.text substringWithRange:NSMakeRange(0, 500)];
        self.textNumberLaber.text = [NSString stringWithFormat:@"%lu/500",  (unsigned long)textView.text.length];
        self.textNumberLaber.textColor = [UIColor grayColor];
    }
    return YES;
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
