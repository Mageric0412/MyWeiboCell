//
//  MyAccountTool.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyAccountTool.h"
#import "MyAccount.h"
#import "AFNetworking.h"

#import "MyHttpTool.h"
#import "MyAccountParam.h"

#import "MJExtension.h"
#import "MyLicense.h"
#define MyAuthorizeBaseUrl [MyLicense baseUrl_Return]
#define MyClient_id     [MyLicense client_id_Return]
#define MyRedirect_uri  [MyLicense redirect_url_Return]
#define MyClient_secret [MyLicense client_secret_Return]

#define MyAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]


@implementation MyAccountTool

static MyAccount *_account;

+ (void)saveAccount:(MyAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:MyAccountFileName];
}

+ (MyAccount *)account
{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:MyAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期
            return nil;
        }
        
    }
    
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    // 创建参数模型
    MyAccountParam *param = [[MyAccountParam alloc] init];
    param.client_id = MyClient_id;
    param.client_secret = MyClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = MyRedirect_uri;
    
    [MyHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        // 字典转模型
        MyAccount *account = [MyAccount accountWithDict:responseObject];
        
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        [MyAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
