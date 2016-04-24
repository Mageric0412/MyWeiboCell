//
//  MyFontSizeViewController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/24.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyFontSizeViewController.h"
#import "MyGroupItem.h"
#import "MyCheakItem.h"

#define MyUserDefaults [NSUserDefaults standardUserDefaults]
#define MyFontSizeKey @"字号大小"
#define MyFontSizeChangeNote @"fontSiziChange"

@interface MyFontSizeViewController()

@property(nonatomic,strong) MyCheakItem *selCheakItem;

@end

@implementation MyFontSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加第0组
    [self setUpGroup0];
    
}

- (void)setUpSelItem:(MyCheakItem *)item
{
    NSString *fontSizeStr =  [MyUserDefaults objectForKey:MyFontSizeKey];
    if (fontSizeStr == nil) {
        [self selItem:item];
        return;
    }
    
    for (MyGroupItem *group in self.groups) {
        for (MyCheakItem *item in group.items) {
            if ( [item.title isEqualToString:fontSizeStr]) {
                [self selItem:item];
            }
            
        }
        
    }
}

- (void)setUpGroup0
{
    
    
    // 大
    MyCheakItem *big = [MyCheakItem itemWithTitle:@"大"];
    __weak typeof(self) vc = self;
    big.option = ^{
        [vc selItem:big];
    };
    
    // 中
    MyCheakItem *middle = [MyCheakItem itemWithTitle:@"中"];
    
    middle.option = ^{
        [vc selItem:middle];
    };
    _selCheakItem = middle;
    // 小
    MyCheakItem *small = [MyCheakItem itemWithTitle:@"小"];
    small.option = ^{
        [vc selItem:small];
    };
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.headTitle = @"字体选择";
    group.items = @[big,middle,small];
    [self.groups addObject:group];
    
    // 默认选中item
    [self setUpSelItem:middle];
    
}

- (void)selItem:(MyCheakItem *)item
{
    _selCheakItem.cheak = NO;
    item.cheak = YES;
    _selCheakItem = item;
    [self.tableView reloadData];
    
    
    // 存储
    [MyUserDefaults setObject:item.title forKey:MyFontSizeKey];
    [MyUserDefaults synchronize];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fontSiziChange" object:nil userInfo:@{MyFontSizeKey:item.title}];
    
}


@end
