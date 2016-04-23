//
//  MyProfileCell.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/23.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyProfileCell.h"
#import "UIView+MyFrame.h"

@implementation MyProfileCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font=[UIFont systemFontOfSize:12];
    }
    return  self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame)+5;
}

@end
