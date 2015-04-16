//
//  CryptoManager.h
//  WyCrypto
//
//  Created by ywen on 15/4/14.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSACrypto.h"
#import "DesCrypto.h"

@interface CryptoManager : NSObject

@property (strong, nonatomic) RSACrypto *rsa;
@property (strong, nonatomic) DesCrypto *des;

+(id) sharedInstance;

-(BOOL) setUpRsaPubkey: (NSString *) filePath;
-(BOOL) setUpRsaPrivatekey: (NSString *) filePath passwd: (NSString *) passwd;


-(NSString *) rsaEncrypt: (NSString *) content;
-(NSString *) rsaDecrypt: (NSString *) content;

-(NSString *) desEncryt: (NSString *) content key: (NSString *) key;
-(NSString *) desDecryt: (NSString *) content key: (NSString *) key;

@end
