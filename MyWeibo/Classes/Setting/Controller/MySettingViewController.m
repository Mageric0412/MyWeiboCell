//
//  MySettingViewController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/23.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MySettingViewController.h"
#import "MyBaseSetting.h"
#import "MyCommonViewController.h"

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
}

- (void)setUpGroup0
{
    // 账号管理
    MyBadgeItem *account = [MyBadgeItem itemWithTitle:@"账号管理"];
    account.badgeValue = @"8";
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[account];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 提醒和通知
    MyArrowItem *notice = [MyArrowItem itemWithTitle:@"我的相册" ];
    // 通用设置
    MyArrowItem *setting = [MyArrowItem itemWithTitle:@"通用设置" ];
    setting.descVc = [MyCommonViewController class];
    // 隐私与安全
    MyArrowItem *secure = [MyArrowItem itemWithTitle:@"隐私与安全" ];
    
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[notice,setting,secure];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 意见反馈
    MyArrowItem *suggest = [MyArrowItem itemWithTitle:@"意见反馈" ];
    // 关于微博
    MyArrowItem *about = [MyArrowItem itemWithTitle:@"关于微博"];
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[suggest,about];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 账号管理
    MyLabelItem *layout = [[MyLabelItem alloc] init];
    layout.text = @"退出当前账号";
    
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[layout];
    [self.groups addObject:group];
}


@end
