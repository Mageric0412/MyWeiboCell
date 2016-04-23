//
//  MySettingItem.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/23.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface MySettingItem : NSObject

@property(nonatomic,strong) UIImage *image;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subTitle;

+(instancetype)itemWithTitle:(NSString *)title;

+(instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image;

@end
