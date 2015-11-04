//
//  YwenCache.h
//  YwenKit
//
//  Created by ywen on 15/5/30.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YwenCache : NSObject
{
    dispatch_queue_t _diskQueue;
    dispatch_queue_t _infoQueue;
    NSMutableDictionary *_cacheDic;
    NSString *_infoPath;
    BOOL _needUpdate;
}

@property (assign, nonatomic) NSInteger cacheSize;
@property (assign, nonatomic) NSInteger usedSize;
@property (strong, nonatomic) NSString *cacheDir;
@property (assign, nonatomic) NSTimeInterval cacheTime;

+(YwenCache *) globalCache;

-(void) put: (NSData *) data forKey: (NSString *) key;
-(void) removeData:(NSString *) key;
-(void) clearCache;
-(NSData *) get:(NSString *) key;

-(void) cleanUp;
@end
