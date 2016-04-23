//
//  MyProfileViewController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/18.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyProfileViewController.h"
#import "MyBaseSetting.h"
#import "MyProfileCell.h"
#import "MySettingViewController.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpGroup0];

    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
}

#pragma mark - 点击设置的时候调用
- (void)settting
{
    MySettingViewController *settingVc=[[MySettingViewController alloc]init];
    [self.navigationController pushViewController:settingVc animated:YES]; 
}

-(void)setUpGroup0
{
    
    MyArrowItem *friend=[MyArrowItem itemWithTitle:@"我的好友" image:[UIImage imageNamed:@"new_friend"]];
    MyGroupItem *group=[[MyGroupItem alloc]init];
    group.items=@[friend];
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    // 我的相册
    MyArrowItem *album = [MyArrowItem itemWithTitle:@"我的相册" image:[UIImage imageNamed:@"album"]];
    album.subTitle = @"(12)";
    
    // 我的收藏
    MyArrowItem *collect = [MyArrowItem itemWithTitle:@"我的收藏" image:[UIImage imageNamed:@"collect"]];
    collect.subTitle = @"(0)";
    
    // 赞
    MyArrowItem *like = [MyArrowItem itemWithTitle:@"赞" image:[UIImage imageNamed:@"like"]];
    like.subTitle = @"(0)";
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[album,collect,like];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 微博支付
    MyArrowItem *pay = [MyArrowItem itemWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    // 个性化
    MyArrowItem *vip = [MyArrowItem itemWithTitle:@"个性化" image:[UIImage imageNamed:@"vip"]];
    vip.subTitle = @"微博来源、皮肤、封面图";
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[pay,vip];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 我的二维码
    MyArrowItem *card = [MyArrowItem itemWithTitle:@"我的二维码" image:[UIImage imageNamed:@"card"]];
    // 草稿箱
    MyArrowItem *draft = [MyArrowItem itemWithTitle:@"草稿箱" image:[UIImage imageNamed:@"draft"]];
    
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[card,draft];
    [self.groups addObject:group];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyProfileCell *cell = [MyProfileCell cellWithTableView:tableView];
    
    // 获取模型
    MyGroupItem *groupItem = self.groups[indexPath.section];
    MySettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
   // [cell setIndexPath:indexPath rowCount:groupItem.items.count];
    return cell;
}

-(void)setUpNav
{
    UIBarButtonItem *settting = [[UIBarButtonItem alloc] initWithTitle:@"设置"  style:UIBarButtonItemStyleBordered target:self action:@selector(settting)];
    self.navigationItem.rightBarButtonItem = settting;
}


@end
