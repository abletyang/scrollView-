//
//  IMEditItemCell.m
//  informationLib
//
//  Created by 杨赟 on 2018/4/24.
//  Copyright © 2018年 华西证券. All rights reserved.
//

#import "IMEditItemCell.h"

@interface IMEditItemCell()

@property (nonatomic, strong) UILabel *itemTitleLabel;

@property (nonatomic, strong) UIButton *closeBtn;

@end


@implementation IMEditItemCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    UIColor *themeColor = [UIColor mx_hex:@"#F2C67E"];
    
    UILabel *label = [[UILabel alloc] init];
    //设置自己的边框
    label.layer.borderWidth = 1;
    label.layer.borderColor = themeColor.CGColor;
    label.font = YYFont_TextRegular(15) ;
    label.textColor = themeColor;
    [self addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsZero);
    }];
    self.itemTitleLabel = label;
    
    UIImage *closeImage = [UIImage imageNamed:@""];
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:closeImage forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(-5);
        make.right.equalTo(self.mas_right).offset(5);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.closeBtn = btn;
    self.closeBtn.hidden = YES;
    
}

-(void)isShowCloseBtn:(BOOL)isShow
{
    self.closeBtn.hidden = !isShow;
}

//设置label的text
-(void)setItemTitle:(NSString *)title{
    self.itemTitleLabel.text = title;
}

-(void)btnClick
{
    if(self.closeBlock){
        self.closeBlock(self.itemTitleLabel.text);
    }
}

@end
