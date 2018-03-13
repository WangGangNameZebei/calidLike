//
//  MycradInfoViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/5/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "MyInfoAvatarTableViewCell.h"
#import "MyInfoCommunityTableViewCell.h"
#import "MyInfoTableViewCell.h"

@interface MycradInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,myInfoAvatarTableViewCellDelegate,MyInfoTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myInfoTableView;
@property (strong, nonatomic) IBOutlet UIButton *myInfoEditButton;
@property (assign, nonatomic) BOOL editBool; 
@property (strong, nonatomic) NSMutableArray *mydataArray;
@property (strong, nonatomic) UIImage *imagedata;// 头像
@property (strong, nonatomic) NSString *userNameString; //用户名称 
@property (strong, nonatomic)UIAlertView *avatarAlertView;
@end
