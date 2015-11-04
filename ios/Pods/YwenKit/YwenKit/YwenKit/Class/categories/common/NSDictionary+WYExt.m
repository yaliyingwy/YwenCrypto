//
//  NSDictionary+WYExt.m
//  YwenKit
//
//  Created by ywen on 15/5/3.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "NSDictionary+WYExt.h"

@implementation NSDictionary (WYExt)

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

-(NSString *)WY_GetString:(NSString *)key {
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSString class]]) {
        return result;
    }
    else{
        return [result stringValue];
    }
}

-(NSDictionary *)WY_GetDic:(NSString *)key {
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSDictionary class]]) {
        return result;
    }
    else
    {
        return nil;
    }
}

-(NSArray *)WY_GetArr:(NSString *)key {
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSArray class]]) {
        return result;
    }
    else
    {
        return nil;
    }
}

@end
