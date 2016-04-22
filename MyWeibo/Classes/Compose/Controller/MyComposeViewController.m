//
//  MyComposeViewController.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/21.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyComposeViewController.h"
#import "MyTextView.h"
#import "MyComposeToolBar.h"
#import "UIView+MyFrame.h"
#import "MyComposePhotosView.h"
#import "MyComposeTool.h"
#import "MBProgressHUD+MJ.h"
@interface MyComposeViewController ()<UITextViewDelegate,MyComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,weak)MyTextView *textView;

@property(nonatomic,weak)MyComposeToolBar *toolBar;

@property(nonatomic,weak)MyComposePhotosView *photosView;

@property(nonatomic,strong)UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation MyComposeViewController

-(NSMutableArray*)images
{
    if (_images==nil) {
        _images=[NSMutableArray array];
    }
    
    return  _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNavigationBar];
    
    [self setUpTextView];
    
    [self setUpToolBar];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setUpPhotosView];
    
   
}

-(void)setUpPhotosView
{
    MyComposePhotosView *photosView=[[MyComposePhotosView alloc]initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height-70)];
    _photosView=photosView;
    [_textView addSubview:photosView];
}


-(void)keyboardFrameChange:(NSNotification*) note
{
    CGFloat durtion=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGRect frame=[note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    if (frame.origin.y==self.view.height) {
        _toolBar.transform=CGAffineTransformIdentity;
    }else{
        [UIView animateWithDuration:durtion animations:^{
            _toolBar.transform=CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
        
    }
}

-(void)setUpToolBar
{
    CGFloat h=35;
    CGFloat y=self.view.height-h;
    
    MyComposeToolBar* toolBar=[[MyComposeToolBar alloc]initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar=toolBar;
    toolBar.delegate=self;
    [self.view addSubview:toolBar];
}

//实现代理，点击工具栏调用其他
-(void)composeToolBar:(MyComposeToolBar *)toolBar didClickBtn:(NSInteger)index
{
    if (index ==0) {
        UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
        //设置相册类型
        imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.delegate=self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    [self.images addObject:image];
    _photosView.image=image;
                        
    [self dismissViewControllerAnimated:YES completion:nil];
    _rightItem.enabled=YES;
}


-(void)setUpTextView
{
    MyTextView *textView=[[MyTextView alloc]initWithFrame:self.view.bounds];
     textView.placeHolder=@"写些什么吧....";
    _textView=textView;
    //可以设置字体...
    
    [self.view addSubview:textView];
    textView.alwaysBounceVertical=YES;  
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    _textView.delegate=self;
    
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)textChange
{
    if (_textView.text.length) {
        _textView.hideHolder=YES;
        _rightItem.enabled=YES;
    }else{
        _textView.hideHolder=NO;
        _rightItem.enabled=NO;
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)setUpNavigationBar
{
    self.title=@"发微博";
   
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    rightItem.enabled=NO;
    self.navigationItem.rightBarButtonItem=rightItem;
    _rightItem=rightItem;
}

//发送微博
-(void)compose
{
    if (self.images.count) {
        
        [self sendPicture];
    }else{
        [self sendTitle];
    }
    
    
}

- (void)sendPicture
{
    UIImage *image = self.images[0];
    
    NSString *status = _textView.text.length?_textView.text:@"分享图片";
    
    _rightItem.enabled = NO;
    // 我引用你，你引用我
    [MyComposeTool composeWithStatus:status image:image success:^{
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送图片成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        _rightItem.enabled = YES;
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error.description);
        [MBProgressHUD showSuccess:@"发送图片失败"];
        _rightItem.enabled = YES;
        
    }];
}


-(void)sendTitle
{
    [MyComposeTool composeWithStatus:_textView.text success:^{
        [MBProgressHUD showSuccess:@"搞定!"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        
    }];
}

-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
