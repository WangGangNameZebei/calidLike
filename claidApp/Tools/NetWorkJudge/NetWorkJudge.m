//
//  NetWorkJudge.m
//  claidApp
//
//  Created by kevinpc on 2016/11/15.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "NetWorkJudge.h"

@implementation NetWorkJudge
+(void)StartWithBlock:(void (^)(NSInteger))block{
    static  NetWorkJudge *monitor;
    if (!monitor){
        monitor = [[NetWorkJudge alloc]init];
    }
    monitor.callBackBlock = block;
    [[NSNotificationCenter defaultCenter] addObserver:monitor selector:@selector(applicationNetworkStatusChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
    [reachability startMonitoring];
   
}

-(void)applicationNetworkStatusChanged:(NSNotification*)userinfo{
    NSInteger status = [[[userinfo userInfo]objectForKey:@"AFNetworkingReachabilityNotificationStatusItem"] integerValue];
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable:
            [self withoutNetwork];
            return;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            [self wwanNetwork];
            return;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            [self wifiNetwork];
            return;
        case AFNetworkReachabilityStatusUnknown:
        default:
            [self unknowNetwork];
            return;
    }
}

-(void)withoutNetwork{
    self.callBackBlock (WithoutNetwork);
}
-(void)wwanNetwork{
    CTTelephonyNetworkInfo *networkStatus = [[CTTelephonyNetworkInfo alloc]init];
    NSString *currentStatus  = networkStatus.currentRadioAccessTechnology;
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]){
        self.callBackBlock(GPRS);
        //GPRS网络
        return;
    }
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]){
        self.callBackBlock(Edge);
        //2.75G的EDGE网络
        return;
    }
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
        self.callBackBlock(WCDMA);
        //3G WCDMA网络
        return;
    }
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
        self.callBackBlock(HSDPA);
        //3.5G网络
        return;
    }
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
        self.callBackBlock(HSUPA);
        //3.5G网络
        return;
    }
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
        self.callBackBlock(CDMA1xNetwork);
        //CDMA2G网络
        return;
    }
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
        self.callBackBlock(CDMAEVDORev0);
        //CDMA的EVDORev0(3G)
        return;
    }
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
        self.callBackBlock(CDMAEVDORevA);
        //CDMA的EVDORevA(3G)
        return;
    }
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
        self.callBackBlock(CDMAEVDORevB);
        //CDMA的EVDORev0(3G)
        return;
    }
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
        self.callBackBlock(HRPD);
        //HRPD网络
        return;
    }
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
        self.callBackBlock(LTE);
        //LTE4G网络
        return;
    }
}
-(void)wifiNetwork{
    self.callBackBlock (WifiNetwork);
}
-(void)unknowNetwork{
    self.callBackBlock(UnknowNetwork);
}
@end
