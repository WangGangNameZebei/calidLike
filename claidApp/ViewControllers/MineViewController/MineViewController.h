//
//  MineViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "SingleTon.h"
#import "MinViewControllerDataSource.h"
@interface MineViewController : BaseViewController<sendDataToVCDelegate,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *lanyaLinkButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *shuaKaButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UISwitch *zidongSwitch;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *functionListContainerView;
@property (weak, nonatomic) IBOutlet UITableView *functionListUiTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *functionNSLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *functionViewheight;

@property (strong, nonatomic) MinViewControllerDataSource *minViewControllerDataSource;
@property (strong, nonatomic) NSMutableArray *peripherArray;
@property (strong, nonatomic) SingleTon *ton;
@end
