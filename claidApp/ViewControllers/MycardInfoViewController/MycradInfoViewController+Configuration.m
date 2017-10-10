//
//  MycradInfoViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/5/8.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MycradInfoViewController+Configuration.h"
#import "UIColor+Utility.h"
#import "UIScreen+Utility.h"

@implementation MycradInfoViewController (Configuration)
- (void)configureViews {
 
    [self selectButtonViewEdit];
    [self switchViewEdit];
 
}

- (void)selectButtonViewEdit {
    self.myinfoNameArray =[NSMutableArray array];
    
    NSInteger selectNameNumber = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userNumber"] integerValue];  //查看 几个小区
    NSString * nameStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];               //记录当前小区
    for (NSInteger i = 0;i < selectNameNumber; i++) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)i] forKey:@"currentUser"]; //
        [self.myinfoNameArray addObject:[self userInfoReaduserkey:@"districtName"]];
    }
     [[NSUserDefaults standardUserDefaults] setObject:nameStr forKey:@"currentUser"];    //恢复当前小区的存储
    
    float width=[UIScreen screenWidth] -150;
    self.selectNameView=[[SXSearchHeadView alloc] initWithFrame:CGRectMake([UIScreen screenWidth] - width, self.myInfoNameView.frame.origin.y,width, 45) andDataSource:self.myinfoNameArray];
    __weak MycradInfoViewController *vc=self;
    
    //接受点击button时的下标
    self.selectNameView.titleBlock=^(NSInteger index){
        [vc showOrHiddenWhenTheValueChanged:index];
    };
    
    //接收点击cell时的消息
    //当headView的cell被点击时，收回tableView
    __weak SXSearchHeadView *view=self.selectNameView;
    
    self.selectNameView.selectBlock=^(NSString *str){
        [UIView animateWithDuration:.6 animations:^{
            float height=45;
            
            CGRect rect=view.frame;
            
            rect.size.height=height;
            
            view.frame=rect;
            
        }];
        
        [vc showInfoWithDynasty:view.dataButton.currentTitle];
    };
    
    [self.view addSubview:self.selectNameView];
}
//选择完成之后调用
- (void)showInfoWithDynasty:(NSString *)dynasty {
    NSLog(@"-------------%@",dynasty);
    
}
#pragma mark - 根据回调回来的index来改变headView的frame
-(void)showOrHiddenWhenTheValueChanged:(NSInteger)value{
    
    //    高度都是我随便写的，如有不同需要，比如数组的数据个数不一样，可以再调
    __block float height;
    /*
     加__block原因是：block块里面不可以对局部变量赋值。
     想要在block块里对局部变量赋值有两个方案：
     1.将局部变量升级为全局变量
     2.局部变量前加__block
     */
    
    //    当两次点击的是同一个按钮时，value为0
    if (value==0) {
        
        [UIView animateWithDuration:.3 animations:^{
            height=45;
            
            CGRect rect=self.selectNameView.frame;
            
            rect.size.height=height;
            
            self.selectNameView.frame=rect;
            
        }];
        
    }else if (value==100){
        
        if (self.selectNameView.dataButton.currentTitle) {
            
        }
        
        [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:.5 options:0 animations:^{
            
            float height=40 *self.myinfoNameArray.count + 45;
            
            CGRect rect=self.selectNameView.frame;
            
            rect.size.height=height;
            
            self.selectNameView.frame=rect;
            
        } completion:nil];
    }
}


- (void)switchViewEdit {
    self.myInfoshakeSwitch.onTintColor = [UIColor colorFromHexCode:@"1296db"];
     self.myInfoBrightScreenSwitch.onTintColor = [UIColor colorFromHexCode:@"1296db"];
    self.myInfoAutomaticSwitch.onTintColor = [UIColor colorFromHexCode:@"1296db"];
    if ([[self userInfoReaduserkey:@"shakeswitch"] isEqualToString:@"YES"]) {
        [self.myInfoshakeSwitch setOn:YES animated:YES];
    }
    if ([[self userInfoReaduserkey:@"brightScreenswitch"] isEqualToString:@"YES"]) {
         [self.myInfoBrightScreenSwitch setOn:YES animated:YES];
    }
    if ([[self userInfoReaduserkey:@"switch"] isEqualToString:@"YES"]) {
        [self.myInfoAutomaticSwitch setOn:YES animated:YES];
    }
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
