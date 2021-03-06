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
#import "BaseViewController.h"

@protocol pALanyaDelegate <NSObject>
@optional
- (void)pADoSomethingEveryFrame:(NSInteger)array;     // 扫描设备代理
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
@property (nonatomic, assign) id <pALanyaDelegate> delegate;

@property (strong, nonatomic)BaseViewController *baseViewController;

+(PropertyActivationSingleTon *)sharedInstance;
- (void)initialization;
-(void)startScan;                                         //扫描外设
-(void)disConnection;                                     // 断开蓝牙
- (void)connectClick:(CBPeripheral *)peripheral;            //连接外设
- (void)getPeripheralWithIdentifierAndConnect:(NSString *)identifierStr;   //uuid 目标 连接 蓝牙
- (void)sendCommand:(NSString *)String;// 写

@end
