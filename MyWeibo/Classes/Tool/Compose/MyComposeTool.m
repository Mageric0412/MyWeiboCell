//
//  MyComposeTool.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/22.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyComposeTool.h"
#import "MyHttpTool.h"
#import "MJExtension.h"
#import "MyComposeParam.h"
#import "MyUploadParam.h"
#import "AFNetworking.h"

@implementation MyComposeTool

+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    MyComposeParam *param = [MyComposeParam param];
    param.status = status;
    
    [MyHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    MyComposeParam *param = [MyComposeParam param];
    param.status = status;
    
    // 创建上传的模型
    MyUploadParam *uploadP = [[MyUploadParam alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    // 注意：以后如果一个方法，要传很多参数，就把参数包装成一个模型
    [MyHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadP success:^(id responseObject) {
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
