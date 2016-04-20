//
//  MyStatus.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyStatus.h"
#import "MyPhoto.h"

@implementation MyStatus

+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[MyPhoto class]};
}

@end
