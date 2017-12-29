//
//  UploadViewController.m
//  claidApp
//
//  Created by Zebei on 2017/11/21.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "UploadViewController.h"
#import "UploadViewController+Configuration.h"
#import "UploadViewController+LogicalFlow.h"

@implementation UploadViewController
+(instancetype) create {
    UploadViewController *uploadVC = [[UploadViewController alloc] initWithNibName:@"UploadViewController" bundle:nil];
    return uploadVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
- (IBAction)yulanButtonAction:(id)sender {
    if ([self.barbutton.titleLabel.text isEqualToString:@"编辑"]) {
        self.pickerV.showAddButton = YES;
        self.pickerV.showDelete = YES;
        [self.pickerV reload];
        [self.barbutton setTitle:@"预览" forState:UIControlStateNormal];
    }else{
        [self.barbutton setTitle:@"编辑" forState:UIControlStateNormal];
        self.pickerV.showAddButton = NO;
        self.pickerV.showDelete = NO;
        [self.pickerV reload];
    }
}
- (IBAction)returnButtonAction:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)tijiaoButtonAction:(id)sender {
    
    if (self.uploadTextView.text.length<5){
        [self promptInformationActionWarningString:@"内容不能少于五个字"] ;
        return;
    }

    if([self.titleString isEqualToString:@"公告上传"]) {
        if (self.textTitleField.text.length < 5 || self.textTitleField.text.length >20){
            [self promptInformationActionWarningString:@"标题字数五到二十"] ;
            return;
        }
        
        [self uploadAnnouncementdataTitleStr:self.textTitleField.text dataTextStr:self.uploadTextView.text];
        
    } else {
        [self uploadRepairdataTextStr:self.uploadTextView.text]; //用户报修
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
