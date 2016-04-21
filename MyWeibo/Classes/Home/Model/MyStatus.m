//
//  MyStatus.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyStatus.h"
#import "MyPhoto.h"
#import "NSDate+MJ.h"
@implementation MyStatus

+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[MyPhoto class]};
}

-(NSString*) created_at
{
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"EEE MMM d HH:mm:ss Z yyyy";
    NSDate  *created_at=[fmt dateFromString:_created_at];
    
    if ([created_at isThisYear]) {//今年
       
        if ([created_at isToday]) {//今天
          
            NSDateComponents *cmp= [created_at deltaWithNow];
            
            if (cmp.hour>=1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
            }else if (cmp.minute>1){
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
            }else{
                return @"刚刚";
            }
        }
        else if ([created_at isYesterday]){//昨天
         fmt.dateFormat=@"昨天 HH:mm";
            return [fmt stringFromDate:created_at];
        }
        else{//昨天以前
            fmt.dateFormat=@"MM-dd HH:mm";
            return [fmt stringFromDate:created_at];
        }
    }
    else{//不是今年
        fmt.dateFormat=@"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    return _created_at;
}

-(void) setSource:(NSString *)source
{
    NSRange range=[source rangeOfString:@">"];
    source=[source substringFromIndex:range.location+range.length];
    range=[source rangeOfString:@"<"];
    source =[source substringToIndex:range.location];
    source=[NSString stringWithFormat:@"来自%@",source];
    _source=source;
}

-(void)setRetweeted_status:(MyStatus *)retweeted_status
{
    _retweeted_status=retweeted_status;
    _retweetedName=[NSString stringWithFormat:@"@%@",_retweeted_status.user.name];
    
}

@end
