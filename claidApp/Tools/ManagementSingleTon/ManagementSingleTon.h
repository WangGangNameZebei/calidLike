//
//  ManagementSingleTon.h
//  claidApp
//
//  Created by Zebei on 2017/11/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <AESCrypt.h>

@protocol managementdelegate <NSObject>
@optional
- (void)managementtishiFrame:(NSString *)string;     // 提示
@end

@interface ManagementSingleTon : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (nonatomic, strong) CBCentralManager *pAmanager;
@property (nonatomic, strong) CBPeripheral *pAperipheral;
@property (strong, nonatomic) CBCharacteristic *pAwriteCharacteristic;


@property (strong, nonatomic) NSMutableArray *mServices;
@property (strong, nonatomic) NSMutableArray *mPeripheralArray;
@property (assign, nonatomic) double mdelayInSeconds;        //扫描时长
@property (strong, nonatomic) NSString *receiveData;
@property (nonatomic, assign) id <managementdelegate> delegate;


+(ManagementSingleTon *)sharedInstance;
- (void)initialization;
-(void)startScan;                                         //扫描外设
-(void)disConnection;                                     // 断开蓝牙
- (void)connectClick:(CBPeripheral *)peripheral;            //连接外设
- (void)getPeripheralWithIdentifierAndConnect:(NSString *)identifierStr;   //uuid 目标 连接 蓝牙
- (void)sendCommand:(NSString *)String;// 写

@end
