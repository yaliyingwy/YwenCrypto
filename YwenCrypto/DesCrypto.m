//
//  DesCrypto.m
//  WyCrypto
//
//  Created by ywen on 15/4/14.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "DesCrypto.h"


@implementation DesCrypto

/**
 *  des加密
 *
 *  @param text 原始字符串
 *  @param key  密钥
 *
 *  @return 加密后的字符串
 */

- (NSString *) encrypt: (NSString *) text key:(NSString *) key {
    return [[self encrypt:text encryptOrDecrypt:kCCEncrypt key:key] base64EncodedString];
}

/**
 *  des解密
 *
 *  @param text 加密过的base64字符串
 *  @param key  密钥
 *
 *  @return 解密后的字符串
 */

- (NSString *) decrypt: (NSString *) text key:(NSString *) key {
    return [[NSString alloc] initWithData:[self encrypt:text encryptOrDecrypt:kCCDecrypt key:key] encoding:NSUTF8StringEncoding];
}

/**
 *  des 加解密
 *
 *  @param sText            输入字符串
 *  @param encryptOperation 加／解密
 *  @param key              密钥
 *
 *  @return 加密后的数据
 */

- (NSData *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
{
    static Byte iv[8]={1,2,3,4,5,6,7,8};
    
    NSData* data = nil;
    
    if (encryptOperation == kCCEncrypt) {
        data = [sText dataUsingEncoding: NSUTF8StringEncoding];
    }
    else
    {
        data = [NSData dataFromBase64String:sText];
    }
    
    
    NSUInteger bufferSize=([data length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
    
    char buffer[bufferSize];
    
    memset(buffer, 0,sizeof(buffer));
    
    size_t bufferNumBytes;
    
    CCCryptorStatus cryptStatus = CCCrypt(encryptOperation,
                                          
                                          kCCAlgorithmDES,
                                          
                                          kCCOptionPKCS7Padding,
                                          
                                          [key UTF8String],
                                          
                                          kCCKeySizeDES,
                                          
                                          iv,
                                          
                                          [data bytes],
                                          
                                          [data length],
                                          
                                          buffer,
                                          
                                          bufferSize,
                                          
                                          &bufferNumBytes);
    if (!cryptStatus == kCCSuccess) {
        return nil;
    }
    
    NSData *result = [NSData dataWithBytes:buffer length:(NSUInteger)bufferNumBytes];
    
    return result;
}


@end
