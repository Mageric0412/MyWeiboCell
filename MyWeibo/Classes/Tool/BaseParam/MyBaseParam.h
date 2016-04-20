//
//  MyBaseParam.h
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBaseParam : NSObject

@property(nonatomic,copy)NSString *access_token;

+(instancetype) param;

@end
