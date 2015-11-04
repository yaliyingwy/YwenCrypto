//
//  NSData+WYExt.h
//  YwenKit
//
//  Created by ywen on 15/5/3.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <Foundation/Foundation.h>

void *NewBase64Decode(
                      const char *inputBuffer,
                      size_t length,
                      size_t *outputLength);

char *NewBase64Encode(
                      const void *inputBuffer,
                      size_t length,
                      bool separateLines,
                      size_t *outputLength);

@interface NSData (WYExt)

-(NSDictionary *) WY_ToDic;

-(NSArray *) WY_ToArray;

+ (NSData *) WY_DataFromBase64String:(NSString *)aString;
- (NSString *) WY_Base64EncodedString;

// added by Hiroshi Hashiguchi
- (NSString *) WY_Base64EncodedStringWithSeparateLines:(BOOL)separateLines;

@end
