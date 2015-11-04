//
//  Macros.h
//  YwenKit
//
//  Created by ywen on 15/4/17.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#ifndef YwenKit_Macros_h
#define YwenKit_Macros_h

//MARK: debug log
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//MARK: screen
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//MARK: ios version
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define IOS8_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )

//MARK: block
typedef void (^CallBack)(void);


//enum
typedef NS_OPTIONS(NSUInteger, WyDirection) {
    Top = 1 << 0,
    Right = 1 << 1,
    Bottom = 1 << 2,
    Left = 1 << 3,
};


#endif
