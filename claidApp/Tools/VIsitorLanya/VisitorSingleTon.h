//
//  VisitorSingleTon.h
//  claidApp
//
//  Created by kevinpc on 2017/1/18.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@protocol VisitorDataToVCDelegate <NSObject>           //主界面 连接 蓝牙
@optional
- (void)visitorEditInitPeripheralData:(NSInteger )data;      //蓝牙状态标识代理
@end


@interface VisitorSingleTon : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (nonatomic, assign) id <VisitorDataToVCDelegate> delegate;

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (strong, nonatomic) CBCharacteristic *writeCharacteristic;

@property (strong, nonatomic) NSMutableArray *nServices;
@property (strong, nonatomic) NSMutableArray *PeripheralArray;
@property (assign, nonatomic) double delayInSeconds;        //扫描时长
@property (strong, nonatomic) NSString *receiveData;   // 返回数据

+ (VisitorSingleTon *)sharedInstance;
- (void)initialization;

- (void)sendCommand:(NSString *)String;   //  发送数据
-(void)connectClick:(CBPeripheral *)peripheral;         //连接外设
- (void)disConnection;      // 断开蓝牙
- (void)getPeripheralWithIdentifierAndConnect:(NSString *)identifierStr;       //目标 连接蓝牙

@end
