//
//  SingleTon+MainHairpin.m
//  claidApp
//
//  Created by kevinpc on 2017/1/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "SingleTon+MainHairpin.h"
#import "CalidTool.h"

@implementation SingleTon (MainHairpin)
- (void)mainHairpinReturnData:(NSString *)characteristic{
    if (!self.jieHhou && [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
        [self.deleGate switchEditInitPeripheralData:3];
        
    }
    if ([[characteristic substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"ea"]) {
        if ([self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.deleGate switchEditInitPeripheralData:[CalidTool turnTheHexLiterals:[characteristic substringWithRange:NSMakeRange(24,2)]]];
        }
        switch ([CalidTool turnTheHexLiterals:[characteristic substringWithRange:NSMakeRange(24,2)]]) {
            case 0x35:
            case 0x36:
            case 0x2e:
            case 0x37:
            case 0x38:
            case 0x21:
            case 0x2f:
            case 0x39:
            case 0x3a:
               [self creditCardRecordsActionDatastr:[characteristic substringWithRange:NSMakeRange(2,24)]];
                 break;
            default:
                break;
        }
        
    }  else {
        self.receiveData = [characteristic substringWithRange:NSMakeRange(0,104)];
        NSString *encryptedData = [AESCrypt encrypt:self.receiveData password:AES_PASSWORD];  //加密
        [self.baseViewController userInfowriteuserkey:@"lanyaAESErrornData" uservalue:encryptedData];
        if ([self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.deleGate switchEditInitPeripheralData:[CalidTool turnTheHexLiterals:[characteristic substringWithRange:NSMakeRange(104,2)]]];
            
        }
    }

}
//  存储 刷卡成功记录
- (void)creditCardRecordsActionDatastr:(NSString *)dataString {
    self.tool = [DBTool sharedDBTool];
    NSInteger datanumber = 0; 
    NSArray *data = [self.tool selectWithClass:[CreditCardRecords class] params:nil];
    if (data.count == 0){
        [self.tool createTableWithClass:[CreditCardRecords class]];
    } else {
        datanumber = data.count + 1;
    }
    NSDate *date=[NSDate date];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString *dateStr=[format stringFromDate:date];
    
    NSString *swipeAddress = [NSString stringWithFormat:@"%ld",[self dizhiNumberHextoDecimalActionDataStr:[dataString substringWithRange:NSMakeRange(2,4)]]];
        self.creditCardRecords = [CreditCardRecords initCreditCardRecordsswipeNumbering:datanumber communityNumber:[self.baseViewController userInfoReaduserkey:@"districtNumber"] swipeTime:dateStr swipeStatus:[dataString substringWithRange:NSMakeRange(22,2)] swipeAddress:swipeAddress swipeSensitivity:[dataString substringWithRange:NSMakeRange(20,2)]];
        [self.tool insertWithObj:self.creditCardRecords];

}
// 地址计算
- (NSInteger)dizhiNumberHextoDecimalActionDataStr:(NSString *)dataStr {
    NSInteger inthexnumber = [CalidTool turnTheHexLiterals:[dataStr substringWithRange:NSMakeRange(0,2)]] * 8;
    switch ([CalidTool turnTheHexLiterals:[dataStr substringWithRange:NSMakeRange(2,2)]]) {
        case 0x01:
            return (inthexnumber + 1);
        case 0x02:
            return (inthexnumber + 2);
        case 0x04:
            return (inthexnumber + 3);
        case 0x08:
            return (inthexnumber + 4);
        case 0x10:
            return (inthexnumber + 5);
        case 0x20:
            return (inthexnumber + 6);
        case 0x40:
            return (inthexnumber + 7);
        case 0x80:
            return (inthexnumber + 8);
            break;
        default:
            return inthexnumber;
            break;
    }
}
@end
