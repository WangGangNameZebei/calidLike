//
//  MycradInfoViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/5/8.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MycradInfoViewController+Configuration.h"
#import "MycradInfoTableViewCell.h"

@implementation MycradInfoViewController (Configuration)
- (void)configureViews {
    [self infoTextToolArrayEdit];
    [self mycradInfoTableViewEdit];
 
}

- (void)infoTextToolArrayEdit {
    self.dbTool = [DBTool sharedDBTool];
    NSMutableArray *data = [self.dbTool selectWithClass:[ClassUserInfo class] params:nil];
    if (data.count == 0){
       self.myinfotextArray = [NSMutableArray arrayWithObjects:@"暂无数据",@"暂无数据",@"暂无数据",@"暂无数据",@"暂无数据",@"暂无数据",@"暂无数据", nil];
    } else {
      self.infoclassUser = [data objectAtIndex:0];
      self.myinfotextArray = [NSMutableArray arrayWithObjects:self.infoclassUser.uniqueCodeStr,self.infoclassUser.userNameStr,self.infoclassUser.validityStr,self.infoclassUser.telePhoneStr,self.infoclassUser.noteStr,self.infoclassUser.addressStr,self.infoclassUser.eqIdStr, nil];
    }
    
}


#pragma mrak - UItableViewEdit 
- (void)mycradInfoTableViewEdit {
    [self.myCradInfoTableView registerNib:[UINib nibWithNibName:@"MycradInfoTableViewCell" bundle:nil] forCellReuseIdentifier:MY_CRAD_INFO_TABLEVIEW_CELL];
    self.mycradInfoViewControllerDataSource = [MycradInfoViewControllerDataSource new];
    self.myCradInfoTableView.delegate = self;
    self.myCradInfoTableView.dataSource = self.mycradInfoViewControllerDataSource;
    self.mycradInfoViewControllerDataSource.infoTitleArray = [NSMutableArray arrayWithObjects:@"小区号",@"名 称",@"有效期",@"电 话",@"备 注",@"楼 层",@"地址", nil];
    self.mycradInfoViewControllerDataSource.infoTextArray = self.myinfotextArray;
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MycradInfoTableViewCell *mycell = [MycradInfoTableViewCell create];
    [mycell updateContentText:[self.myinfotextArray objectAtIndex:indexPath.row]];
    return [mycell updateCellHeight];
}

@end
