//
//  SingleTon+tool.m
//  claidApp
//
//  Created by kevinpc on 2017/1/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "SingleTon+tool.h"

@implementation SingleTon (tool)

//将传入的NSData类型转换成NSString并返回
- (NSString*)hexadecimalString:(NSData *)data{
    NSString* result;
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    if(!dataBuffer){
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    return result;
}

#pragma mark - 指令字面值转16进制
- (NSInteger)turnTheHexLiterals:(NSString *)string {
    
    NSString *FirstNumStr = [string substringWithRange:NSMakeRange(0,1)];
    int a = [self changeToIntString:FirstNumStr];
    NSString *SecondNumStr = [string substringWithRange:NSMakeRange(1,1)];
    int b = [self changeToIntString:SecondNumStr];
    
    return a*16+b;
    
}

- (int)changeToIntString:(NSString *)letter {
    
    if ([letter isEqualToString:@"0"]||[letter isEqualToString:@"1"]||[letter isEqualToString:@"2"]||[letter isEqualToString:@"3"]||
        [letter isEqualToString:@"4"]||[letter isEqualToString:@"5"]||[letter isEqualToString:@"6"]||[letter isEqualToString:@"7"]||
        [letter isEqualToString:@"8"]||[letter isEqualToString:@"9"]) {
        return [letter intValue];
    }
    if ([letter isEqualToString:@"a"]||[letter isEqualToString:@"A"]) {
        
        return 10;
        
    }else if ([letter isEqualToString:@"B"]||[letter isEqualToString:@"b"]) {
        
        return 11;
        
    }else if ([letter isEqualToString:@"c"]||[letter isEqualToString:@"C"]) {
        
        return 12;
        
    }else if ([letter isEqualToString:@"D"]||[letter isEqualToString:@"d"]) {
        
        return 13;
        
    } else if ([letter isEqualToString:@"e"]||[letter isEqualToString:@"E"]) {
        
        return 14;
        
    } else if ([letter isEqualToString:@"f"]||[letter isEqualToString:@"F"]) {
        
        return 15;
        
    }
    return 0;
}
#pragma mark - 产生CRC数
+ (NSString *)crc32producedataStr:(NSString *)dataStr{
    
    
    unsigned int numberKey;
    unsigned char key1[4];
    unsigned char key2[10];
    NSString * TheTwoCharacters;
    NSInteger aa;
    
    for (NSInteger j = 0; j < dataStr.length / 2; j++) {
        TheTwoCharacters = [dataStr substringWithRange:NSMakeRange(j * 2,2)];
        aa= [[SingleTon alloc] turnTheHexLiterals:TheTwoCharacters];
        key2[j] = aa;
    }
    numberKey = crcs32(key2,dataStr.length/2);
    key1[0] = numberKey>>24;
    key1[1] = numberKey>>16;
    key1[2] = numberKey>>8;
    key1[3] = numberKey;
    TheTwoCharacters = [NSString stringWithFormat:@"%02hhx%02hhx%02hhx%02hhx",key1[0],key1[1],key1[2],key1[3]];
    return TheTwoCharacters;
}
#pragma mark -  编辑 发送发卡指令 (添加随机数)
- (NSString *)payByCardInstructionsActionString:(NSString *)string {
    unsigned int numberKey;
    unsigned char key1[4];
    unsigned char key2[100];
    NSString * TheTwoCharacters;
    NSString *strOne = @"";
    NSString *strTow = @"";
    NSInteger  aa;
  
    strOne = [string substringWithRange:NSMakeRange(2, 12)];
    if ([strOne isEqualToString:@"0181000101FF"]) {  // 设置 灵敏度
        string = [string substringWithRange:NSMakeRange(2, 22)];
        for (NSInteger I = 0; I < 31; I++) {
            string = [NSString stringWithFormat:@"%@%@",string,@"00"];
        }
    } else {
        
    
        if([[string substringWithRange:NSMakeRange(22, 2)]   isEqualToString:@"01"]){       //设置卡
            strOne = @"";
            string = [string substringWithRange:NSMakeRange(2, 12)];
            aa =10000000+rand()%(99999999 - 10000000 + 1);
            strOne = [NSString stringWithFormat:@"%@%ld",strOne,(long)aa];
            
            string = [NSString stringWithFormat:@"%@%@01",string,strOne];
            if ([[self.baseViewController userInfoReaduserkey:@"setupNumber"] isEqualToString:@"0000"] || [[self.baseViewController userInfoReaduserkey:@"setupNumber"] isEqualToString:@""]){  //无随机数存储
                aa =1000+rand()%(9999 - 1000 + 1);
                [self.baseViewController userInfowriteuserkey:@"setupNumber" uservalue:[NSString stringWithFormat:@"%ld",(long)aa]]; //修改随机数

                 string = [NSString stringWithFormat:@"%@0000%ld",string,(long)aa];
                for (NSInteger I = 0; I < 27; I++) {
                    string = [NSString stringWithFormat:@"%@%@",string,@"00"];
                }
            } else {   //有
                string = [NSString stringWithFormat:@"%@%@",string,[self.baseViewController userInfoReaduserkey:@"setupNumber"]];
                for (NSInteger I = 0; I < 29; I++) {
                    string = [NSString stringWithFormat:@"%@%@",string,@"00"];
                }
 
            }
            
          

            
        } else {
            strOne = @"";
            string = [string substringWithRange:NSMakeRange(2, 12)];
            aa =10000000+rand()%(99999999 - 10000000 + 1);
            strOne = [NSString stringWithFormat:@"%@%ld",strOne,(long)aa];
            
            string = [NSString stringWithFormat:@"%@%@",string,strOne];
            for (NSInteger I = 0; I < 32; I++) {
                string = [NSString stringWithFormat:@"%@%@",string,@"00"];
            }

        }
    }
    
    for (NSInteger j = 0; j < string.length / 2; j++) {
        TheTwoCharacters = [string substringWithRange:NSMakeRange(j * 2,2)];
        aa= [self turnTheHexLiterals:TheTwoCharacters];
        key2[j] = aa;
    }
    numberKey = crcs32(key2,42);
    key1[0] = numberKey>>24;
    key1[1] = numberKey>>16;
    key1[2] = numberKey>>8;
    key1[3] = numberKey;
    strTow = [NSString stringWithFormat:@"%02hhx%02hhx%02hhx%02hhx",key1[0],key1[1],key1[2],key1[3]];
    strOne =[self jiamiaTostringAcction:string numberKey:numberKey];
    strOne = [NSString stringWithFormat:@"cc%@%@",strOne,strTow];
    return strOne;
}
#pragma mark - 发送数据加密
- (void)lanyaSendoutDataAction:(NSString *)data {
    unsigned int numberKey;
    unsigned char key1[4];
    unsigned char key2[100];
    NSString * TheTwoCharacters;
    NSString *strOne =@"";
    NSString *strTow=@"";
    NSInteger  aa;
   
    
    for (NSInteger j = 0; j < data.length / 2; j++) {
        TheTwoCharacters = [data substringWithRange:NSMakeRange(j * 2,2)];
        aa= [self turnTheHexLiterals:TheTwoCharacters];
        key2[j] = aa;
    }
    key1[0] = key2[42];
    key1[1] = key2[43];
    key1[2] = key2[44];
    key1[3] = key2[45];
    xor(key1);
    
    for(NSInteger I = 0; I < 48; I++) {
        key2[I] = key2[I]^tmpstr[I];
    }
    
    for (NSInteger i = 0; i < 48; i++) {
        strOne =[NSString stringWithFormat:@"%x",key2[i]&0xff];
        if (strOne.length == 1)
            strOne = [NSString stringWithFormat:@"0%@",strOne];
        strTow = [NSString stringWithFormat:@"%@%@",strTow,strOne];
    }
    strTow = [strTow substringWithRange:NSMakeRange(0,12)];
    if ([strTow isEqualToString:@"018100010100"]){
        if ([self.installDelegate  respondsToSelector:@selector(installEditInitPeripheralData:)]){
            [self.installDelegate installEditInitPeripheralData:3];
        }
        return;
    } else if ([strTow isEqualToString:@"018100010101"]) {
        if ([self.installDelegate  respondsToSelector:@selector(installEditInitPeripheralData:)]){
            [self.installDelegate installEditInitPeripheralData:5];
        }
        return;
    }
    
    key1[0] = key2[16];
    key1[1] = key2[17];
    key1[2] = key2[18];
    key1[3] = key2[19];
    numberKey = (key1[3]) + (key1[2]<<8) + (key1[1]<<16) + (key1[0]<<24);
    
    if (self.installBool){
        if ([self.installDelegate  respondsToSelector:@selector(installEditInitPeripheralData:)]){
            [self.installDelegate installEditInitPeripheralData:numberKey];
        }
        return;
    }
    NSString *lanyaDataStr = [AESCrypt decrypt:[self.baseViewController userInfoReaduserkey:@"lanyaAESData"] password:AES_PASSWORD];
    strOne = [lanyaDataStr substringWithRange:NSMakeRange(0,104)];
    strTow = [self jiamiaTostringAcction:strOne numberKey:numberKey];
    strTow = [NSString stringWithFormat:@"%@%@",strTow,[self jiamiaTostringAcction:[lanyaDataStr substringWithRange:NSMakeRange(104, 104)] numberKey:numberKey]];
    [self sendCommand:[NSString stringWithFormat:@"AA%@",strTow]];
}

// 加密 算法
- (NSString *)jiamiaTostringAcction:(NSString *)string numberKey:(NSInteger)number {
    unsigned char key2[100];
    NSString *strOne;
    NSString *strTow;
    NSInteger  aa;
    NSString *TheTwoCharacters;
    unsigned char key[4];
    key[0] = number>>24;
    key[1] = number>>16;
    key[2] = number>>8;
    key[3] = number;
    xor(key);
    for (NSInteger j = 0; j < string.length / 2; j++) {
        TheTwoCharacters = [string substringWithRange:NSMakeRange(j * 2,2)];
        aa= [self turnTheHexLiterals:TheTwoCharacters];
        key2[j] = aa;
    }
    for(NSInteger I = 0; I < string.length / 2; I++) {
        key2[I] = key2[I]^tmpstr[I];
    }
    strTow = @"";strOne = @"";
    for (NSInteger i = 0; i < string.length / 2; i++) {
        strOne = [NSString stringWithFormat:@"%02hhx",key2[i]];
        strTow= [NSString stringWithFormat:@"%@%@",strTow,strOne];
    }
    return strTow;
}
#pragma mark - 效验数据
- (BOOL)lanyaDataXiaoyanAction:(NSString *)data {
    unsigned int numberKey;
    unsigned char key[4];
    unsigned char key1[4];
    unsigned char key2[100];
    NSString * TheTwoCharacters;
    NSInteger  aa;
    for (NSInteger j = 0; j < data.length / 2; j++) {
        TheTwoCharacters = [data substringWithRange:NSMakeRange(j * 2,2)];
        aa= [self turnTheHexLiterals:TheTwoCharacters];
        key2[j] = aa;
    }
    key1[0] = key2[48];
    key1[1] = key2[49];
    key1[2] = key2[50];
    key1[3] = key2[51];
    xor(key1);
    
    for(NSInteger I = 0; I < 48; I++) {
        key2[I] = key2[I]^tmpstr[I];
    }
    numberKey = crcs32(key2,48);
    key[0] = numberKey>>24;
    key[1] = numberKey>>16;
    key[2] = numberKey>>8;
    key[3] = numberKey;
    if (key[0] == key1[0] && key[1] == key1[1] && key[2] == key1[2] && key[3] == key1[3]) {
        return YES;
    } else {
        return NO;
    }
}
#pragma mark - 数据解密
- (NSString *)lanyaDataDecryptedAction:(NSString *)data {
    NSString *dataString =@"";
    NSString *strrone = @"";
    unsigned char key1[4];
    unsigned char key2[100];
    NSString * TheTwoCharacters;
    NSInteger  aa;
    NSInteger datalength = data.length / 2;
    for (NSInteger j = 0; j <datalength; j++) {
        TheTwoCharacters = [data substringWithRange:NSMakeRange(j * 2,2)];
        aa= [self turnTheHexLiterals:TheTwoCharacters];
        key2[j] = aa;
        if (j > (datalength - 5)) {
            key1[j -(datalength - 4)] = key2[j];
        }
    }
    xor(key1);
    
    for(NSInteger I = 0; I < datalength - 4; I++) {
        key2[I] = key2[I]^tmpstr[I];
    }


    for (NSInteger i = 0; i < datalength - 4; i++) {
        strrone =[NSString stringWithFormat:@"%x",key2[i]&0xff];
        if (strrone.length == 1)
            strrone = [NSString stringWithFormat:@"0%@",strrone];
        dataString = [NSString stringWithFormat:@"%@%@",dataString,strrone];
    }
    
    return dataString;
}



#pragma mark - C  语言 的加密 算法
unsigned int crcs32( unsigned char buf[], unsigned char len)
{
    unsigned int ret = 0x13141516;
    int i;
    for(i = 0; i < len;i++)
    {
        ret = CRC32_table[((ret & 0xFF) ^ buf[i])] ^ (ret >> 8);
  
    }
    ret = ~ret;
    return ret;
}

unsigned int CRC32_table[256] =
{
    0x00000000, 0x77073096, 0xEE0E612C, 0x990951BA,
    0x076DC419, 0x706AF48F, 0xE963A535, 0x9E6495A3,
    0x0EDB8832, 0x79DCB8A4, 0xE0D5E91E, 0x97D2D988,
    0x09B64C2B, 0x7EB17CBD, 0xE7B82D07, 0x90BF1D91,
    0x1DB71064, 0x6AB020F2, 0xF3B97148, 0x84BE41DE,
    0x1ADAD47D, 0x6DDDE4EB, 0xF4D4B551, 0x83D385C7,
    0x136C9856, 0x646BA8C0, 0xFD62F97A, 0x8A65C9EC,
    0x14015C4F, 0x63066CD9, 0xFA0F3D63, 0x8D080DF5,
    0x3B6E20C8, 0x4C69105E, 0xD56041E4, 0xA2677172,
    0x3C03E4D1, 0x4B04D447, 0xD20D85FD, 0xA50AB56B,
    0x35B5A8FA, 0x42B2986C, 0xDBBBC9D6, 0xACBCF940,
    0x32D86CE3, 0x45DF5C75, 0xDCD60DCF, 0xABD13D59,
    0x26D930AC, 0x51DE003A, 0xC8D75180, 0xBFD06116,
    0x21B4F4B5, 0x56B3C423, 0xCFBA9599, 0xB8BDA50F,
    0x2802B89E, 0x5F058808, 0xC60CD9B2, 0xB10BE924,
    0x2F6F7C87, 0x58684C11, 0xC1611DAB, 0xB6662D3D,
    0x76DC4190, 0x01DB7106, 0x98D220BC, 0xEFD5102A,
    0x71B18589, 0x06B6B51F, 0x9FBFE4A5, 0xE8B8D433,
    0x7807C9A2, 0x0F00F934, 0x9609A88E, 0xE10E9818,
    0x7F6A0DBB, 0x086D3D2D, 0x91646C97, 0xE6635C01,
    0x6B6B51F4, 0x1C6C6162, 0x856530D8, 0xF262004E,
    0x6C0695ED, 0x1B01A57B, 0x8208F4C1, 0xF50FC457,
    0x65B0D9C6, 0x12B7E950, 0x8BBEB8EA, 0xFCB9887C,
    0x62DD1DDF, 0x15DA2D49, 0x8CD37CF3, 0xFBD44C65,
    0x4DB26158, 0x3AB551CE, 0xA3BC0074, 0xD4BB30E2,
    0x4ADFA541, 0x3DD895D7, 0xA4D1C46D, 0xD3D6F4FB,
    0x4369E96A, 0x346ED9FC, 0xAD678846, 0xDA60B8D0,
    0x44042D73, 0x33031DE5, 0xAA0A4C5F, 0xDD0D7CC9,
    0x5005713C, 0x270241AA, 0xBE0B1010, 0xC90C2086,
    0x5768B525, 0x206F85B3, 0xB966D409, 0xCE61E49F,
    0x5EDEF90E, 0x29D9C998, 0xB0D09822, 0xC7D7A8B4,
    0x59B33D17, 0x2EB40D81, 0xB7BD5C3B, 0xC0BA6CAD,
    0xEDB88320, 0x9ABFB3B6, 0x03B6E20C, 0x74B1D29A,
    0xEAD54739, 0x9DD277AF, 0x04DB2615, 0x73DC1683,
    0xE3630B12, 0x94643B84, 0x0D6D6A3E, 0x7A6A5AA8,
    0xE40ECF0B, 0x9309FF9D, 0x0A00AE27, 0x7D079EB1,
    0xF00F9344, 0x8708A3D2, 0x1E01F268, 0x6906C2FE,
    0xF762575D, 0x806567CB, 0x196C3671, 0x6E6B06E7,
    0xFED41B76, 0x89D32BE0, 0x10DA7A5A, 0x67DD4ACC,
    0xF9B9DF6F, 0x8EBEEFF9, 0x17B7BE43, 0x60B08ED5,
    0xD6D6A3E8, 0xA1D1937E, 0x38D8C2C4, 0x4FDFF252,
    0xD1BB67F1, 0xA6BC5767, 0x3FB506DD, 0x48B2364B,
    0xD80D2BDA, 0xAF0A1B4C, 0x36034AF6, 0x41047A60,
    0xDF60EFC3, 0xA867DF55, 0x316E8EEF, 0x4669BE79,
    0xCB61B38C, 0xBC66831A, 0x256FD2A0, 0x5268E236,
    0xCC0C7795, 0xBB0B4703, 0x220216B9, 0x5505262F,
    0xC5BA3BBE, 0xB2BD0B28, 0x2BB45A92, 0x5CB36A04,
    0xC2D7FFA7, 0xB5D0CF31, 0x2CD99E8B, 0x5BDEAE1D,
    0x9B64C2B0, 0xEC63F226, 0x756AA39C, 0x026D930A,
    0x9C0906A9, 0xEB0E363F, 0x72076785, 0x05005713,
    0x95BF4A82, 0xE2B87A14, 0x7BB12BAE, 0x0CB61B38,
    0x92D28E9B, 0xE5D5BE0D, 0x7CDCEFB7, 0x0BDBDF21,
    0x86D3D2D4, 0xF1D4E242, 0x68DDB3F8, 0x1FDA836E,
    0x81BE16CD, 0xF6B9265B, 0x6FB077E1, 0x18B74777,
    0x88085AE6, 0xFF0F6A70, 0x66063BCA, 0x11010B5C,
    0x8F659EFF, 0xF862AE69, 0x616BFFD3, 0x166CCF45,
    0xA00AE278, 0xD70DD2EE, 0x4E048354, 0x3903B3C2,
    0xA7672661, 0xD06016F7, 0x4969474D, 0x3E6E77DB,
    0xAED16A4A, 0xD9D65ADC, 0x40DF0B66, 0x37D83BF0,
    0xA9BCAE53, 0xDEBB9EC5, 0x47B2CF7F, 0x30B5FFE9,
    0xBDBDF21C, 0xCABAC28A, 0x53B39330, 0x24B4A3A6,
    0xBAD03605, 0xCDD70693, 0x54DE5729, 0x23D967BF,
    0xB3667A2E, 0xC4614AB8, 0x5D681B02, 0x2A6F2B94,
    0xB40BBE37, 0xC30C8EA1, 0x5A05DF1B, 0x2D02EF8D
};
char tmpstr[54];
//数据  加密 算法
void xor(unsigned char key[]) {
    int j;
    int slen= 54; //strlen(source);
    int klen= 4; //strlen(key);
    unsigned char str = 0x0;
    unsigned char numberOne[54] = {0x87,0x65,0x4a,0x8b,0xb1,0x76,0x5,0x91,
        0x3c,0x83,0x23,0xdc,0xb0,0x63,0x59,0x02,
        0x20,0xd0,0x39,0x85,0x58,0x14,0x19,0x8,
        0x47,0x65,0xca,0x8c,0xb9,0x70,0x51,0x81,
        0x39,0x33,0x22,0xcc,0xb5,0x6e,0x5a,0x66,
        0x28,0xd2,0x99,0x88,0x5c,0x10,0xa9,0xa,
        0x90,0x9e,0xd,0xcd,0x18,0x7a};
    
    for (int i = 0;i < 4; i++) {
        str = str + key[i];
    }
    
    for(j=0;j<slen;j++)
    {
        if (str % klen == 0 ){
            tmpstr[j]=(numberOne[j]^key[j%klen]) ^ str;
        }else if (str % klen == 1) {
            tmpstr[j]=(numberOne[j]^key[j%klen])^(~(str)) ;
        }else if (str % klen == 2) {
            tmpstr[j]=numberOne[j]^key[j%klen];
        } else {
            tmpstr[j]=~((numberOne[j]^key[j%klen]) ^ str);
        }
        if(!tmpstr[j])
            tmpstr[j]=numberOne[j];
    }
    
}
#pragma mark- 16 进制字符串 与 互相文字转换
//16 进制的数转换字符串
- (NSString *)changeLanguage:(NSString *)chinese {
    NSString *strResult;
    if (chinese.length%2==0) {
        //第二次转换
        NSData *newData = [self hexToByteToNSData:chinese];
        unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        strResult = [[NSString alloc] initWithData:newData encoding:encode];
    }else{
        NSString *strResult = @"已假定是汉字的转换，所传字符串的长度必须是4的倍数!";
        NSLog(@"%@",strResult);
        return NULL;
    }
    NSMutableString *deleteStr =  [NSMutableString stringWithString:strResult];         // 过滤 文字空白的   \0
    for (int i = 0; i < deleteStr.length; i ++) {
        strResult = [deleteStr substringWithRange:NSMakeRange(i, 1)];
        if ([strResult isEqualToString:@"\0"]){
            [deleteStr deleteCharactersInRange:NSMakeRange(i, 1)];
            i--;
        }
    }
    strResult = deleteStr;
    return strResult;
}
//将汉字字符串转换成16进制字符串
- (NSString *)chineseToHex:(NSString *)chineseStr {
    NSStringEncoding encodingGB18030= CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *responseData =[chineseStr dataUsingEncoding:encodingGB18030];
    NSString *string=[self NSDataToByteTohex:responseData];
    return string;
}

- (NSString *)NSDataToByteTohex:(NSData *)data{
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
- (NSData *)hexToByteToNSData:(NSString *)str{
    int j=0;
    Byte bytes[[str length]/2];
    for(int i=0;i<[str length];i++)
    {
        int int_ch;  ///两位16进制数转化后的10进制数
        unichar hex_char1 = [str characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        unichar hex_char2 = [str characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:[str length]/2 ];
    return newData;
}

@end
