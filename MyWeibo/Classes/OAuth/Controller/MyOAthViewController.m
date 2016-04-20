//
//  MyOAthViewController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyOAthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "MyAccountTool.h"
#import "MyChooseTool.h"
#import "MyLicense.h"
@interface MyOAthViewController ()<UIWebViewDelegate>

@end

@implementation MyOAthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 展示登陆的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSString* baseUrl = [MyLicense baseUrl_Return];
    NSString *client_id = [MyLicense client_id_Return];
    NSString *redirect_uri = [MyLicense redirect_url_Return];
    
    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"%@",url);
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",request);
    // 加载请求
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;
}

#pragma mark -UIWebView代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];
}

// webview加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

//  webview加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    
    // 获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) { // 有code=
        
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        // 换取accessToken
        [self accessTokenWithCode:code];
        
        // 不会去加载回调界面
        return NO;
        
    }
    
    return YES;
}

/*
 
 必选	类型及范围	说明
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 
 */
#pragma mark - 换取accessToken
- (void)accessTokenWithCode:(NSString *)code
{
    [MyAccountTool accountWithCode:code success:^{
        // 进入主页或者新特性,选择窗口的根控制器
        UIWindow * rootwindow=[UIApplication sharedApplication].keyWindow;
        [MyChooseTool chooseRootViewController:rootwindow];
    } failure:^(NSError *error) {
        
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
