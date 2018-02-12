//
//  VisitorViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/1/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "VisitorViewController+Configuration.h"
#import "UIColor+Utility.h"
#import "MinFuncTionTableViewCell.h"

@implementation VisitorViewController (Configuration)

- (void)configureViews {
    [self lanyainitData];
    [self textFieldViewEdit];
    [self addGestRecognizer];
    [self ownerChoiceViewEdit];
    [self visitorTableViewEdit];
}

// 发卡数据选择tableView 编辑
- (void)visitorTableViewEdit {
    self.requestBool = YES;
    [self userInfowriteuserkey:@"lanyaVisitorAESData" uservalue:@""];
    self.tool = [DBTool sharedDBTool];
    [self.visitorTableView registerNib:[UINib nibWithNibName:@"MinFuncTionTableViewCell" bundle:nil] forCellReuseIdentifier:MINN_FUNCTION_CELL_NIB];
    
    self.visitorViewControllerDataSource = [VisitorViewControllerDataSource new];
    self.visitorTableView.delegate = self;
    self.visitorTableView.dataSource = self.visitorViewControllerDataSource;    
    self.visitorViewControllerDataSource.beizhuNameArray = [self.tool selectWithClass:[VisitorCalss class] params:nil];
}

// 游客选择View初始化
- (void)ownerChoiceViewEdit{
    self.ownerChoiceView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.ownerChoiceView.layer.shadowOffset = CGSizeMake(-2, 2);
    self.ownerChoiceView.layer.shadowOpacity = 0.2;
    self.ownerChoiceView.layer.shadowRadius = 10;
    self.ownerChoiceViewTopConstraint.constant = -140;
    self.ownerChoiceView.hidden = YES;
    [self.view layoutIfNeeded];
}

- (void)lanyainitData {
    [[VisitorSingleTon sharedInstance] initialization];
    self.visitorton = [VisitorSingleTon sharedInstance];
    self.visitorton.delegate = self;
}

#pragma mrak 蓝牙代理
- (void)visitorEditInitPeripheralData:(NSInteger)data {
    NSString *message;
    switch (data) {
        case 1:         //连接 成功 发现   服务
           message = [self userInfoReaduserkey:@"lanyaVisitorAESData"];
            if (message.length > 0) {
               message = @"0180010101FF3344556600000000000000000000000000000000000000000000000000000000000000";
                message = [NSString stringWithFormat:@"%@%@",@"cc",message];
                [self.visitorton sendCommand:message];       //发送数据
            } else {
                [self promptInformationActionWarningString:@"暂无数据!"];
                [self.visitorton disConnection];
            }
            break;
          case 2:
            [self promptInformationActionWarningString:@"刷卡失败!"];
            [self.visitorton disConnection];
            break;
          case 3:
          [self.visitorton getPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];
            break;
        default:
            [self lanyaShuakareturnPromptActioninteger:data];
            [self.visitorton disConnection];
            break;
    }
}

//textField 编辑
- (void)textFieldViewEdit {
    self.shukaButton.backgroundColor = [UIColor setupGreyColor];
    self.visitorTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.visitorTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.visitorTextField.delegate = self;
    self.visitorTextField.text =[self userInfoReaduserkey:@"userName"];
    [self viewlayer:self.visitorView];
}

#pragma mark UIView 边框编辑
- (void)viewlayer:(UIView *)view {
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor setupGreyColor] CGColor];
    self.visitorImageView.image = [UIImage imageNamed:@"login_accountNumber_gray"];
}

#pragma mark textField 代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField {
        self.visitorView.layer.borderColor = [[UIColor setipBlueColor] CGColor];
        self.visitorImageView.image = [UIImage imageNamed:@"login_accountNumber_blue"];
        
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
        self.visitorView.layer.borderColor = [[UIColor setupGreyColor] CGColor];
        self.visitorImageView.image = [UIImage imageNamed:@"login_accountNumber_gray"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.visitorTextField resignFirstResponder];
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


#pragma mark - 刷卡数据返回  错误 报告
- (void)lanyaShuakareturnPromptActioninteger:(NSInteger)promptInteger {
    switch (promptInteger) {
        case 0x00:
            [self alertViewmessage:@"此卡没有刷设备!"];
            break;
        case 0x2d:
            [self alertViewmessage:@"此卡为新发卡！"];
            break;
        case 0x1f:
        case 0x04:
            [self alertViewmessage:@"此卡被复制过!"];
            break;
        case 0x3c:
        case 0x3d:
            [self alertViewmessage:@"系统自动挂失!"];
            break;
        case 0x12:
            [self alertViewmessage:@"此卡已被挂失!"];
            break;
        case 0x22:
            [self alertViewmessage:@"读卡器通讯错误!"];
            break;
        case 0x0d:
            [self alertViewmessage:@"此卡地址与设备不符!"];
            break;
        case 0x0f:
            [self alertViewmessage:@"此卡不在准进时段内!"];
            break;
        case 0x11:
            [self alertViewmessage:@"此卡有效期已过!"];
            break;
        case 0x1a:
            [self alertViewmessage:@"此卡次数已用完!"];
            break;
        case 0x14:
            [self alertViewmessage:@"此卡次数为0!"];
            break;
        case 0x30:
            [self alertViewmessage:@"防潜返功能启动!"];
            break;
        case 0x33:
            [self alertViewmessage:@"防潜返没有压地感输入!"];
            break;
        case 0x34:
            [self alertViewmessage:@"此设置卡为UID复制卡!"];
            break;
        case 0x2a:
            [self alertViewmessage:@"此用户卡为UID复制卡!"];
            break;
        case 0x2b:
            [self alertViewmessage:@"存储器错误1!"];
            break;
        case 0x3b:
            [self alertViewmessage:@"存储器错误2!"];
            break;
        case 0x2c:
            [self alertViewmessage:@"效验码错误!"];
            break;
        case 0x24:
            [self alertViewmessage:@"刷新附属地址错误!"];
            break;
        case 0x05:
            [self alertViewmessage:@"动态码处理错误!"];
            break;
        case 0x35:
        case 0x3e:
        case 0x36:
        case 0x20:
        case 0x3f:
        case 0x2e:
        case 0x37:
        case 0x40:
        case 0x38:
        case 0x21:
        case 0x41:
        case 0x2f:
        case 0x39:
        case 0x42:
        case 0x3a:
            [self paybycardSuccessAction];
            [self promptInformationActionWarningString:@"正常进入"];
            break;
        default:
            [self promptInformationActionWarningString:@"出现异常错误！"];
            break;
    }

}

// 刷卡次数更新
- (void)paybycardSuccessAction {
    self.readDataArr = [self.tool selectWithClass:[VisitorCalss class] params:nil];
    NSString *lanyaDataStr = [self userInfoReaduserkey:@"userInformation"];
    for (NSInteger j=0; j <self.readDataArr.count; j++) {
        self.viReadClass = self.readDataArr[j];
        if (self.viReadClass.visitorName == [lanyaDataStr integerValue]){
            j = self.readDataArr.count + 1;
        }
    }
    
    self.viReadClass.visitorFrequency=self.viReadClass.visitorFrequency-1;
    if (self.viReadClass.visitorFrequency == 0){
       [self.tool deleteRecordWithClass:[VisitorCalss class] andKey:@"visitorName" isEqualValue:lanyaDataStr];
        self.shukaButton.backgroundColor = [UIColor setupGreyColor];
        [self userInfowriteuserkey:@"lanyaVisitorAESData" uservalue:@""];
        
    }else{
      [self.tool updateWithObj:self.viReadClass andKey:@"visitorName" isEqualValue:lanyaDataStr];
    }
  self.visitorViewControllerDataSource.beizhuNameArray = [self.tool selectWithClass:[VisitorCalss class] params:nil];
   [self.visitorTableView reloadData];  //刷新 蓝牙选择
}
@end
