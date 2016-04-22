//
//  MyComposeToolBar.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/22.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyComposeToolBar.h"
#import "UIView+MyFrame.h"

@implementation MyComposeToolBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUpAllChildView];
    }
    
    return self;
}

-(void)setUpAllChildView
{
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    
}


//设置发送工具栏按钮并添加回调函数
-(void)setUpButtonWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
   
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag =self.subviews.count;
    [self addSubview:btn];

}

-(void)btnClick:(UIButton*)button
{
    if ([_delegate respondsToSelector:@selector(composeToolBar:didClickBtn:)]) {
        [_delegate composeToolBar:self didClickBtn:button.tag];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count=self.subviews.count;
    
    CGFloat w=self.width/count;
    CGFloat h=self.height;
    CGFloat x= 0;
    CGFloat y=0;
    
    for (int i=0; i<count; i++) {
        UIButton *btn=self.subviews[i];
        x=i*w;
        btn.frame=CGRectMake(x, y, w, h);
    }
}
@end
