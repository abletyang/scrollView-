//
//  YYScrollknowledgeVC.m
//  ScrollViewTest
//
//  Created by 杨赟 on 2018/6/30.
//  Copyright © 2018年 杨赟. All rights reserved.
//

#import "YYScrollknowledgeVC.h"

@interface YYScrollknowledgeVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YYScrollknowledgeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //EFF2F5
    UIColor *color = [UIColor mx_hex:@"#EFF2F5"];
    self.view.backgroundColor = color;
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  -- 初始化UI

//使用 masonry 进行布局
-(void)initUI
{
    //1.使用 masonry 进行布局  （需要使用一个 View用来过渡）
    UIView *contentV = [[UIView alloc] init];
    [self.scrollView addSubview:contentV];
    
    UIView *preView = self.scrollView;
    for (int i=0; i<5; i++) {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.backgroundColor = [UIColor mx_randomColor];
        [contentV addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0){
                make.left.equalTo(preView.mas_left);
            }else{
                make.left.equalTo(preView.mas_right);
            }
            make.top.bottom.equalTo(contentV);
            make.width.mas_equalTo(self.view.mas_width);
        }];
        preView = imgV;
    }
    
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(_scrollView);
        make.height.mas_equalTo(_scrollView);
        make.right.mas_equalTo(preView.mas_right);
    }];
}

//使用frame进行 布局
-(void)setUpUI
{
    [self.view addSubview:self.scrollView];
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:redView];
    redView.frame = CGRectMake(0, 0, self.view.mx_width*2, 100);
    
    self.scrollView.contentSize = CGSizeMake(self.view.mx_width * 2, self.view.mx_height);
    
    self.scrollView.contentOffset = CGPointMake(100, 100);
    self.scrollView.bounces = NO;
//    self.scrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
//    UIEdgeInsets safeInsets = self.scrollView.adjustedContentInset;
//    NSLog(@"%@",NSStringFromUIEdgeInsets(safeInsets));
}

#pragma mark -- 懒加载
-(UIScrollView *)scrollView
{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    }
    return _scrollView;
}


@end
