//
//  MyCover.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/18.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyCover.h"

@implementation MyCover

-(void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground =dimBackground;
    if (dimBackground) {
        self.backgroundColor=[UIColor grayColor];
        self.alpha=0.5;
    }else{
    
        self.alpha=1;
        self.backgroundColor=[UIColor clearColor];
    }
}

+(instancetype)show
{
    MyCover *cover=[[MyCover alloc]initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor=[UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    return cover;

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 移除蒙板
    [self removeFromSuperview];
    
    // 通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        
        [_delegate coverDidClickCover:self];
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
