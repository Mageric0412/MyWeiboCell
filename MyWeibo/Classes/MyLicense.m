//
//  MyLicense.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/20.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyLicense.h"
@interface MyLicense()


@end

@implementation MyLicense

+(NSString*) baseUrl_Return
{
   
   return @"https://api.weibo.com/oauth2/authorize";
}

+(NSString*) client_id_Return
{
   return  @"2408893895";
    
}
+(NSString*) redirect_url_Return
{
    return @"http://www.baidu.com";
}
+(NSString*) client_secret_Return
{
    return @"34c54de4b96bec14a60d3fe798f13788";
}

@end
