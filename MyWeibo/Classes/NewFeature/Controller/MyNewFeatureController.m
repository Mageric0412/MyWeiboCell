//
//  MyNewFeatureController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/19.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyNewFeatureController.h"
#import "MyNewFeatureCell.h"
#import "UIView+MyFrame.h"

@interface MyNewFeatureController ()

@property (nonatomic, weak) UIPageControl *control;

@end

@implementation MyNewFeatureController

static NSString *ID = @"cell";
- (instancetype)init
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 清空行距
    layout.minimumLineSpacing = 0;
    
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}


static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[MyNewFeatureCell class] forCellWithReuseIdentifier:ID];
    
    // Do any additional setup after loading the view.
    // 分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    
    // 添加pageController
    [self setUpPageControl];

}

- (void)setUpPageControl
{
    // 添加pageController,只需要设置位置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height);
    _control = control;
    [self.view addSubview:control];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _control.currentPage = page;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // Configure the cell
    // 拼接图片名称 3.5 320 480
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    if (screenH > 480) { // 5 , 6 , 6 plus
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
    }
    cell.image = [UIImage imageNamed:imageName];
    
    
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
