//
//  MyUserResult.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyUserResult.h"

@implementation MyUserResult

- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totoalCount
{
    return self.messageCount + _status + _follower;
}

@end
