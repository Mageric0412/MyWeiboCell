//
//  MyQualityViewController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/24.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyQualityViewController.h"
#import "MyGroupItem.h"
#import "MyCheakItem.h"
#import "MyProfileCell.h"

#define MyUserDefaults [NSUserDefaults standardUserDefaults]
#define MyFontSizeKey @"字号大小"
#define MyFontSizeChangeNote @"fontSiziChange"
#define MySelDownloadKey @"selDownloadKey"
#define MySelUploadKey @"selUploadKey"

@interface MyQualityViewController()

@property(nonatomic,strong) MyCheakItem *selUploadItem;
@property(nonatomic,strong) MyCheakItem *selDownloadItem;

@end

@implementation MyQualityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加第0组
    [self setUpGroup0];
    
    // 添加第1组
    [self setUpGroup1];
    
}

- (void)setUpGroup0
{
    // 高清
    MyCheakItem *high = [MyCheakItem itemWithTitle:@"高清"];
    high.subTitle = @"建议在Wifi或3G网络使用";
    __weak typeof(self) vc = self;
    high.option = ^{
        [vc selUploadItem:high];
    };
    
    // 普通
    MyCheakItem *normal = [MyCheakItem itemWithTitle:@"普通"];
    normal.subTitle = @"上传速度快，省流量";
    
    normal.option = ^{
        [vc selUploadItem:normal];
    };
    
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.headTitle = @"上传图片质量";
    group.items = @[high,normal];
    [self.groups addObject:group];
    
    // 默认选中第0组的一行
    NSString *upload = [MyUserDefaults objectForKey:MySelUploadKey];
    if (upload == nil) {
        [self selUploadItem:high];
        return;
    }
    for (MyCheakItem *item in group.items) {
        if ([item.title isEqualToString:upload]) {
            [self selUploadItem:item];
        }
    }
    
}


- (void)setUpGroup1
{
    // 高清
    MyCheakItem *high = [MyCheakItem itemWithTitle:@"高清"];
    high.subTitle = @"建议在Wifi或3G网络使用";
    __weak typeof(self) vc = self;
    high.option = ^{
        [vc selDownloadItem:high];
        
    };
    
    // 普通
    MyCheakItem *normal = [MyCheakItem itemWithTitle:@"普通"];
    normal.subTitle = @"下载速度快，省流量";
    normal.option = ^{
        [vc selDownloadItem:normal];
    };
    
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.headTitle = @"下载图片质量";
    group.items = @[high,normal];
    [self.groups addObject:group];
    
    // 默认选中第0组的一行
    NSString *downLoad = [MyUserDefaults objectForKey:MySelDownloadKey];
    if (downLoad == nil) {
        [self selDownloadItem:high];
        return;
    }
    
    for (MyCheakItem *item in group.items) {
        if ([item.title isEqualToString:downLoad]) {
            [self selDownloadItem:item];
        }
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyProfileCell *cell = [MyProfileCell cellWithTableView:tableView];
    
    // 获取模型
    MyGroupItem *groupItem = self.groups[indexPath.section];
    MySettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    //[cell setIndexPath:indexPath rowCount:groupItem.items.count];
    return cell;
}


- (void)selUploadItem:(MyCheakItem *)item
{
    _selUploadItem.cheak = NO;
    item.cheak = YES;
    _selUploadItem = item;
    [self.tableView reloadData];
    
    // 数据存储
    [MyUserDefaults setObject:item.title forKey:MySelUploadKey];
    [MyUserDefaults synchronize];
}

- (void)selDownloadItem:(MyCheakItem *)item
{
    _selDownloadItem.cheak = NO;
    item.cheak = YES;
    _selDownloadItem = item;
    [self.tableView reloadData];
    
    // 数据存储
    [MyUserDefaults setObject:item.title forKey:MySelDownloadKey];
    [MyUserDefaults synchronize];
}


@end
