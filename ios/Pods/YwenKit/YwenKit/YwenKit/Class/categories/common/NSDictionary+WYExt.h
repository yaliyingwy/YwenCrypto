//
//  NSDictionary+WYExt.h
//  YwenKit
//
//  Created by ywen on 15/5/3.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WYExt)

-(NSString *) WY_ToJson;
-(NSString *) WY_GetString:(NSString *) key;
-(NSDictionary *) WY_GetDic:(NSString *) key;
-(NSArray *) WY_GetArr: (NSString *) key;

@end
