//
//  MyUser.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyUser.h"

@implementation MyUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}


@end
