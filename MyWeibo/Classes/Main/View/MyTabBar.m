//
//  MyTabBar.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/18.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyTabBar.h"
#import "MyTabBarButton.h"
#import "UIBarButtonItem+Item.h"
#import "UIImage+Image.h"
#import "UIView+MyFrame.h"
@interface MyTabBar()

@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, weak) UIButton *selectedButton;

@end


@implementation MyTabBar

-(NSMutableArray*) buttons
{
    if (_buttons==nil) {
        _buttons=[NSMutableArray array];
    }
    return _buttons;
}

-(void) setItems:(NSArray *)items
{
    _items=items;

    for (UITabBarItem *item in _items) {
        
        MyTabBarButton *btn = [MyTabBarButton buttonWithType:UIButtonTypeCustom];
        
        // 给按钮赋值模型，按钮的内容由模型对应决定
        btn.item = item;
        
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) { // 选中第0个
            [self btnClick:btn];
        }
        
        [self addSubview:btn];
        
        // 把按钮添加到按钮数组
        [self.buttons addObject:btn];

  }
}

    // 点击tabBarButton调用
    -(void)btnClick:(UIButton *)button
    {
        _selectedButton.selected = NO;
        button.selected = YES;
        _selectedButton = button;
        
        // 通知tabBarVc切换控制器，
        if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
            [_delegate tabBar:self didClickButton:button.tag];
        }
    }

-(UIButton*) plusButton
{
    if (_plusButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        // 默认按钮的尺寸跟背景图片一样大
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        [btn sizeToFit];
        
        _plusButton = btn;
        
        [self addSubview:_plusButton];
    }
    return _plusButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w/(self.items.count + 1);
    CGFloat btnH = self.bounds.size.height;
    
    
    int i = 0;
    // 设置tabBarButton的frame
    for (UIView *tabBarButton in self.buttons) {
        if (i == 2) {
            i = 3;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    
    
    // 设置添加按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
   
}

@end
