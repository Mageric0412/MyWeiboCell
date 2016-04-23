//
//  MySettingCell.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/23.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MySettingItem;

@interface MySettingCell : UITableViewCell

@property(nonatomic,strong)MySettingItem *item;

+(instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)rowCount;

@end
