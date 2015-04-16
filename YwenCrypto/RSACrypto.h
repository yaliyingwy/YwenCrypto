//
//  RSACrypto.h
//  WyCrypto
//
//  Created by ywen on 15/4/14.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Base64/NSData+Base64.h"



@interface RSACrypto : NSObject

@property (strong, nonatomic)  __attribute__((NSObject)) SecKeyRef pubKey;
@property (strong, nonatomic)  __attribute__((NSObject)) SecKeyRef privateKey;

-(BOOL) setPublicKeyFromDer:(NSString *) derFile;
-(BOOL) setPrivateKeyFromP12:(NSString *) p12File password: (NSString *) password;

-(NSString *) encrypt: (NSString *) text;
-(NSString *) decrypt: (NSString *) text;

@end
