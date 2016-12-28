//  BlueTooth4.0
//
//  Created by zebei on 16/5/13.
//  Copyright © 2016年 wangang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <AESCrypt.h>


/*输出宏*/
#define AES_PASSWORD @"ufwjfitn"
#ifdef DEBUG
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define LOG(...); #define LOG_METHOD;
#endif


@protocol sendDataToVCDelegate <NSObject>           // 蓝牙连接
@optional
- (void)DoSomethingEveryFrame:(NSMutableArray *)array;     // 扫描设备代理
- (void)DoSomethingtishiFrame:(NSString *)string;     // 扫描设备代理
@end


@protocol installLanyaDelegate <NSObject>
@optional
- (void)installDoSomethingEveryFrame:(NSMutableArray *)array;     // 扫描设备代理
- (void)installDoSomethingtishiFrame:(NSString *)string;     // 扫描设备代理
@end

@protocol mindsendDataToVCDelegate <NSObject>           //主界面 连接 蓝牙
@optional
- (void)switchEditInitPeripheralData:(NSInteger )data;      //蓝牙状态标识代理

@end

#define DataHasBeenHandRing @"DataHasBeenHandRing"
@interface SingleTon : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    NSArray *_bleList;

}
@property (nonatomic, assign) id <sendDataToVCDelegate> delegate;
@property (nonatomic, assign) id <mindsendDataToVCDelegate> deleGate;
@property (nonatomic, assign) id <installLanyaDelegate> installDelegate;

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (strong, nonatomic) CBCharacteristic *writeCharacteristic;
@property (strong, nonatomic) NSMutableArray *nServices;
@property (strong, nonatomic) NSMutableArray *PeripheralArray;
@property (assign, nonatomic) double delayInSeconds;        //扫描时长
@property (assign, nonatomic) BOOL identiFication;          //目标连接  标识
@property (assign, nonatomic) BOOL tarScanBool;             //   目标扫描  标识
@property (strong, nonatomic) NSTimer * scanTimer;
@property (strong, nonatomic) NSTimer * shukaTimer;         //刷卡 计时
@property (strong, nonatomic) NSTimer * houtaiTimer;         
@property (strong, nonatomic) NSString *receiveData;
@property (assign, nonatomic) BOOL jieHhou;                 //发卡返回标识


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
- (void)shoudongConnectClick:(CBPeripheral *)peripheral;    // 手动 连接蓝牙设备
- (int)turnTheHexLiterals:(NSString *)string;
- (CBPeripheral *)lanyaNameString:(NSString *)uuidString;
@end
