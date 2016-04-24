//
//  MyCommonViewController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/24.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyCommonViewController.h"
#import "MyArrowItem.h"
#import "MySwitchItem.h"
#import "MyGroupItem.h"

#import "MyFontSizeViewController.h"
#import "MyQualityViewController.h"
#import "UIImageView+WebCache.h"

#define MyUserDefaults [NSUserDefaults standardUserDefaults]
#define MyFontSizeKey @"字号大小"
#define MyFontSizeChangeNote @"fontSiziChange"

@interface MyCommonViewController()
@property (nonatomic, weak) MySettingItem *fontSize;
@end

@implementation MyCommonViewController

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
    // 添加第4组
    [self setUpGroup4];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSizeChange:) name:@"fontSiziChange" object:nil];
    
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    
}

- (void)fontSizeChange:(NSNotification *)notication
{
    _fontSize.subTitle = notication.userInfo[MyFontSizeKey];
    [self.tableView reloadData];
}

- (void)setUpGroup0
{
    // 阅读模式
    MySettingItem *read = [MySettingItem itemWithTitle:@"阅读模式"];
    read.subTitle = @"有图模式";
    
    // 字体大小
    MySettingItem *fontSize = [MySettingItem itemWithTitle:@"字体大小"];
    _fontSize = fontSize;
    NSString *fontSizeStr =  [MyUserDefaults objectForKey:MyFontSizeKey];
    if (fontSizeStr == nil) {
        fontSizeStr = @"中";
    }
    fontSize.subTitle = fontSizeStr;
    fontSize.descVc = [MyFontSizeViewController class];
    
    // 显示备注
    MySwitchItem *remark = [MySwitchItem itemWithTitle:@"显示备注"];
    
    
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[read,fontSize,remark];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 图片质量
    MyArrowItem *quality = [MyArrowItem itemWithTitle:@"图片质量" ];
    quality.descVc = [MyQualityViewController class];
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[quality];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 声音
    MySwitchItem *sound = [MySwitchItem itemWithTitle:@"声音" ];
    
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[sound];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 多语言环境
    MySettingItem *language = [MySettingItem itemWithTitle:@"多语言环境"];
    language.subTitle = @"跟随系统";
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[language];
    [self.groups addObject:group];
}

- (void)setUpGroup4
{
    // 清空图片缓存
    MyArrowItem *clearImage = [MyArrowItem itemWithTitle:@"清空图片缓存"];
    CGFloat fileSize = [SDWebImageManager sharedManager].imageCache.getSize / 1024.0;
    clearImage.subTitle = [NSString stringWithFormat:@"%.fKB",fileSize];
    if (fileSize > 1024) {
        fileSize =   fileSize / 1024.0;
        clearImage.subTitle = [NSString stringWithFormat:@"%.1fM",fileSize];
    }
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    
    CGFloat size =  [self sizeWithFile:filePath];
    NSLog(@"%f",size);
    clearImage.option = ^{
        
        [[SDWebImageManager sharedManager].imageCache clearDisk];
        clearImage.subTitle = nil;
        [self.tableView reloadData];
        
        //     NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        //      NSString *filePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
        //
        //        [self removeFile:filePath];
        
    };
    MyGroupItem *group = [[MyGroupItem alloc] init];
    group.items = @[clearImage];
    [self.groups addObject:group];
}

- (CGFloat)sizeWithFile:(NSString *)filePath
{
    CGFloat totalSize = 0;
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (isExists) {
        
        if (isDirectory) {
            
            NSArray *subPaths =  [mgr subpathsAtPath:filePath];
            
            for (NSString *subPath in subPaths) {
                NSString *fullPath = [filePath stringByAppendingPathComponent:subPath];
                
                BOOL isDirectory;
                [mgr fileExistsAtPath:fullPath isDirectory:&isDirectory];
                
                if (!isDirectory) { // 计算文件尺寸
                    NSDictionary *dict =  [mgr attributesOfItemAtPath:fullPath error:nil];
                    
                    totalSize += [dict[NSFileSize] floatValue];;
                }
            }
            
        }else{
            
            NSDictionary *dict =  [mgr attributesOfItemAtPath:filePath error:nil];
            totalSize =  [dict[NSFileSize] floatValue];
        }
    }
    return totalSize;
}

- (void)removeFile:(NSString *)filePath
{
    
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

@end
