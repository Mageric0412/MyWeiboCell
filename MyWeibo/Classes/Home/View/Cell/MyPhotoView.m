//
//  MyPhotoView.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/21.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyPhotoView.h"
#import "UIView+MyFrame.h"
#import "UIImageView+WebCache.h"
#import "MyPhoto.h"

@interface MyPhotoView()

@property(nonatomic,weak)UIImageView *gifView;

@end

@implementation MyPhotoView

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
       
        self.userInteractionEnabled=YES;
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.clipsToBounds=YES;
       
        UIImageView *gifView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        
        _gifView=gifView;

    }
    return  self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x=self.width-self.gifView.width;
    self.gifView.y=self.height-self.gifView.height;
}

-(void)setPhoto:(MyPhoto *)photo
{
    _photo=photo;
    
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    NSString *urlStr=photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden=NO;
    }else{
        self.gifView.hidden=YES;
    }
    
}
@end
