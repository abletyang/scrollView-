//
//  ViewController.m
//  ScrollViewTest
//
//  Created by 杨赟 on 2018/6/30.
//  Copyright © 2018年 杨赟. All rights reserved.
//

#import "ViewController.h"
#import "MySDK/MySDK.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MySDK sayhello];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
