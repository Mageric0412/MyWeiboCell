//
//  MyNavigationController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/18.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyNavigationController.h"
#import "UIBarButtonItem+Item.h"
#import "MyTabBar.h"

@interface MyNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation MyNavigationController

+(void) initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
        
        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = right;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[MyTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) { // 是根控制器
        
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }else{ // 非根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }
}


@end
