//
//  UIView+YYExtension.m
//  MySDK
//
//  Created by 杨赟 on 2018/6/30.
//  Copyright © 2018年 杨赟. All rights reserved.
//

#import "UIView+YYExtension.h"

@implementation UIView (YYExtension)


//最左边
-(void)setMx_left:(CGFloat)mx_left
{
    CGRect frame = self.frame;
    frame.origin.x = mx_left;
    self.frame = frame;
}
-(CGFloat)mx_left
{
    return self.frame.origin.x;
}

//最上面
-(void)setMx_top:(CGFloat)mx_top
{
    CGRect frame = self.frame;
    frame.origin.y = mx_top;
    self.frame = frame;
}
-(CGFloat)mx_top{
     return self.frame.origin.y;
}

//最右边
-(void)setMx_right:(CGFloat)mx_right
{
    CGRect frame = self.frame;
    frame.origin.x = mx_right - frame.size.width;
    self.frame = frame;
}

-(CGFloat)mx_right
{
    return self.frame.origin.x + self.frame.size.width;
}

//最下面
-(void)setMx_bottom:(CGFloat)mx_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = mx_bottom - frame.size.height;
    self.frame = frame;
}

-(CGFloat)mx_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

//宽度
-(void)setMx_width:(CGFloat)mx_width
{
    CGRect frame = self.frame;
    frame.size.width = mx_width;
    self.frame = frame;
}

-(CGFloat)mx_width
{
    return self.frame.size.width;
}

//高度
-(void)setMx_height:(CGFloat)mx_height
{
    CGRect frame = self.frame;
    frame.size.height = mx_height;
    self.frame = frame;
}
-(CGFloat)mx_height
{
    return self.frame.size.height;
}

//中心点X
-(void)setMx_centerX:(CGFloat)mx_centerX
{
    self.center = CGPointMake(mx_centerX, self.center.y);
}
-(CGFloat)mx_centerX
{
    return self.center.x;
}

//中心的Y
-(void)setMx_centerY:(CGFloat)mx_centerY
{
    self.center = CGPointMake(self.center.x, mx_centerY);
}
-(CGFloat)mx_centerY
{
    return self.center.y;
}

//原点
-(void)setMx_origin:(CGPoint)mx_origin
{
    CGRect frame = self.frame;
    frame.origin.x = mx_origin.x;
    frame.origin.y = mx_origin.y;
    self.frame = frame;
}

-(CGPoint)mx_origin
{
    return self.frame.origin;
}

//size
-(void)setMx_size:(CGSize)mx_size
{
    CGRect frame = self.frame;
    frame.size.width = mx_size.width;
    frame.size.height = mx_size.height;
    self.frame = frame;
}

-(CGSize)mx_size
{
    return self.frame.size;
}

@end
