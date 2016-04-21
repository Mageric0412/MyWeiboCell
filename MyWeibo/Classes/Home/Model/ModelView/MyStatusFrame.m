//
//  MyStatusFrame.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/20.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyStatusFrame.h"
#import "MyStatus.h"
#import "MyUser.h"



@implementation MyStatusFrame

-(void)setStatus:(MyStatus *)status
{
    _status=status;
    [self setUpOriginalViewFrame];
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        [self setUpRepostViewFrame];
         toolBarY = CGRectGetMaxY(_repostViewFrame);
    }
    
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = MyScreenW;
    CGFloat toolBarH = MyStatusCellWH;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}

//计算配图尺寸
-(CGSize) photosSizeWithCount:(int)count
{
    int cols= count == 4?2:3;
    int rows=(count-1)/cols+1;
    CGFloat photoWH=MyStatusCellWH*2;
    CGFloat w=cols*photoWH+(cols-1)*MyStatusCellMargin;
    CGFloat h=rows*photoWH+(rows-1)*MyStatusCellMargin;
    
    return CGSizeMake(w, h);
    
}

-(void)setUpOriginalViewFrame
{
    CGFloat imageX=MyStatusCellMargin;
    CGFloat imageY=imageX;
    CGFloat imageWH=MyStatusCellWH;
    _originalIconFrame=CGRectMake(imageX, imageY, imageWH, imageWH);
    
    CGFloat nameX=CGRectGetMaxX(_originalIconFrame)+MyStatusCellMargin;
    CGFloat nameY=imageY;
    CGSize nameSize=[_status.user.name sizeWithFont:MyNameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + MyStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = MyVipWH;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
//时间跟来源要在每次更新时重新计算框架
//    // 时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + MyStatusCellMargin * 0.5;
//    CGSize timeSize = [_status.created_at sizeWithFont:MyTimeFont];
//    _originalTimeFrame = (CGRect){{timeX,timeY},timeSize};
//    
//    // 来源
//    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + MyStatusCellMargin;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [_status.source sizeWithFont:MySourceFont];
//    _originalSourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + MyStatusCellMargin;
    
    CGFloat textW = MyScreenW - 2 * MyStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:MyTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + MyStatusCellMargin;
    
    if (_status.pic_urls.count) {
        
        CGFloat photosX=MyStatusCellMargin;
        CGFloat photosY=CGRectGetMaxY(_originalTextFrame)+MyStatusCellMargin;
        CGSize photosSize=[self photosSizeWithCount:_status.pic_urls.count];
        _originalPhotosFrame=(CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + MyStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = MyScreenW;
    
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}

-(void)setUpRepostViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = MyStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweetedName sizeWithFont:MyNameFont];
    _repostNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_repostNameFrame) + MyStatusCellMargin;
    
    CGFloat textW = MyScreenW - 2 * MyStatusCellMargin;
    // 注意：一定要是转发微博的正文
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:MyTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _repostTextFrame = (CGRect){{textX,textY},textSize};
    
     CGFloat repostH = CGRectGetMaxY(_repostTextFrame) + MyStatusCellMargin;
    
    int retPicCount =_status.retweeted_status.pic_urls.count;
    
    if (retPicCount) {
        CGFloat photosX=MyStatusCellMargin;
        CGFloat photosY=CGRectGetMaxY(_repostTextFrame)+MyStatusCellMargin;
        CGSize photosSize=[self photosSizeWithCount:retPicCount];
        _repostPhotosFrame=(CGRect){{photosX,photosY},photosSize};
        repostH = CGRectGetMaxY(_repostPhotosFrame) + MyStatusCellMargin;
    }
    // 原创微博的frame
    CGFloat repostX = 0;
    CGFloat repostY = CGRectGetMaxY(_originalViewFrame);
    CGFloat repostW = MyScreenW;
    
    _repostViewFrame = CGRectMake(repostX, repostY, repostW, repostH);
}

@end
