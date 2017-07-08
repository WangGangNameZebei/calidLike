//
//  InstallLanyaDataDelegate.m
//  claidApp
//
//  Created by kevinpc on 2016/12/27.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "InstallLanyaDataDelegate.h"
#import "SingleTon.h"
@implementation InstallLanyaDataDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *periphe = [self.lanyaNameArray objectAtIndex:(indexPath.row)];
    [[SingleTon sharedInstance] shoudongConnectClick:periphe];

}


@end
