//
//  MyComposeToolBar.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/22.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  MyComposeToolBar;
@protocol MyComposeToolBarDelegate <NSObject>

@optional
-(void)composeToolBar:(MyComposeToolBar *)toolBar didClickBtn:(NSInteger) index;
@end

@interface MyComposeToolBar : UIView

@property(nonatomic,weak)id<MyComposeToolBarDelegate>delegate;
@end
