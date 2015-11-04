//
//  YwenCache.m
//  YwenKit
//
//  Created by ywen on 15/5/30.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "YwenCache.h"
#import "NSString+WYExt.h"




@implementation YwenCache

+(YwenCache *) globalCache {
    static YwenCache *global = nil;
    @synchronized(self) {
        if (global == nil) {
            global = [[self alloc] init];
        }
    }
    return global;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        
        _cacheTime = 15 * 24 * 60 * 60;
        
        self.cacheDir = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/ywenCache"];
        
        
        _diskQueue = dispatch_queue_create("com.ywen.cache.disk", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), _diskQueue);
        
        _infoQueue = dispatch_queue_create("com.ywen.cache.info", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), _infoQueue);
        
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:_infoPath]) {
            _cacheDic = [[NSMutableDictionary alloc] initWithContentsOfFile:_infoPath];
        }
        else
        {
            _cacheDic = [[NSMutableDictionary alloc] init];
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [self setUp];
        });
    });
    
    
    
    return self;
}

-(void) setUp {
    for (NSString *key in _cacheDic.allKeys) {
        NSDate *createdDate  =[_cacheDic objectForKey:key];
        if (_cacheTime + [createdDate timeIntervalSinceNow] <= 0) {
            dispatch_async(_diskQueue, ^{
                NSString *path = [_cacheDir stringByAppendingPathComponent:key];
                [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
                [_cacheDic removeObjectForKey: key];
                [self updateInfo];
            });
        }
    }
}

-(void)setCacheDir:(NSString *)cacheDir {
    _cacheDir = cacheDir;
    _infoPath = [_cacheDir stringByAppendingPathComponent:@"info.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cacheDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

-(NSData *)get:(NSString *)key {
    NSString *md5 = [key WY_MD5];
    if ([_cacheDic objectForKey:md5] == nil) {
        return nil;
    }
    else
    {
        NSString *path = [_cacheDir stringByAppendingPathComponent:md5];
        return [NSData dataWithContentsOfFile: path];
    }
}

-(void)put:(NSData *)data forKey:(NSString *)key {
    dispatch_async(_diskQueue, ^{
        NSString *md5 = [key WY_MD5];
        NSString *path = [_cacheDir stringByAppendingPathComponent:md5];
        [data writeToFile:path atomically:YES];
        [_cacheDic setObject:[NSDate date] forKey:md5];
        [self updateInfo];
    });
}

-(void) removeData:(NSString *)key {
    dispatch_async(_diskQueue, ^{
        NSString *md5 = [key WY_MD5];
        NSString *path = [_cacheDir stringByAppendingPathComponent:md5];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        [_cacheDic removeObjectForKey: md5];
        [self updateInfo];
    });
}

-(void)clearCache {
    dispatch_async(_diskQueue, ^{
        for (NSString *key in _cacheDic.allKeys) {
            NSString *path = [_cacheDir stringByAppendingPathComponent:key];
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        [self updateInfo];
    });
}

-(void) updateInfo {
    dispatch_async(_infoQueue, ^{
        if (_needUpdate) {
            return;
        }
        
        _needUpdate = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!_needUpdate) {
                return;
            }
            [self cleanUp];
            _needUpdate = NO;
        });
    });
}

-(void)cleanUp {
    [_cacheDic writeToFile:_infoPath atomically:YES];
}

@end
