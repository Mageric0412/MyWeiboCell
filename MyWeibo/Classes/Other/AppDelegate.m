//
//  AppDelegate.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/15.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"
#import "MyOneViewController.h"
#import "MyOAthViewController.h"
#import "MyAccountTool.h"
#import "MyChooseTool.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    // 选择根控制器
    // 判断下有没有授权
    if ([MyAccountTool account]) { // 已经授权
        
        // 选择根控制器
        [MyChooseTool chooseRootViewController:self.window];
        
    }else{ // 进行授权
        MyOAthViewController *oauthVc = [[MyOAthViewController alloc] init];
        
        // 设置窗口的根控制器
        self.window.rootViewController = oauthVc;
        
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    
    // 停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    ///UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        // 当后台任务结束的时候调用
      //  [application endBackgroundTask:ID];
        
   // }];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
