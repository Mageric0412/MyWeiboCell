//
//  MyCover.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/18.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyCover;
@protocol MyCoverDelegate <NSObject>

@optional
-(void)coverDidClickCover:(MyCover *) cover;

@end

@interface MyCover : UIView

+(instancetype)show;

@property(nonatomic,assign) BOOL dimBackground;
@property(nonatomic,weak) id<MyCoverDelegate> delegate;

@end
