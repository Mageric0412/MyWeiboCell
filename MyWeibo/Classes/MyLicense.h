//
//  MyLicense.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/20.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyLicense : NSObject
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *client_id;
@property (nonatomic, copy) NSString *redirect_url;
@property (nonatomic, copy) NSString *client_secret;


+(NSString*) baseUrl_Return;
+(NSString*) client_id_Return;
+(NSString*) redirect_url_Return;
+(NSString*) client_secret_Return;



@end
