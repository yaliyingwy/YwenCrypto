//
//  UITableViewCell+WYExt.h
//  YwenKit
//
//  Created by ywen on 15/5/13.
//  Copyright (c) 2015年 ywen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectCellProtocol <NSObject>

@optional
-(void) selectCellAt:(NSIndexPath *) indexPath;

@end

@interface UITableViewCell (WYExt)


@end
