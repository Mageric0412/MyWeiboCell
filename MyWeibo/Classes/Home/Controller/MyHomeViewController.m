//
//  MyHomeViewController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/18.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyHomeViewController.h"
#import "UIBarButtonItem+Item.h"
#import "MyTitleButton.h"
#import "MyPopMenu.h"
#import "MyCover.h"
#import "MyOneViewController.h"
#import "UIView+MyFrame.h"
#import "UIImage+Image.h"

#import "MyStatus.h"
#import "MyUser.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "MyStatusTool.h"
#import "MyUserTool.h"
#import "MyAccountTool.h"
#import "MyAccount.h"

@interface MyHomeViewController ()<MyCoverDelegate>

@property (nonatomic, weak) MyTitleButton *titleButton;

@property (nonatomic, strong) MyOneViewController *one;

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation MyHomeViewController

- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

-(MyOneViewController *) one
{
    if (_one==nil) {
        _one=[[MyOneViewController alloc]init];
    }
    return _one;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
    // 添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    // 添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    
    // 一开始展示之前的微博名称，然后在发送用户信息请求，直接赋值
    
    // 请求当前用户的昵称
    [MyUserTool userInfoWithSuccess:^(MyUser *user) {
        
        // 请求当前账号的用户信息
        // 设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        // 获取当前的账号
        MyAccount *account = [MyAccountTool account];
        account.name = user.name;
        
        // 保存用户的名称
        [MyAccountTool saveAccount:account];
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)refresh{
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
}

#pragma mark - 请求更多旧的微博
- (void)loadMoreStatus
{
    NSString *maxIdStr = nil;
    if (self.statuses.count) { // 有微博数据，才需要下拉刷新
        long long maxId = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    // 请求更多的微博数据
    [MyStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        // 把数组中的元素添加进去
        [self.statuses addObjectsFromArray:statuses];
        
        // 刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)ShowNewStatusCount:(int)count
{
    if (0==count) {
        return;
    }
    CGFloat h=35;
    CGFloat y=CGRectGetMaxY(self.navigationController.navigationBar.frame)-h;
    CGFloat x= 0;
    CGFloat w= self.view.width;
    UILabel * newlabel=[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    newlabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    newlabel.text=[NSString stringWithFormat:@"新微博数:%d",count];
    newlabel.textAlignment=NSTextAlignmentCenter;
    newlabel.textColor=[UIColor whiteColor];
    
    [self.navigationController.view insertSubview:newlabel belowSubview:self.navigationController.navigationBar];
    //[self.view addSubview:newlabel];
    [UIView animateWithDuration:0.2 animations:^{
        newlabel.transform=CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            newlabel.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [newlabel removeFromSuperview];
        }];
    }];
}


#pragma mark - 请求最新的微博
- (void)loadNewStatus
{
    NSString *sinceId = nil;
    if (self.statuses.count) { // 有微博数据，才需要下拉刷新
        
        sinceId = [self.statuses[0] idstr];
    }
    
    [MyStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) { // 请求成功的Block
        [self ShowNewStatusCount:statuses.count];
        // 结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        // 把最新的微博数插入到最前面
        [self.statuses insertObjects:statuses atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)setUpNavigationBar
{
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
    MyTitleButton *titleButton = [MyTitleButton buttonWithType:UIButtonTypeCustom];
    
    _titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}


-(void)titleClick:(UIButton *)button
{
    button.selected=!button.selected;
    MyCover *cover=[MyCover show];
    cover.delegate=self;
    
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    MyPopMenu *menu = [MyPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
    
}

// 点击蒙板的时候调用
- (void)coverDidClickCover:(MyCover *)cover
{
    // 隐藏pop菜单
    [MyPopMenu hide];
    
    _titleButton.selected = NO;
    
}

- (void)friendsearch
{
    //    NSLog(@"%s",__func__);
}

- (void)pop
{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 获取status模型
    MyStatus *status = self.statuses[indexPath.row];
    
    // 用户昵称
    cell.textLabel.text = status.user.name;
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    cell.detailTextLabel.text = status.text;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
