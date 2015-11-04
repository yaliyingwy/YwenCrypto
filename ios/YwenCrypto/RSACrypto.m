//
//  RSACrypto.m
//  WyCrypto
//
//  Created by ywen on 15/4/14.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "RSACrypto.h"



@implementation RSACrypto

/**
 *  设置公钥
 *
 *  @param derFile 公钥的der文件路径
 *
 *  @return 是否成功
 */

-(BOOL)setPublicKeyFromDer:(NSString *)derFile {
    NSData *derData = [NSData dataWithContentsOfFile:derFile];
    
    SecCertificateRef certificateRef = nil;
    certificateRef = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)(derData));
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(certificateRef,myPolicy,&myTrust);
    SecTrustResultType trustResult;
    
    BOOL success = NO;
    if (status == noErr) {
        status = SecTrustEvaluate(myTrust, &trustResult);
        success = YES;
    }
   
    self.pubKey = SecTrustCopyPublicKey(myTrust);
    CFRelease(certificateRef);
    CFRelease(myPolicy);
    CFRelease(myTrust);
    
    return success;
}

/**
 *  设置私钥
 *
 *  @param NSString 私钥p12文件路径
 *
 *  @return 是否成功
 */

-(BOOL)setPrivateKeyFromP12:(NSString *)p12File password:(NSString *)password{
    SecKeyRef privateKeyRef = NULL;
    NSData *p12Data = [NSData dataWithContentsOfFile:p12File];
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    if (password) {
        [options setObject: password forKey:(__bridge id)kSecImportExportPassphrase];
    }
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) p12Data, (__bridge CFDictionaryRef)options, &items);
    
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        if (securityError != noErr) {
            privateKeyRef = NULL;
        }
        else
        {
            NSLog(@"err %d", (int)securityError);
        }
        
    }
    else
    {
        NSLog(@"err %d", (int)securityError);
    }
    CFRelease(items);
    if (privateKeyRef != nil) {
        CFRetain(privateKeyRef);
    }
    
    
    self.privateKey = privateKeyRef;
    return self.privateKey != NULL;
}


/**
 *  rsa 加密
 *
 *  @param content 原始数据
 *
 *  @return 加密后的数据
 */

-(NSString *)encrypt:(NSString *)text padding: (SecPadding) padding {
  
    if (self.pubKey == nil) {
        return nil;
    }
    NSData *content = [text dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainLen = [content length];
    
    void *plain = malloc(plainLen);
    [content getBytes:plain
               length:plainLen];
    
    size_t cipherLen = 128; // 当前RSA的密钥长度是128字节, 128 * 8 = 1024位密钥，这里是硬编码，用命令生成密钥时请指定1024
    void *cipher = malloc(cipherLen);
    
    OSStatus returnCode = SecKeyEncrypt(self.pubKey, padding, plain,
                                        plainLen, cipher, &cipherLen);
    NSData *result = nil;
    if (returnCode == 0) {
        result = [NSData dataWithBytes:cipher
                                length:cipherLen];
    }
    
    free(plain);
    free(cipher);
    
    return [result WY_Base64EncodedString];
}


-(NSString *)decrypt:(NSString *)text padding:(SecPadding) padding {
  
    if (self.privateKey == nil) {
        return nil;
    }
    NSData *data = [NSData WY_DataFromBase64String:text];
    size_t cipherLen = [data length];
    void *cipher = malloc(cipherLen);
    [data getBytes:cipher length:cipherLen];
    size_t plainLen = SecKeyGetBlockSize(self.privateKey) - 12;
    void *plain = malloc(plainLen);
    OSStatus status = SecKeyDecrypt(self.privateKey, padding, cipher, cipherLen, plain, &plainLen);
    
    if (status != noErr) {
        return nil;
    }
    
    NSData *decryptedData = [[NSData alloc] initWithBytes:(const void *)plain length:plainLen];
    
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}


@end
