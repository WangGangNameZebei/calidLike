//  BlueTooth4.0
//
//  Created by zebei on 16/5/13.
//  Copyright © 2016年 wangang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol sendDataToVCDelegate <NSObject>
@optional
- (void)DoSomethingEveryFrame:(NSArray *)array;
- (void)recivedPeripheralData:(id)data;
- (void)switchEditInitPeripheralData:(NSInteger )data;

@end
#define DataHasBeenHandRing @"DataHasBeenHandRing"
@interface SingleTon : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    NSArray *_bleList;

}
@property (nonatomic, assign) id <sendDataToVCDelegate> delegate;
@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (strong, nonatomic) CBCharacteristic *writeCharacteristic;
@property (strong, nonatomic) NSMutableArray *nServices;
@property (strong, nonatomic) NSMutableArray *PeripheralArray;
@property (assign, nonatomic) double delayInSeconds;//扫描时长
@property (assign, nonatomic) BOOL identiFication;   //自动连接 和 手动连接  标识
@property (assign, nonatomic) BOOL tarScanBool;   //   目标扫描 和  扫描 标识
@property (strong, nonatomic) NSTimer * scanTimer ;

+ (SingleTon *)sharedInstance;

- (void)initialization;
- (void)getPeripheralWithIdentifierAndConnect:(NSString *)identifierStr;
- (void)sendCommand:(NSString *)String;
- (void)startScan;
- (void)stopScan;
- (void)connectClick:(CBPeripheral *)peripheral;
- (void)disConnection;
- (void)targetScan;      //目标扫描
@end
