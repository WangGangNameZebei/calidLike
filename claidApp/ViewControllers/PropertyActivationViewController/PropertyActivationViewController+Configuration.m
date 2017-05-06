//
//  PropertyActivationViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/5/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController+Configuration.h"
#import "MinFuncTionTableViewCell.h"

@implementation PropertyActivationViewController (Configuration)

- (void)configureViews {
    [self singleTonEdit];
    [self paTableViewEdit];
}

- (void)singleTonEdit {
    self.paSingleTon = [PropertyActivationSingleTon sharedInstance];
    [self.paSingleTon initialization];
    self.paSingleTon.delegate = self;
    self.paLnyaNameArray = [NSMutableArray array];
}

- (void)paTableViewEdit {
    [self.paVCTableiVew registerNib:[UINib nibWithNibName:@"MinFuncTionTableViewCell" bundle:nil] forCellReuseIdentifier:MINN_FUNCTION_CELL_NIB];
    
    self.propertyActionViewControllerDataSource = [PropertyActivationViewControllerDataSource new];
    self.paVCTableiVew.delegate = self;
    self.paVCTableiVew.dataSource = self.propertyActionViewControllerDataSource;
    self.propertyActionViewControllerDataSource.pAVCDataSourceArray = self.paLnyaNameArray;
}

#pragma mark paLanyaDelegate 

- (void)pADoSomethingEveryFrame:(NSMutableArray *)array {
     self.paLnyaNameArray = array;
}

- (void)pADoSomethingtishiFrame:(NSString *)string {
    if ([string isEqualToString:@"连接成功"]) {
        [self promptInformationActionWarningString:string];
    } else {
        //提交  
    }
}
    
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
@end
