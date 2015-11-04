//
//  NSString+WYExt.h
//  xebest
//
//  Created by ywen on 15/3/11.
//  Copyright (c) 2015年 xianyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "Pinyin.h"

@interface NSString (WYExt)

- (BOOL) WY_IsMobileNumber;
-(BOOL) WY_IsMobileNumberStrict;
-(BOOL) WY_IsFixedPhone;
-(BOOL) WY_IsPostalCode;
- (NSString *) WY_MD5;
- (BOOL) WY_IsEmpty;
-(BOOL) WY_IsNumber;
-(BOOL) WY_HasNumber;
-(BOOL) WY_IsBankCard;
-(BOOL) WY_IsIdCard;
-(BOOL) WY_IsEmail;
-(BOOL) WY_IsLetter;
-(BOOL) WY_HasLetter;
-(BOOL) WY_IsNumberOrLetter;
-(NSString *) WY_TrimStyle;
-(NSString *) WY_FirstIndexLetter;



+(NSString *) WY_RandomString: (NSInteger) length;

@end
