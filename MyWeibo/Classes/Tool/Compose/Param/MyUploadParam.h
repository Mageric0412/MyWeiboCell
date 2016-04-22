//
//  MyUploadParam.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/22.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUploadParam : NSObject

/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
