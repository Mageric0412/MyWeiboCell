//
//  MyStatusCell.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/20.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyStatusFrame;

@interface MyStatusCell : UITableViewCell

@property(nonatomic,strong) MyStatusFrame *statusF;

+(instancetype)cellWithTableView:(UITableView*)tableView;

@end
