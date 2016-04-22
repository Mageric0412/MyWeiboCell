//
//  MyTabBarController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/18.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyTabBarController.h"
#import "UIImage+Image.h"
#import "MyTabBar.h"
#import "MyHomeViewController.h"
#import "MyDiscoverViewController.h"
#import "MyMessageViewController.h"
#import "MyProfileViewController.h"
#import "UIBarButtonItem+Item.h"
#import "MyNavigationController.h"
#import "MyUserTool.h"
#import "MyUserResult.h"
#import "MyComposeViewController.h"

@interface MyTabBarController ()<MyTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) MyHomeViewController *home;

@property (nonatomic, weak) MyMessageViewController *message;

@property (nonatomic, weak) MyProfileViewController *profile;

@end

@implementation MyTabBarController

- (NSMutableArray *)items
{
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
}



#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    // 自定义tabBar
    MyTabBar *tabBar = [[MyTabBar alloc] initWithFrame:self.tabBar.frame];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    // 添加自定义tabBar
    [self.view addSubview:tabBar];
    
    // 移除系统的tabBar
    [self.tabBar removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpAllChildViewController];
    [self setUpTabBar];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
   
    
}

// 请求未读数
- (void)requestUnread
{
    
    // 请求微博的未读数
    [MyUserTool unreadWithSuccess:^(MyUserResult *result) {
        
        // 设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        
        // 设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        
        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        // 设置应用程序所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totoalCount;
        
        
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(MyTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) { // 点击首页，刷新
        [_home refresh];
    }
    self.selectedIndex = index;
}

-(void)tabBarDidClickPlusButton:(MyTabBar *)tabBar
{
    MyComposeViewController* composeVc=[[MyComposeViewController alloc]init];
    MyNavigationController *nav=[[MyNavigationController alloc]initWithRootViewController:composeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void) setUpAllChildViewController
{
    MyHomeViewController* home=[[MyHomeViewController alloc]init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _home=home;
    //home.view.backgroundColor=[UIColor yellowColor];
    
    MyMessageViewController *message=[[MyMessageViewController alloc]init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    //message.view.backgroundColor=[UIColor redColor];
 
    
    MyDiscoverViewController *discover=[[MyDiscoverViewController alloc]init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    //discover.view.backgroundColor=[UIColor greenColor];
    
    MyProfileViewController *profile=[[MyProfileViewController alloc]init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    //profile.view.backgroundColor=[UIColor blueColor];

    
}
-(void) setUpOneChildViewController:(UIViewController*)vc image:(UIImage*) image selectedImage:(UIImage*)selectedImage title:(NSString*) title
{
    //vc.view.backgroundColor=[UIColor yellowColor];
    vc.title=title;
    vc.tabBarItem.image=image;
    vc.tabBarItem.selectedImage=selectedImage;
    
   // UIViewController *home=[[UIViewController alloc]init];
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];

    MyNavigationController *nav = [[MyNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
