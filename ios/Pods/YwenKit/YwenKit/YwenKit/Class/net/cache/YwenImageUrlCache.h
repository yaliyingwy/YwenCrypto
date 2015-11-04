//
//  YwenImageUrlCache.h
//  YwenKit
//
//  Created by ywen on 15/5/30.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YwenImageUrlCache : NSURLCache

@property (assign, nonatomic) NSTimeInterval cacheTime;
@property (assign, nonatomic) NSInteger cacheSize;
@property (strong, nonatomic) NSString *cacheDir;


@end
