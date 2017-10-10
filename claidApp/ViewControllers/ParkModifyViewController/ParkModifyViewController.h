//
//  ParkModifyViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/9/15.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"

@interface ParkModifyViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *parkNameTextfield;
@property (strong, nonatomic) IBOutlet UITextField *parkAddressTextfield;
@property (strong, nonatomic) IBOutlet UITextView *parkAddressTextView;


@property (strong, nonatomic)NSString *addressString;  //  定位地址
@property (strong, nonatomic)NSString *parkIdString;   //  园区ID
@end
