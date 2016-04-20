//
//  MyBaseParam.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyBaseParam.h"
#import "MyAccountTool.h"
#import "MyAccount.h"
@implementation MyBaseParam

+(instancetype)param
{
    MyBaseParam *param=[[self alloc]init];
    param.access_token=[MyAccountTool account].access_token;
    
    return param;
}

@end
