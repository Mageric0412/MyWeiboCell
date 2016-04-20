//
//  MyUserTool.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyUserTool.h"
#import "MyUserParam.h"
#import "MyUserResult.h"

#import "MyHttpTool.h"

#import "MyAccountTool.h"
#import "MyAccount.h"
#import "MJExtension.h"
#import "MyUser.h"

@implementation MyUserTool

+ (void)unreadWithSuccess:(void (^)(MyUserResult *))success failure:(void (^)(NSError *))failure
{
    
    // 创建参数模型
    MyUserParam *param = [MyUserParam param];
    param.uid = [MyAccountTool account].uid;
    
    [MyHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 字典转换模型
        MyUserResult *result = [MyUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userInfoWithSuccess:(void (^)(MyUser *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    MyUserParam *param = [MyUserParam param];
    param.uid = [MyAccountTool account].uid;
    
    [MyHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 用户字典转换用户模型
        MyUser *user = [MyUser objectWithKeyValues:responseObject];
        
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

@end
