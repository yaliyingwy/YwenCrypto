//
//  YwenImageUrlCache.m
//  YwenKit
//
//  Created by ywen on 15/5/30.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import "YwenImageUrlCache.h"
#import "YwenCache.h"

@implementation YwenImageUrlCache

-(void)setCacheDir:(NSString *)cacheDir {
    [YwenCache globalCache].cacheDir = cacheDir;
}

-(void)setCacheSize:(NSInteger)cacheSize {
    [YwenCache globalCache].cacheSize = cacheSize;
}

-(void)setCacheTime:(NSTimeInterval)cacheTime {
    [YwenCache globalCache].cacheTime = cacheTime;
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    
    NSString *pathString = [[request URL] absoluteString];
    
    if (![pathString hasSuffix:@".jpg"]) {
        return [super cachedResponseForRequest:request];
    }
    
    NSData *data = [[YwenCache globalCache] get:pathString];
    
    
    if (data != nil) {
       
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[request URL]
                                                             MIMEType:@"image/jpg"
                                                expectedContentLength:[data length]
                                                     textEncodingName:nil];
        return [[NSCachedURLResponse alloc] initWithResponse:response data:data];
    }
    else
    {
        return [super cachedResponseForRequest:request];
    }
    
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request {
    NSString *pathString = [[request URL] absoluteString];
    if (![pathString hasSuffix:@".jpg"]) {
        [super storeCachedResponse:cachedResponse forRequest:request];
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString *str = [[NSString alloc] initWithData:cachedResponse.data encoding:NSUTF8StringEncoding];
        NSString *reg = @"(html)?.*(404|500).*";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
        if (![predicate evaluateWithObject:str]) {
            [[YwenCache globalCache] put: cachedResponse.data forKey:pathString];
        }
    });
    
    
}

@end
