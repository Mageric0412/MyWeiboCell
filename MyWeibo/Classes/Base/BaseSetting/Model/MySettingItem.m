
//
//  MySettingItem.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/23.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MySettingItem.h"

@implementation MySettingItem

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image
{
    MySettingItem *item=[[self alloc]init];
    item.title =title;
    item.subTitle=subTitle;
    item.image=image;
    
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title subTitle:nil image:nil];
    
}

+(instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image
{
    return [self itemWithTitle:title subTitle:nil image:image];
}

@end
