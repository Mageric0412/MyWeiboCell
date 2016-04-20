//
//  MyStatusResult.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface MyStatusResult : NSObject<MJKeyValue>

/**
 *  用户的微博数组（CZStatus）
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int total_number;

@end
