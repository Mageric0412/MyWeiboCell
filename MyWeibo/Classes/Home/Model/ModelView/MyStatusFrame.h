//
//  MyStatusFrame.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/20.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

#define MyStatusCellMargin 10
#define MyStatusCellWH 35
#define MyVipWH 14
#define MyNameFont [UIFont systemFontOfSize:13]
#define MyTimeFont [UIFont systemFontOfSize:12]
#define MySourceFont MyTimeFont
#define MyTextFont [UIFont systemFontOfSize:15]
#define MyScreenW [UIScreen mainScreen].bounds.size.width

@class  MyStatus;

@interface MyStatusFrame : NSObject

@property(nonatomic,strong) MyStatus *status;


@property(nonatomic,assign) CGRect originalViewFrame;

@property(nonatomic,assign) CGRect originalIconFrame;

@property(nonatomic,assign) CGRect originalNameFrame;

@property(nonatomic,assign) CGRect originalVipFrame;

@property(nonatomic,assign) CGRect originalTimeFrame;

@property(nonatomic,assign) CGRect originalSourceFrame;

@property(nonatomic,assign) CGRect originalTextFrame;

@property(nonatomic,assign) CGRect originalPhotosFrame;


@property(nonatomic,assign) CGRect repostViewFrame;

@property(nonatomic,assign) CGRect repostNameFrame;

@property(nonatomic,assign) CGRect repostTextFrame;

@property(nonatomic,assign) CGRect repostPhotosFrame;


@property(nonatomic,assign) CGRect toolBarFrame;

@property(nonatomic,assign) CGFloat cellHeight;

@end
