//
//  MyAccountTool.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyAccount;

@interface MyAccountTool : NSObject

+ (void)saveAccount:(MyAccount *)account;

+ (MyAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
