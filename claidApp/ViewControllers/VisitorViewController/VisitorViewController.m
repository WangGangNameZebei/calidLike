//
//  VisitorViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/1/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "VisitorViewController.h"
#import "VisitorViewController+Configuration.h"
#import "VisitorViewController+Animation.h"
#import "VisitorViewController+LogicalFlow.h"
#import "UIColor+Utility.h"

@implementation VisitorViewController

+ (instancetype) create {
    VisitorViewController *visitorVC = [[VisitorViewController alloc] initWithNibName:@"VisitorViewController" bundle:nil];
    return visitorVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (IBAction)returnButtonAction:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)plusLanyaButtonAction:(id)sender {
    if (self.ownerChoiceView.hidden) {
        [self animationShowFunctionView];
    } else {
        [self animationHideFunctionView];
    }
}

- (IBAction)submitButtonAction:(id)sender {
    
    if (self.visitorTextField.text.length == 0) {
        [self promptInformationActionWarningString:@"电话号码不能为空!"];
        return;
    }
    if (self.requestBool){
    self.requestBool = NO;
     [self visitorPostForPhoneNumber:self.visitorTextField.text];
       
    }
}

- (IBAction)paybyCardButtonAction:(id)sender {
   NSString *lanyaDataStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaVisitorAESData"];
    if (lanyaDataStr.length < 20){
        [self promptInformationActionWarningString:@"请点击+号选择发卡权限!"];
        return;
    }
   VisitorSingleTon *ton = [VisitorSingleTon sharedInstance];
   [ton getPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];
    
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   NSArray *dianjiArr = [self.tool selectWithClass:[VisitorCalss class] params:nil];
    if (dianjiArr.count == 0){
        [self animationHideFunctionView]; //收起tableView
        [self promptInformationActionWarningString:@"没有可用的权限!"];
        return;
    }
    self.viReadClass = dianjiArr[indexPath.row];
    if(self.viReadClass.visitorFrequency != 0){
   self.shukaButton.backgroundColor = [UIColor colorFromHexCode:@"1296db"];
      [[NSUserDefaults standardUserDefaults] setObject:self.viReadClass.visitorData forKey:@"lanyaVisitorAESData"]; //刷卡数据
      [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)self.viReadClass.visitorName] forKey:@"userInformation"];
     [self animationHideFunctionView]; //收起tableView
    } else {
          self.shukaButton.backgroundColor = [UIColor colorFromHexCode:@"C2C2C2"];
           [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"lanyaVisitorAESData"];
         [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userInformation"];
          [self.tool deleteRecordWithClass:[VisitorCalss class] andKey:@"visitorName" isEqualValue:[NSString stringWithFormat:@"%ld",(long)self.viReadClass.visitorName]];
           [self promptInformationActionWarningString:@"此权限使用已到期!"];
    
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
