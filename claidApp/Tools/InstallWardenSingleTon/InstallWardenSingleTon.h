//
//  InstallWardensingleTon.h
//  claidApp
//
//  Created by kevinpc on 2017/9/19.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreBluetooth/CoreBluetooth.h>
#import <AESCrypt.h>
#import "InstallCardData.h"
#import "DBTool.h"
#import "BaseViewController.h"
@protocol installLanyaDelegate <NSObject>
@optional
- (void)iwinstallDoSomethingtishiFrame:(NSString *)string;     // 提示
- (void)iwinstallEditInitPeripheralData:(NSInteger )data;
@end

@interface InstallWardensingleTon : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *iwmanager;
@property (nonatomic, strong) CBPeripheral *iwperipheral;
@property (strong, nonatomic) CBCharacteristic *iwwriteCharacteristic;
@property (strong, nonatomic) NSMutableArray *iwnServices;
@property (strong, nonatomic) NSMutableArray *iwPeripheralArray;
@property (assign, nonatomic) double iwdelayInSeconds;        //扫描时长

@property (nonatomic, assign) id <installLanyaDelegate>installDelegate;

@property (assign, nonatomic) BOOL iwidentiFication;          //设置 发卡器连接标识
@property (assign, nonatomic) BOOL iwtarScanBool;             //   目标扫描  标识
@property (assign, nonatomic) BOOL iwinstallBool;             //   设置卡  连接标识
@property (strong, nonatomic) NSTimer * iwscanTimer;
@property (strong, nonatomic) NSTimer * iwshukaTimer;         //刷卡 计时
@property (strong, nonatomic) NSTimer * iwhoutaiTimer;
@property (strong, nonatomic) NSString *iwreceiveData;
@property (assign, nonatomic) BOOL iwjieHhou;                 //发卡返回标识
@property (strong,nonatomic)DBTool *iwtool;                   //数据库
@property (strong, nonatomic)InstallCardData *iwinstallCardData;      //数据库类
@property (strong, nonatomic) NSMutableArray *iwnumberArrar ;         //数据库便利数组
@property (strong, nonatomic) BaseViewController *iwbaseViewController;



+ (InstallWardensingleTon *)iwsharedInstance;

- (void)iwinitialization;
- (void)iwgetPeripheralWithIdentifierAndConnect:(NSString *)identifierStr;        //目标扫描
- (void)iwsendCommand:(NSString *)String;
- (void)iwstartScan;          //扫描
- (void)iwstopScan;           //停止扫描
- (void)iwconnectClick:(CBPeripheral *)peripheral;            //连接外设
- (void)iwdisConnection;      // 断开蓝牙
- (void)iwtargetScan;         //目标扫描
- (void)iwshoudongConnectClick:(NSString *)peripheralstr;    // 手动 连接蓝牙设备
- (void)iwinstallShoudongConnectClick:(NSString *)uuids;   //设置卡  连接 蓝牙

- (CBPeripheral *)iwlanyaNameString:(NSString *)uuidString;

@end
