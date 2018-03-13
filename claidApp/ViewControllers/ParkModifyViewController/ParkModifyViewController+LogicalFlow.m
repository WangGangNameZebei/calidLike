//
//  ParkModifyViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/9/15.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ParkModifyViewController+LogicalFlow.h"
#import "ParkModifyViewController+Configuration.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"
#import "UIImage+Utility.h"
@implementation ParkModifyViewController (LogicalFlow)

#pragma mark- 获取小区信息
- (void)getpostInfoAction {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"ppt_cell_id":[self userInfoReaduserkey:@"districtNumber"]};
    [manager POST:CHANGE_GET_OF_INFO_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        UIImage *imagedata;
        NSMutableArray *imdataArray = [NSMutableArray array];
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200){  //
            NSString *dataPD;
            NSDictionary *resultInfoDic = [resultDic objectForKey:@"data"];
            dataPD = [resultInfoDic objectForKey:@"ppt_name"];
            if (dataPD==nil || dataPD==NULL || [dataPD isKindOfClass:[NSNull class]]) {
                self.parkNameTextfield.text = @"";
            } else {
                self.parkNameTextfield.text = dataPD;
            }
           
            dataPD = [resultInfoDic objectForKey:@"property_name"];
            if (dataPD==nil || dataPD==NULL || [dataPD isKindOfClass:[NSNull class]]) {
                self.propertyNameTextField.text = @"";
            } else {
                self.propertyNameTextField.text = dataPD;
            }
            
            dataPD = [resultInfoDic objectForKey:@"property_phone"];
            if (dataPD==nil || dataPD==NULL || [dataPD isKindOfClass:[NSNull class]]) {
                self.propertyPhoneNumber.text = @"";
            } else {
                self.propertyPhoneNumber.text = dataPD;
            }
            dataPD = [resultInfoDic objectForKey:@"ppt_loc"];
            if (dataPD==nil || dataPD==NULL || [dataPD isKindOfClass:[NSNull class]]) {
                 [self locationEdit];
                 [self promptInformationActionWarningString:@"地址暂无，此位置是由定位获得!"];
    
            } else {
                self.parkAddressTextfield.text =dataPD;
            }
            
            NSString *strimage=[resultInfoDic objectForKey:@"property_pictrue_path"];
            if (![strimage isKindOfClass:[NSNull class]] && strimage.length > 8){
                NSArray *temp=[strimage componentsSeparatedByString:@","];
                for (int j = 0; j < temp.count; j++) {
                    NSString *large = [NSString stringWithFormat:@"http://sycalid.cn//%@",temp[j]];
                    imagedata = [UIImage getImageFromURL:large];
                 
                    [imdataArray addObject:imagedata];
                }
                self.pickerV.preShowMedias =imdataArray;
            }
            
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){ //过期
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self getpostInfoAction];
        } else {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
            
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
    }];
}
#pragma mark- 提交小区信息
- (void)districtInfoPOSTNameStr:(NSString *)nameStr dataStr:(NSString *)dataStr propertyName:(NSString *)propertyName propertyPhone:(NSString *)propertyPhone{
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSString *pictrueChangeStr = [NSString stringWithFormat:@"%d",self.pictrueChangeBool];
    NSDictionary *parameters = @{@"ppt_cell_id":[self userInfoReaduserkey:@"districtNumber"],@"ppt_name":nameStr,@"ppt_loc":dataStr,@"is_pictrue_change":pictrueChangeStr,@"property_phone":propertyPhone,@"property_name":propertyName};
    
    [manager POST:CHANGE_OF_INFO_URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *imagedata;
        //利用for循环上传多张图片
        for (NSInteger i = 0; i < self.imageDataArray.count; i++) {
            imagedata = [self.imageDataArray objectAtIndex:i];
            imagedata =  [UIImage scaleImage:imagedata toKb:500];
            NSData *imageData = UIImagePNGRepresentation(imagedata);
            [formData appendPartWithFileData:imageData name:@"property_pictrue" fileName:[NSString stringWithFormat:@"%ld.png", (long)i] mimeType:@"image/png"];
        }
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200){  //
            [self promptInformationActionWarningString:@"园区信息提交成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){ //过期
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self districtInfoPOSTNameStr:nameStr dataStr:dataStr propertyName:propertyName propertyPhone:propertyPhone];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 326 || [[resultDic objectForKey:@"status"] integerValue] == 203 || [[resultDic objectForKey:@"status"] integerValue] == 204 || [[resultDic objectForKey:@"status"] integerValue] == 100) {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        } else {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
            
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
    }];
    
  
}

- (AFHTTPRequestOperationManager *)tokenManager {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}

@end
