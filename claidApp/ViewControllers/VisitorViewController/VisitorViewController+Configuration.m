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
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"lanyaVisitorAESData"];
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
           message = [[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaVisitorAESData"];
            if (message.length > 0) {
               message = @"0180010101FF3344556600000000000000000000000000000000000000000000000000000000000000";
                message = [NSString stringWithFormat:@"%@%@",@"cc",message];
                [self.visitorton sendCommand:message];       //发送数据
            } else {
                [self promptInformationActionWarningString:@"暂未发卡!"];
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
    self.shukaButton.backgroundColor = [UIColor colorFromHexCode:@"C2C2C2"];
    self.visitorTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.visitorTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.visitorTextField.delegate = self;
    [self viewlayer:self.visitorView];
}

#pragma mark UIView 边框编辑
- (void)viewlayer:(UIView *)view {
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
    self.visitorImageView.image = [UIImage imageNamed:@"login_accountNumber_gray"];
}

#pragma mark textField 代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField {
        self.visitorView.layer.borderColor = [[UIColor colorFromHexCode:@"#1296db"] CGColor];
        self.visitorImageView.image = [UIImage imageNamed:@"login_accountNumber_blue"];
        
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
        self.visitorView.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
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
        case 0x2b:
            [self alertViewmessage:@"循环用的EEPROM读写出现致命错误!"];
            break;
        case 0x34:
            [self alertViewmessage:@"在设置卡上发现的UID卡!"];
            break;
        case 0x2c:
            [self alertViewmessage:@"CRC错误或老卡变新卡时错误!"];
            break;
        case 0x24:
            [self alertViewmessage:@"被复制或写附属地址出错!"];
            break;
        case 0x04:
            [self alertViewmessage:@"卡被复制!"];
            break;
        case 0x2a:
            [self alertViewmessage:@"在用户卡上发现的UID!"];
            break;
        case 0x30:
            [self alertViewmessage:@"防潜返,已经是进入或出去!"];
            break;
        case 0x1a:
            [self alertViewmessage:@"减次数为0!"];
            break;
        case 0x1b:
            [self alertViewmessage:@"减次数为0!"];
            break;
        case 0x05:
            [self alertViewmessage:@"滚动码处理出错!"];
            break;
        case 0x1f:
            [self alertViewmessage:@"第一次被顶掉!"];
            break;
        case 0x22:
            [self alertViewmessage:@"没有通讯上!"];
            break;
        case 0x23:
            [self alertViewmessage:@"测试卡处理!"];
            break;
        case 0x35:
        case 0x36:
        case 0x20:
        case 0x2e:
        case 0x37:
        case 0x38:
        case 0x21:
        case 0x2f:
        case 0x39:
        case 0x3a:
            [self paybycardSuccessAction];
            [self promptInformationActionWarningString:@"正常进入!"];
            break;
        case 0x11:
            [self paybycardSuccessAction];
            [self promptInformationActionWarningString:@"业主权限过期!"];
            break;
        default:
            break;
    }
}

// 刷卡次数更新
- (void)paybycardSuccessAction {
    self.readDataArr = [self.tool selectWithClass:[VisitorCalss class] params:nil];
    NSString *lanyaDataStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInformation"];
    for (NSInteger j=0; j <self.readDataArr.count; j++) {
        self.viReadClass = self.readDataArr[j];
        if (self.viReadClass .visitorName == [lanyaDataStr integerValue]){
            j = self.readDataArr.count + 1;
        }
    }
    
    self.viReadClass.visitorFrequency=self.viReadClass.visitorFrequency-1;
    if (self.viReadClass.visitorFrequency == 0){
       [self.tool deleteRecordWithClass:[VisitorCalss class] andKey:@"visitorName" isEqualValue:lanyaDataStr];
        self.shukaButton.backgroundColor = [UIColor colorFromHexCode:@"C2C2C2"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"lanyaVisitorAESData"];
        
    }else{
      [self.tool updateWithObj:self.viReadClass andKey:@"visitorName" isEqualValue:lanyaDataStr];
    }

}
@end
