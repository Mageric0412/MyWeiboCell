//
//  MyUserTool.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyUserResult,MyUser;
@interface MyUserTool : NSObject

/**
 *  请求用户的未读书
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(MyUserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(MyUser *user))success failure:(void(^)(NSError *error))failure;


@end
