//
//  MyHttpTool.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyUploadParam;

@interface MyHttpTool : NSObject

/**
 *  发送get请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


/**
 *  发送post请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

/**
 *  上传请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)Upload:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(MyUploadParam *)uploadParam
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;

///**
// *  上传多图请求
// *
// *  @param URLString  请求的基本的url
// *  @param parameters 请求的参数字典
// *  @param success    请求成功的回调
// *  @param failure    请求失败的回调
// */
//+ (void)Upload:(NSString *)URLString
//    parameters:(id)parameters
//   uploadParam:(MyUploadParam *)uploadParam
//       success:(void (^)(id responseObject))success
//       failure:(void (^)(NSError *error))failure;
//

@end
