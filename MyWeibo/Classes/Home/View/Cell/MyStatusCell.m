//
//  MyStatusCell.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/20.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyStatusCell.h"
#import "MyOriginalView.h"
#import "MyRepostView.h"
#import "MyStatusToolBar.h"
#import "MyStatusFrame.h"
#import "MyStatus.h"

@interface MyStatusCell ()

@property(nonatomic,weak) MyOriginalView *originView;

@property(nonatomic,weak) MyRepostView *repostView;

@property(nonatomic,weak) MyStatusToolBar *toolBar;

@end

@implementation MyStatusCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setStatusF:(MyStatusFrame *)statusF
{
    _statusF = statusF;
    
    // 设置原创微博frame
    _originView.frame = statusF.originalViewFrame;
    _originView.statusF = statusF;
    
    if (statusF.status.retweeted_status) {
        _repostView.frame = statusF.repostViewFrame;
        _repostView.statusF = statusF;
        _repostView.hidden=NO;
    }
    else {
        _repostView.hidden=YES;
    }
    // 设置原创微博frame
    
    
    // 设置工具条frame
    _toolBar.frame = statusF.toolBarFrame;
    _toolBar.status=statusF.status;
    MyStatus *st=statusF.status;
    NSLog(@"用户:%@ ,%d ,%d, %d",statusF.status.user.name,st.reposts_count,st.comments_count,st.attitudes_count);
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    return  cell;
}

-(void)setUpAllChildView
{
    //原创
    MyOriginalView * originView= [[MyOriginalView alloc]init];
    [self addSubview:originView];
    _originView=originView;
    
    //转发
    MyRepostView * repostView=[[MyRepostView alloc]init];
    [self addSubview:repostView];
    _repostView=repostView;
    
    //工具条
    MyStatusToolBar *toolBar=[[MyStatusToolBar alloc]init];
    [self addSubview:toolBar];
    _toolBar=toolBar;
    
    
}

@end
