//
//  MycradInfoViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/5/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MycradInfoViewController.h"
#import "MycradInfoViewController+Configuration.h"
#import <TZImagePickerController.h>
#import "UIImage+Utility.h"
#import "MycradInfoViewController+LogicalFlow.h"

@implementation MycradInfoViewController

+ (instancetype) create {
    MycradInfoViewController *mycradinfoVC = [[MycradInfoViewController alloc] initWithNibName:@"MycradInfoViewController" bundle:nil];
    return mycradinfoVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
- (IBAction)uploadButtonAction:(id)sender {
    if (self.editBool) {
        [self uploadPOSTuserInfoActionUserNameString:self.userNameString];
    }
}

// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark-TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mydataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.row == 0) {
            MyInfoAvatarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MY_INFO_AVTAR_TABLEVIEW_CELL];
            cell.delegate = self;
            cell.avatarImageView.image = self.imagedata;
            return cell;
        } else if (indexPath.row == 3){
            MyInfoCommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MY_INFO_COMMUNITY_TABLEVIEW_CELL];
            return cell;
        } else {
            MyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MY_INFO_TABLEVIEW_CELL];
            if (indexPath.row == 1){
                cell.infoKeyLabel.text = @"我的名称";
                cell.infoValueTextField.text =self.userNameString;
                [cell returntextFieldDelegate];
                cell.delegate= self;
            } else {
                cell.infoKeyLabel.text = @"我的账号";
                cell.infoValueTextField.text =@"13130186066";
                cell.infoValueTextField.enabled = NO;
            }
            return cell;
        }

    return nil;
}

- (void)myInfoAvatarTableViewCellDelegate:(id)data {
    self.avatarAlertView = [[UIAlertView alloc] initWithTitle:@"更换头像" message:@"您确定更换新的头像？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.avatarAlertView.tag = 100;
    [self.avatarAlertView show];
}
- (void)myInfoTableViewCellDelegate:(NSString *)dataStr {
    [self myInfoEditBoolAction:YES];
    self.userNameString = dataStr;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex && alertView.tag == 100) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.allowCrop = YES;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            self.imagedata =  [UIImage scaleImage:photos[0] toKb:300];
            [self myInfoEditBoolAction:YES];
            [self.myInfoTableView reloadData];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    
}
- (IBAction)myinforeturnButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
