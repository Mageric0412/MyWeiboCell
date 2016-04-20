//
//  MyStatusToolBar.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/20.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyStatusToolBar.h"

@implementation MyStatusToolBar

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
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(void)setUpAllChildView
{
    
}

@end
