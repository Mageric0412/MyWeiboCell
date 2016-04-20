//
//  MyRepostView.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/20.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyRepostView.h"
#import "MyStatus.h"
#import "MyStatusFrame.h"
#import "UIImage+Image.h"

@interface MyRepostView()

@property(nonatomic,weak) UILabel *nameView ;
@property(nonatomic,weak)UILabel *textView ;
@end

@implementation MyRepostView

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
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

-(void)setUpAllChildView
{
    UILabel *nameView =[[UILabel alloc]init];
    nameView.font=MyNameFont;
    [self addSubview:nameView];
    _nameView=nameView;
    
    UILabel *textView =[[UILabel alloc]init];
    textView.font=MyTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView=textView;
    
}
-(void)setStatusF:(MyStatusFrame *)statusF
{
    _statusF=statusF;
    MyStatus *status = statusF.status;
    // 昵称
    _nameView.frame = statusF.repostNameFrame;
    _nameView.text = status.retweeted_status.user.name;
    
    // 正文
    _textView.frame = statusF.repostTextFrame;
    _textView.text = status.retweeted_status.text;
   
}

@end
