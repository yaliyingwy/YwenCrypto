//
//  CryptoManager.m
//  WyCrypto
//
//  Created by ywen on 15/4/14.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "CryptoManager.h"

@implementation CryptoManager

static id instance = nil;

-(id) init {
    self = [super init];
    if (self) {
        self.rsa = [[RSACrypto alloc] init];
        self.des = [[DesCrypto alloc] init];
    }
    return self;
}

+(id) sharedInstance {
    
    @synchronized(self)
    {
        if (instance == nil)
        {
            instance = [[[self class] alloc] init];
        }
        
    }
    
    return instance;
}

-(BOOL)setUpRsaPubkey:(NSString *)filePath {
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [self.rsa setPublicKeyFromDer:filePath];
    }
    else
    {
        return NO;
    }
    
}

-(BOOL) setUpRsaPrivatekey:(NSString *)filePath passwd:(NSString *)passwd {
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [self.rsa setPrivateKeyFromP12:filePath password:passwd];
    }
    else
    {
        return NO;
    }
}

-(NSString *)rsaEncrypt:(NSString *)content
{
    return [self.rsa encrypt:content];
}

-(NSString *)rsaDecrypt:(NSString *)content
{
    return [self.rsa decrypt:content];
}

-(NSString *)desEncryt:(NSString *)content key:(NSString *)key {
    return [self.des encrypt:content key:key];
}

-(NSString *)desDecryt:(NSString *)content key:(NSString *)key {
    return [self.des decrypt:content key:key];
}


@end
