//
//  YYFlowLayout.m
//  CollectionViewTest
//
//  Created by 杨赟 on 2018/7/5.
//  Copyright © 2018年 杨赟. All rights reserved.
//

#import "YYFlowLayout.h"


@implementation YYFlowLayout
{
    //这个数组就是我们自定义的布局配置数组
    NSMutableArray * _attributeAttay;
}

-(void)prepareLayout{
    [super prepareLayout];
    
    //设置 itemSize的大小
    CGFloat itemWidth = 80;
    CGFloat itemHeight = 31;
    CGFloat commenSpace = 14;
    
    self.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.headerReferenceSize=CGSizeMake(SCREEN_WIDTH, 39);
    self.minimumInteritemSpacing = 1;
    //设置 滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置内边距
    self.sectionInset = UIEdgeInsetsMake(10, commenSpace, 10, commenSpace);
}
@end
