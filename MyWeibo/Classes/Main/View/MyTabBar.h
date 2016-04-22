//
//  MyTabBar.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/18.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTabBar;

@protocol MyTabBarDelegate <NSObject>

@optional

-(void)tabBar:(MyTabBar*)tabBar didClickButton:(NSInteger)index;

-(void)tabBarDidClickPlusButton:(MyTabBar*)tabBar ;
@end

@interface MyTabBar : UIView

@property(nonatomic,strong)NSArray *items;

@property(nonatomic,weak) id<MyTabBarDelegate> delegate;

@end
