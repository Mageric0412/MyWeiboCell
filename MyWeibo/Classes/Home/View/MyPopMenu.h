//
//  MyPopMenu.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/18.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPopMenu : UIImageView

/**
 *  显示弹出菜单
 */
+ (instancetype)showInRect:(CGRect)rect;

/**
 *  隐藏弹出菜单
 */
+ (void)hide;

// 内容视图
@property (nonatomic, weak) UIView *contentView;

@end
