//  BlueTooth4.0
//
//  Created by zebei on 16/5/13.
//  Copyright © 2016年 wangang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <AESCrypt.h>
#import "InstallCardData.h"
#import "DBTool.h"
#import "BaseViewController.h"

@protocol mindsendDataToVCDelegate <NSObject>           //主界面 连接 蓝牙
@optional
- (void)switchEditInitPeripheralData:(NSInteger )data;      //蓝牙状态标识代理

@end

#define DataHasBeenHandRing @"DataHasBeenHandRing"
@interface SingleTon : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    NSArray *_bleList;

}
@property (nonatomic, assign) id <mindsendDataToVCDelegate> deleGate;
@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (strong, nonatomic) CBCharacteristic *writeCharacteristic;
@property (strong, nonatomic) NSMutableArray *nServices;
@property (strong, nonatomic) NSMutableArray *PeripheralArray;
@property (assign, nonatomic) double delayInSeconds;        //扫描时长
@property (strong, nonatomic) NSTimer * scanTimer;
@property (strong, nonatomic) NSTimer * shukaTimer;         //刷卡 计时
@property (strong, nonatomic) NSTimer * houtaiTimer;         
@property (strong, nonatomic) NSString *receiveData;
@property (assign, nonatomic) BOOL jieHhou;                 //发卡返回标识
@property (strong,nonatomic)DBTool *tool;                   //数据库
@property (strong, nonatomic) NSMutableArray *numberArrar ;         //数据库便利数组
@property (strong, nonatomic) BaseViewController *baseViewController;



+ (SingleTon *)sharedInstance;

- (void)lanyaQiantaiAction;
- (void)lanyaHoutaiAction;
- (void)initialization;
- (void)getPeripheralWithIdentifierAndConnect:(NSString *)identifierStr;        //目标扫描
- (void)sendCommand:(NSString *)String;
- (void)startScan;          //扫描
- (void)stopScan;           //停止扫描
- (void)connectClick:(CBPeripheral *)peripheral;            //连接外设
- (void)disConnection;      // 断开蓝牙
- (void)targetScan;         //目标扫描

- (CBPeripheral *)lanyaNameString:(NSString *)uuidString;




@end
