//
//  IMEditItemCell.h
//  informationLib
//
//  Created by 杨赟 on 2018/4/24.
//  Copyright © 2018年 华西证券. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^closeBtnClickCallBaack)(NSString *item);

@interface IMEditItemCell : UICollectionViewCell


//是否显示btn按钮
-(void)isShowCloseBtn:(BOOL)isShow;

//设置label的text
-(void)setItemTitle:(NSString *)title;

//btn点击的block
@property (nonatomic, copy)closeBtnClickCallBaack closeBlock;

@end
