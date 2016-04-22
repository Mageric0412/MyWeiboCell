//
//  MyTextView.m
//  MyWeibo
//
//  Created by mageric-mac on 16/4/22.
//  Copyright © 2016年 mageric-mac. All rights reserved.
//

#import "MyTextView.h"
#import "UIView+MyFrame.h"

@interface MyTextView()

@property(nonatomic,weak )UILabel *placeHolderLabel;

@end

@implementation MyTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        self.font =[UIFont systemFontOfSize:13];
    }
    
    return  self;
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
     self.placeHolderLabel.font=self.font;
    [self.placeHolderLabel sizeToFit];
}

-(UILabel*) placeHolderLabel
{
    if (_placeHolderLabel ==nil) {
        UILabel *label=[[UILabel alloc]init];
        
        [self addSubview:label];
        
        _placeHolderLabel=label;
    }
    return _placeHolderLabel;
}

-(void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder=placeHolder;
  
    self.placeHolderLabel.text=placeHolder;
    
    [self.placeHolderLabel sizeToFit];
}

-(void)setHideHolder:(BOOL)hideHolder
{
    _hideHolder=hideHolder;
    self.placeHolderLabel.hidden=hideHolder;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeHolderLabel.x=5;
    self.placeHolderLabel.y=8;
}
@end
