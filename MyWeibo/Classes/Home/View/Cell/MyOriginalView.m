//
//  MyOriginalView.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/20.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyOriginalView.h"
#import "myStatus.h"
#import "MyStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Image.h"
#import "MyPhotosView.h"

@interface MyOriginalView ()

@property(nonatomic, weak) MyPhotosView *photosView;

@property(nonatomic,weak) UIImageView *iconView;

@property(nonatomic,weak) UILabel *nameView ;

@property(nonatomic,weak)UIImageView *vipView;

@property(nonatomic,weak)UILabel *timeView ;

@property(nonatomic,weak)UILabel *sourceView ;

@property(nonatomic,weak)UILabel *textView ;

@end

@implementation MyOriginalView

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
        self.userInteractionEnabled=YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
    }
    return self;
}

-(void)setStatusF:(MyStatusFrame *)statusF
{
    _statusF=statusF;
    [self setUpFrame];
    [self SetUpData];
}

-(void)SetUpData
{
    MyStatus *status=_statusF.status;
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    
    _vipView.image = image;
    
    // 时间
    _timeView.text = status.created_at;
    
    // 来源
    _sourceView.text = status.source;
    
    // 正文
    _textView.text = status.text;
#warning 原创配图数据
    _photosView.pic_urls=status.pic_urls;
}

//每次有新的时间都要重新计算框架
-(void)setUpFrame
{
    _iconView.frame=_statusF.originalIconFrame;
    _nameView.frame=_statusF.originalNameFrame;
    
    if(_statusF.status.user.vip){
        _vipView.hidden=NO;
        _vipView.frame=_statusF.originalVipFrame;
    }else{
        _vipView.hidden=YES;
    }
    
    // 时间
    MyStatus *status=_statusF.status;
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + MyStatusCellMargin * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:MyTimeFont];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + MyStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:MySourceFont];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    //_sourceView.frame=_statusF.originalSourceFrame;
    //_timeView.frame=_statusF.originalTimeFrame;
    _textView.frame=_statusF.originalTextFrame;
    
    _photosView.frame=_statusF.originalPhotosFrame;
    
}

-(void)setUpAllChildView
{
    UIImageView *iconView=[[UIImageView alloc]init];
    [self addSubview:iconView];
    _iconView=iconView;
    
    UILabel *nameView =[[UILabel alloc]init];
    nameView.font=MyNameFont;
    [self addSubview:nameView];
    _nameView=nameView;
    
    UIImageView *vipView=[[UIImageView alloc]init];
    [self addSubview:vipView];
    _vipView=vipView;
    
    UILabel *timeView =[[UILabel alloc]init];
    timeView.font=MyTimeFont;
    timeView.textColor=[UIColor orangeColor];
    [self addSubview:timeView];
    _timeView=timeView;
    
    UILabel *sourceView =[[UILabel alloc]init];
    sourceView.font=MySourceFont;
     sourceView.textColor=[UIColor lightGrayColor];
    [self addSubview:sourceView];
    _sourceView=sourceView;
    
    UILabel *textView =[[UILabel alloc]init];
    textView.font=MyTextFont;
    textView.numberOfLines=0;
    [self addSubview:textView];
    _textView=textView;
    
    MyPhotosView *photosView=[[MyPhotosView alloc]init];
    [self addSubview:photosView];
    _photosView=photosView;
}

@end
