//
//  MyAccount.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyAccount.h"

#define MyAccountTokenKey @"token"
#define MyUidKey @"uid"
#define MyExpires_inKey @"exoires"
#define MyExpires_dateKey @"date"
#define MyNameKey @"name"

#import "MJExtension.h"

@implementation MyAccount

MJCodingImplementation
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    MyAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}


@end
