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

//截图view
@property (nonatomic, strong) UIView *snapView;

//记录上一次移动的时候的indexPath
@property (nonatomic, strong) NSIndexPath *oldIndexPath;

@property (nonatomic, strong) NSIndexPath *moveIndexPath;

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
        [self cellMoveInIOS8:longPress];
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

-(void)cellMoveInIOS8:(UILongPressGestureRecognizer *)longPress
{
    [self mx_longPressed:longPress];
}

/**
 *  监听手势的改变
 */
- (void)mx_longPressed:(UILongPressGestureRecognizer *)longPressGesture{
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        [self mx_gestureBegan:longPressGesture];
    }
    if (longPressGesture.state == UIGestureRecognizerStateChanged) {
        [self mx_gestureChange:longPressGesture];
    }
    if (longPressGesture.state == UIGestureRecognizerStateCancelled ||
        longPressGesture.state == UIGestureRecognizerStateEnded){
        [self mx_gestureEndOrCancle:longPressGesture];
    }
}

//手势开始的时候的方法      基本思路： 获取到长按的cell 截图放到原来cell的位置  将cell隐藏 移动过程中对截图进行操作
- (void)mx_gestureBegan:(UILongPressGestureRecognizer *)longPressGesture{
    //获取当前的长按的位置
    CGPoint location = [longPressGesture locationInView:self.collectionView];
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:location];
    if(!indexPath) return;   //这里indexpath 可能为空 当你长按 空白的地方 这里要把其过滤掉
    if(indexPath.section > 0) return;
    //获取长按的cell
    UICollectionViewCell* targetCell = [self.collectionView cellForItemAtIndexPath:indexPath];
    //获取截图
    UIView* snapView = [targetCell snapshotViewAfterScreenUpdates:YES];
    self.snapView = snapView;
    //将截图添加到collectionView上并设置位置
    snapView.frame = targetCell.frame;
    [self.collectionView addSubview:snapView];
    //隐藏cell
    targetCell.hidden = YES;
    self.oldIndexPath = indexPath;
    [UIView animateWithDuration:0.25 animations:^{
        snapView.transform = CGAffineTransformMakeScale(1.05, 1.05);
        snapView.center = location;
    }];
}

- (void)mx_gestureChange:(UILongPressGestureRecognizer *)longPressGesture{
    CGPoint currentPoint = [longPressGesture locationInView:self.collectionView];
    self.snapView.center = currentPoint;
    // 计算截图视图和哪个可见cell相交
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        // 当前隐藏的cell就不需要交换了,直接continue
        if ([self.collectionView indexPathForCell:cell] == self.oldIndexPath) {
            continue;
        }
        // 计算中心距
        CGFloat space = sqrtf(pow(self.snapView.center.x - cell.center.x, 2) + powf(self.snapView.center.y - cell.center.y, 2));
        // 如果相交一半就移动
        if (space <= self.snapView.bounds.size.width / 2) {
            self.moveIndexPath = [self.collectionView indexPathForCell:cell];
            //移动 会调用willMoveToIndexPath方法更新数据源
            NSLog(@"YYLOG old : %ld -- %ld",(long)self.oldIndexPath.section, (long)self.oldIndexPath.item);
            NSLog(@"YYLOG move : %ld -- %ld",(long)self.moveIndexPath.section, (long)self.moveIndexPath.item);
            if(self.moveIndexPath.section > 0){
                continue;
            }
            [self.collectionView moveItemAtIndexPath:self.oldIndexPath toIndexPath:self.moveIndexPath];
            //设置移动后的起始indexPath
            self.oldIndexPath = self.moveIndexPath;
            break;
        }
    }
}

- (void)mx_gestureEndOrCancle:(UILongPressGestureRecognizer *)longPressGesture{
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:self.oldIndexPath];
    // 结束动画过程中停止交互,防止出问题
    self.collectionView.userInteractionEnabled = NO;
    // 给截图视图一个动画移动到隐藏cell的新位置
    [UIView animateWithDuration:0.25 animations:^{
        self.snapView.center = cell.center;
        self.snapView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        // 移除截图视图,显示隐藏的cell并开始交互
        [self.snapView removeFromSuperview];
        cell.hidden = NO;
        self.collectionView.userInteractionEnabled = YES;
    }];
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

//- (void)moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
//{
//    if(!newIndexPath) return;
//    NSString *item = _selItemArray[indexPath.item];
//    [_selItemArray removeObject:item];
//    [_selItemArray insertObject:item atIndex:newIndexPath.item];
//
//    self.oldIndexPath = newIndexPath;
//}


#pragma mark -- 懒加载
-(YYFlowLayout *)flowLayout
{
    if(!_flowLayout){
        _flowLayout = [[YYFlowLayout alloc] init];
    }
    return _flowLayout;
}

@end
