//
//  ParkModifyViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/9/15.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ParkModifyViewController.h"
#import "ParkModifyViewController+Configuration.h"
#import "ParkModifyViewController+LogicalFlow.h"

@implementation ParkModifyViewController

+ (instancetype) create {
    ParkModifyViewController *parkmodifyVC = [[ParkModifyViewController alloc] initWithNibName:@"ParkModifyViewController" bundle:nil];
    return parkmodifyVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
- (IBAction)returnButtonAction:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)modifyButtonAction:(id)sender {
    if (self.parkAddressTextfield.text.length < 4){
        [self districtInfoPOSTNameStr:self.parkNameTextfield.text dataStr:[NSString stringWithFormat:@"%@%@",self.addressString,self.parkAddressTextView.text] propertyName:self.propertyNameTextField.text propertyPhone:self.propertyPhoneNumber.text];
    } else {
        [self districtInfoPOSTNameStr:self.parkNameTextfield.text dataStr:[NSString stringWithFormat:@"%@%@",self.parkAddressTextfield.text,self.parkAddressTextView.text] propertyName:self.propertyNameTextField.text propertyPhone:self.propertyPhoneNumber.text];
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
