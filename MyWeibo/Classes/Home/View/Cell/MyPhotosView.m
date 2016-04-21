//
//  MyPhotosView.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/21.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyPhotosView.h"
#import "MyPhoto.h"
#import "UIImageView+WebCache.h"
#import "MyStatusFrame.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@implementation MyPhotosView

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
      
      //  self.backgroundColor=[UIColor redColor];
    
        //添加9个子控件
        [self setUpAllChildView];
    }
    return self;
}

-(void)setUpAllChildView
{
    for (int i=0; i<9; i++) {
        UIImageView *imageV =[[UIImageView alloc]init];
        imageV.userInteractionEnabled=YES;
        imageV.contentMode=UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds=YES;
        imageV.tag=i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        
        [self addSubview:imageV];
    }
}

-(void)tap:(UITapGestureRecognizer*)tap
{
    UIImageView *tapView=tap.view;
    
    int i=0;
    NSMutableArray *arMp=[NSMutableArray array];
    for (MyPhoto* photo in _pic_urls) {
        MJPhoto *mp=[[MJPhoto alloc]init];
        
        //gif
        NSString *urlStr=photo.thumbnail_pic.absoluteString;
        urlStr =[urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mp.url=[NSURL URLWithString:urlStr];
        
        mp.index=i;
        mp.srcImageView=tapView;
        [arMp addObject:mp];
        i++;
    }
    MJPhotoBrowser *browser=[[MJPhotoBrowser alloc]init];
    browser.photos=arMp;
    browser.currentPhotoIndex=tapView.tag;
    [browser show];
    
}

-(void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls=pic_urls;
    int count=self.subviews.count;
    for (int i =0; i<count; i++) {
        UIImageView *imageV=self.subviews[i];
        
        if (i<pic_urls.count) {
            
            imageV.hidden=NO;
            MyPhoto *photo=_pic_urls[i];
            [imageV sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
        }else{
            imageV.hidden=YES;
        }

    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x =0;
    CGFloat y =0;
    CGFloat w =MyStatusCellWH*2;
    CGFloat h =MyStatusCellWH*2;
    int row=0;
    int col=0;
    int cols= _pic_urls.count==4?2:3;
    for (int i=0; i<_pic_urls.count; i++) {
        
        col=i%cols;
        row=i/cols;
        UIImageView *imageV=self.subviews[i];
        x=col*(w+MyStatusCellMargin);
        y=row*(h+MyStatusCellMargin);
        imageV.frame=CGRectMake(x, y, w, h);
    }
}

@end
