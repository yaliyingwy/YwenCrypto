//
//  NSArray+WYExt.m
//  YwenKit
//
//  Created by ywen on 15/5/3.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "NSArray+WYExt.h"

@implementation NSArray (WYExt)

-(NSString *)WY_ToJson {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else
    {
        return nil;
    }
}

@end
