//
//  DesCrypto.h
//  WyCrypto
//
//  Created by ywen on 15/4/14.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CommonCrypto/CommonCryptor.h>
#import <YwenKit.h>


@interface DesCrypto : NSObject

- (NSString *) encrypt: (NSString *) text key:(NSString *) key;
- (NSString *) decrypt: (NSString *) text key:(NSString *) key;

@end
