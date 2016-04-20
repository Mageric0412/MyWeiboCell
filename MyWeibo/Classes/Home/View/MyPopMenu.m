//
//  MyPopMenu.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/18.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyPopMenu.h"
#import "UIImage+Image.h"
#import "UIView+MyFrame.h"

@implementation MyPopMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)showInRect:(CGRect)rect
{
   MyPopMenu *menu = [[MyPopMenu alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
    
    [[UIApplication sharedApplication].keyWindow addSubview:menu];
    
    return menu;
}

+ (void)hide
{
    for (UIView *popMenu in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([popMenu isKindOfClass:self]) {
            [popMenu removeFromSuperview];
        }
    }
}
- (void)setContentView:(UIView *)contentView
{
    // 先移除之前内容视图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}



@end
