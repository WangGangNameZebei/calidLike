//
//  MycradInfoViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/5/8.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MycradInfoViewController+Configuration.h"
#import "MycradInfoTableViewCell.h"
#import "UIColor+Utility.h"
@implementation MycradInfoViewController (Configuration)
- (void)configureViews {
  //  [self infoTextToolArrayEdit];
  //   [self mycradInfoTableViewEdit];
    [self switchViewEdit];
 
}

- (void)switchViewEdit {
    self.myInfoshakeSwitch.onTintColor = [UIColor colorFromHexCode:@"1296db"];
     self.myInfoBrightScreenSwitch.onTintColor = [UIColor colorFromHexCode:@"1296db"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"shakeswitch"] isEqualToString:@"YES"]) {
        [self.myInfoshakeSwitch setOn:YES animated:YES];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"brightScreenswitch"] isEqualToString:@"YES"]) {
         [self.myInfoBrightScreenSwitch setOn:YES animated:YES];
    }
}
- (void)infoTextToolArrayEdit {
    self.dbTool = [DBTool sharedDBTool];
    NSMutableArray *data = [self.dbTool selectWithClass:[ClassUserInfo class] params:nil];
    if (data.count == 0){
       self.myinfotextArray = [NSMutableArray arrayWithObjects:@"暂无数据",@"暂无数据",@"暂无数据",@"暂无数据",@"暂无数据",@"暂无数据",@"暂无数据", nil];
    } else {
      self.infoclassUser = [data objectAtIndex:0];
        NSString *louceng = @"";
        NSInteger intAdd;
        for (NSInteger AA = 1; AA < 65; AA++) {
            intAdd = [self judgeFunction:self.infoclassUser.addressStr dataInt:AA];
            if (intAdd == 1) {
                louceng = [louceng stringByAppendingString:[NSString stringWithFormat:@"%ld层 ",AA]];
            }
        
        }
      self.myinfotextArray = [NSMutableArray arrayWithObjects:self.infoclassUser.uniqueCodeStr,self.infoclassUser.userNameStr,self.infoclassUser.validityStr,self.infoclassUser.telePhoneStr,self.infoclassUser.noteStr,louceng,self.infoclassUser.eqIdStr, nil];
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
#pragma mark - 解析数据
- (NSInteger)judgeFunction:(NSString *)datastr dataInt:(NSInteger)dataInt {
    NSInteger add1 = 0,add2 = 0,add3 = 0;
    NSInteger add4;
    if ((dataInt % 4) > 0 || dataInt < 4) {
        add2 = dataInt / 4;         //字符串的几个数字
        add3 = dataInt % 4;         //这个数字的第几位
    } else {
        add2 = dataInt / 4 - 1;
    }

    add4 = [self changeToIntString:[datastr substringWithRange:NSMakeRange(add2,1)]];
    switch (add3) {
        case 1:
            add1  = add4 % 2;
            break;
        case 2:
            add1 = (add4 / 2) % 2;
            break;
        case 3:
            add1 = (add4 / 4) % 2;
            break;
        default:
            add1 = add4 / 8;
            break;
    }
    return add1;
    
}
- (int)changeToIntString:(NSString *)letter {
    
    if ([letter isEqualToString:@"0"]||[letter isEqualToString:@"1"]||[letter isEqualToString:@"2"]||[letter isEqualToString:@"3"]||
        [letter isEqualToString:@"4"]||[letter isEqualToString:@"5"]||[letter isEqualToString:@"6"]||[letter isEqualToString:@"7"]||
        [letter isEqualToString:@"8"]||[letter isEqualToString:@"9"]) {
        return [letter intValue];
    }
    if ([letter isEqualToString:@"a"]||[letter isEqualToString:@"A"]) {
        
        return 10;
        
    }else if ([letter isEqualToString:@"B"]||[letter isEqualToString:@"b"]) {
        
        return 11;
        
    }else if ([letter isEqualToString:@"c"]||[letter isEqualToString:@"C"]) {
        
        return 12;
        
    }else if ([letter isEqualToString:@"D"]||[letter isEqualToString:@"d"]) {
        
        return 13;
        
    } else if ([letter isEqualToString:@"e"]||[letter isEqualToString:@"E"]) {
        
        return 14;
        
    } else if ([letter isEqualToString:@"f"]||[letter isEqualToString:@"F"]) {
        
        return 15;
        
    }
    return 0;
}


@end
