//
//  MyStatusToolBar.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/20.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyStatusToolBar.h"
#import "MyStatusFrame.h"
#import "UIView+MyFrame.h"
#import "UIImage+Image.h"
#import "MyStatus.h"

@interface MyStatusToolBar()

@property(nonatomic,strong)NSMutableArray *btns;
@property(nonatomic,strong)NSMutableArray *divs;
@property (nonatomic, weak) UIButton *retbtn;
@property (nonatomic, weak) UIButton *combtn;
@property (nonatomic, weak) UIButton *likebtn;
@end

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
       // self.backgroundColor = [UIColor grayColor];
        self.userInteractionEnabled=YES;
        self.image=[UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
    }
    return self;
}

-(NSMutableArray*)btns
{
    if (_btns==nil) {
        _btns=[NSMutableArray array];
    }
    return _btns;
}

-(NSMutableArray*)divs
{
    if (_divs==nil) {
        _divs=[NSMutableArray array];
    }
    return _divs;
}

-(void)setUpAllChildView
{
    UIButton *retbtn=[self setUpOneBtnWithTitle:@"转发"  image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retbtn=retbtn;
    UIButton *combtn=[self setUpOneBtnWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _combtn=combtn;
    UIButton *liketn=[self setUpOneBtnWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _likebtn=liketn;
    for (int i=0;i<2; i++) {
        UIImageView *div=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:div];
        [self.divs addObject:div];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count=self.btns.count;
    CGFloat w =MyScreenW/count;
    CGFloat h=self.height;
    CGFloat x= 0;
    CGFloat y=0;
    for (int i=0; i<count; i++) {
        UIButton *btn=self.btns[i];
        x=i*w;
        btn.frame=CGRectMake(x, y, w, h);
    }
    int offset=1;
    for (UIImageView *div in self.divs) {
        UIButton *btn=self.btns[offset];
        div.x=btn.x;
        offset++;
    }
}

-(UIButton*) setUpOneBtnWithTitle:(NSString*)title image:(UIImage*)image
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font=MySourceFont;
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
    [self.btns addObject:btn];
    return  btn;
}

-(void)setStatus:(MyStatus *)status
{
    _status=status;
    [self setBtn:_retbtn title:_status.reposts_count];
    [self setBtn:_combtn title:_status.comments_count];
    [self setBtn:_likebtn title:_status.attitudes_count];
}

-(void)setBtn:(UIButton*) btn title:(int)count
{
    NSString *title=nil;
    if (count) {
        if (count>9999) {
            CGFloat floatCount=count/10000.0;
            title=[NSString stringWithFormat:@"%.1f万",floatCount];
            title=[title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        else{
            title=[NSString stringWithFormat:@"%d",count];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
    }

}

@end
