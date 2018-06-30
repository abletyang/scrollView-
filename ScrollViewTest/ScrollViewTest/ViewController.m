//
//  ViewController.m
//  ScrollViewTest
//
//  Created by 杨赟 on 2018/6/30.
//  Copyright © 2018年 杨赟. All rights reserved.
//

#import "ViewController.h"
#import "MySDK/MySDK.h"
#import <Masonry.h>

@interface ViewController ()
 
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MySDK sayhello];
    
    [self initUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initUI
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}


@end
