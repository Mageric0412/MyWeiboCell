//
//  MySettingCell.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/23.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MySettingCell.h"
#import "MyBaseSetting.h"
#import "MyBadgeView.h"
#import "UIImage+Resizable.h"

@interface MySettingCell ()

//此处强引用
@property(nonatomic,strong)UIImageView *arrowView;

@property(nonatomic,strong)UIImageView *cheakView;

@property(nonatomic,strong)UISwitch *switchView;

@property(nonatomic,strong)MyBadgeView *bageView;

@property (nonatomic, weak) UILabel *labelView;

@end

@implementation MySettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
       // self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"cell";
    MySettingCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (UILabel *)labelView
{
    if (_labelView == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        _labelView = label;
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
        [self addSubview:_labelView];
    }
    return _labelView;
}

-(UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
       // [self addSubview:arrowView];
    }
    
    return  _arrowView;
}

-(UIImageView *)cheakView
{
    if (_cheakView == nil) {
        _cheakView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];

        // [self addSubview:arrowView];
    }
    
    return  _cheakView;
}

-(UISwitch *)switchView
{
    if (_switchView == nil) {
       
        _switchView=[[UISwitch alloc]init];
        
        [_switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
    
    return  _switchView;
}

-(MyBadgeView *)bageView
{
    if (_bageView == nil) {
        
        _bageView=[MyBadgeView buttonWithType:UIButtonTypeCustom];
    }
    
    return  _bageView;
}

-(void)setItem:(MySettingItem *)item
{
    _item=item;
    
    [self setUpData];
    
    [self setUpRightItem];
}

-(void)setUpData
{
    self.textLabel.text=_item.title;
    self.detailTextLabel.text=_item.subTitle;
    self.imageView.image=_item.image;
}

-(void)setUpRightItem
{
    if ([_item isKindOfClass:[MyArrowItem class]]) {
     
        self.accessoryView=self.arrowView;
        
    }else if([_item isKindOfClass:[MyBadgeItem class]]){
        
        MyBadgeItem *badgeitem=(MyBadgeItem *)_item;
        self.bageView.badgeValue=badgeitem.badgeValue;
        self.accessoryView=self.bageView;
    
    }else if ([_item isKindOfClass:[MySwitchItem class]]){
    
        self.accessoryView=self.switchView;
        MySwitchItem *switchItem = (MySwitchItem *)_item;
        self.switchView.on = switchItem.on;
    
    }else if([_item isKindOfClass:[MyCheakItem class]]){
     
        MyCheakItem *cheakItem=(MyCheakItem *)_item;
        if (cheakItem.cheak) {
            self.accessoryView=self.cheakView;
        }else{
        self.accessoryView= nil;
            }
    
    }else if([_item isKindOfClass:[MyLabelItem class]]){
        
        MyLabelItem *labelItem = (MyLabelItem *)_item;
        UILabel *label=self.labelView;
        label.text=labelItem.text;
    }else{
        self.accessoryView = nil;
        [_labelView removeFromSuperview];
         _labelView = nil;
    }
    
}

//-(void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)rowCount
//{
//    UIImageView *bgView = (UIImageView *)self.backgroundView;
//    UIImageView *selBgView = (UIImageView *)self.selectedBackgroundView;
//    
//    if (rowCount == 1) { // 只有一行
//        bgView.image = [UIImage resizableWithImageName:@"common_card_background"];
//        selBgView.image = [UIImage resizableWithImageName:@"common_card_background_highlighted"];
//        
//    }else if(indexPath.row == 0){ // 顶部cell
//        bgView.image = [UIImage resizableWithImageName:@"common_card_top_background"];
//        selBgView.image = [UIImage resizableWithImageName:@"common_card_top_background_highlighted"];
//        
//    }else if (indexPath.row == rowCount - 1){ // 底部
//        bgView.image = [UIImage resizableWithImageName:@"common_card_bottom_background"];
//        selBgView.image = [UIImage resizableWithImageName:@"common_card_bottom_background_highlighted"];
//        
//    }else{ // 中间
//        bgView.image = [UIImage resizableWithImageName:@"common_card_middle_background"];
//        selBgView.image = [UIImage resizableWithImageName:@"common_card_middle_background_highlighted"];
//    }
//
//}

- (void)switchChange:(UISwitch *)switchView
{
    
    MySwitchItem *switchItem = (MySwitchItem *)_item;
    switchItem.on = switchView.on;
    //.....
}



@end
