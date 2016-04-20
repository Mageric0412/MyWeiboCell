//
//  MyStatusResult.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyStatusResult.h"
#import "MyStatus.h"

@implementation MyStatusResult

// 告诉MJ框架，数组里的字典转换成哪个模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[MyStatus class]};
}

@end
