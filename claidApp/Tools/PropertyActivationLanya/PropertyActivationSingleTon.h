//
//  PropertyActivationSingleTon.h
//  claidApp
//
//  Created by kevinpc on 2017/4/28.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <AESCrypt.h>
#import "SingleTon.h"
#import "ClassUserInfo.h"
#import "DBTool.h"

@protocol pALanyaDelegate <NSObject>
@optional
- (void)pADoSomethingEveryFrame:(NSMutableArray *)array;     // 扫描设备代理
- (void)pADoSomethingtishiFrame:(NSString *)string;     // 提示
@end

@interface PropertyActivationSingleTon : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *pAmanager;
@property (nonatomic, strong) CBPeripheral *pAperipheral;
@property (strong, nonatomic) CBCharacteristic *pAwriteCharacteristic;


@property (strong, nonatomic) NSMutableArray *pAnServices;
@property (strong, nonatomic) NSMutableArray *pAPeripheralArray;
@property (assign, nonatomic) double pAdelayInSeconds;        //扫描时长
@property (strong, nonatomic) NSString *receiveData;
@property (strong, nonatomic) SingleTon *singleton;
@property (nonatomic, assign) id <pALanyaDelegate> delegate;

@property (strong,nonatomic)DBTool *pAtool;                   //数据库
@property (strong, nonatomic)ClassUserInfo *classUserInfo;      //数据库类

+(PropertyActivationSingleTon *)sharedInstance;
- (void)initialization;
-(void)startScan;                                         //扫描外设
-(void)disConnection;                                     // 断开蓝牙
- (void)connectClick:(CBPeripheral *)peripheral;            //连接外设



@end
