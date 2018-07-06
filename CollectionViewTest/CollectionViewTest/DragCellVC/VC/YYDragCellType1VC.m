//
//  YYDragCellType1VC.m
//  CollectionViewTest
//
//  Created by 杨赟 on 2018/7/5.
//  Copyright © 2018年 杨赟. All rights reserved.
//

#import "YYDragCellType1VC.h"
#import "YYFlowLayout.h"
#import "IMEditItemCell.h"

@interface YYDragCellType1VC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) YYFlowLayout *flowLayout;
@property (nonatomic, strong)UICollectionView *collectionView;

//section2 对应的数组
@property (nonatomic, strong) NSMutableArray *restArray;
//section1 对应的数组
@property (nonatomic, strong) NSMutableArray *selItemArray;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@end

@implementation YYDragCellType1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"cell移动测试";
    [self initData];
    [self setUpCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 初始化UI
-(void)initData
{
    
    NSArray *arr = @[@"要闻",@"自选",@"股市播报",@"产经新闻",@"全球股市",@"公司",@"报刊头条",@"交易提示"];
    NSArray *arr2 = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07"];

    _selItemArray = [NSMutableArray arrayWithArray:arr];
    _restArray = [NSMutableArray arrayWithArray:arr2];
}

-(void)setUpCollectionView
{
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //添加手势
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
    [self.collectionView addGestureRecognizer:_longPress];
    
    //注册cell
    [self.collectionView registerClass:[IMEditItemCell class] forCellWithReuseIdentifier:@"IMEditItemCell"];
}

#pragma mark -- UICollectionViewDataSource

//required

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0){
        return _selItemArray.count;
    }else{
        return _restArray.count;
    }
    
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IMEditItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IMEditItemCell" forIndexPath:indexPath];
    [cell isShowCloseBtn:NO];
    if(indexPath.section == 0){
        NSString *title = _selItemArray[indexPath.item];
        [cell setItemTitle:title];
    }else{
        NSString *title = _restArray[indexPath.item];
        [cell setItemTitle:title];
    }
    return cell;
}


#pragma makr -- private
- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress
{
    if (@available(iOS 9.0, *)){
        [self cellMoveInIOS9:longPress];
    }else{
//        [self cellMoveInIOS8:longPress];
    }
}

-(void)cellMoveInIOS9:(UILongPressGestureRecognizer *)longPress
{
    CGPoint point = [longPress locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            //当没有点击到cell的时候不进行处理
            if (!indexPath) {
                break;
            }
            //开始移动
            if (@available(iOS 9.0, *)) {
                [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            } else {
                // Fallback on earlier versions
            }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程中更新位置坐标
            if (@available(iOS 9.0, *)) {
                if(indexPath.section > 0){
                    [_collectionView endInteractiveMovement];
                }
                [_collectionView updateInteractiveMovementTargetPosition:point];
            } else {
                // Fallback on earlier versions
            }
            break;
        case UIGestureRecognizerStateEnded:
            //停止移动调用此方法
            if (@available(iOS 9.0, *)) {
                [_collectionView endInteractiveMovement];
            } else {
                // Fallback on earlier versions
            }
            break;
        default:
            //取消移动
            if (@available(iOS 9.0, *)) {
                [_collectionView cancelInteractiveMovement];
            } else {
                // Fallback on earlier versions
            }
            break;
    }
}



#pragma mark --  移动item 代理

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return YES;
    }
    return NO;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *item = _selItemArray[sourceIndexPath.item];
    [_selItemArray removeObject:item];
    [_selItemArray insertObject:item atIndex:destinationIndexPath.item];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section == 1){
//        NSArray *restArr = [self fetchRestItemArray];
//        [_selItemArray addObject:restArr[indexPath.item]];
//        [collectionView reloadData];
//    }
}



#pragma mark -- 懒加载
-(YYFlowLayout *)flowLayout
{
    if(!_flowLayout){
        _flowLayout = [[YYFlowLayout alloc] init];
    }
    return _flowLayout;
}

@end
