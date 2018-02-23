//
//  JJProductCategoryView.m
//  DaCongMing
//
//  Created by hailin on 2018/1/19.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJProductCategoryView.h"
#import "JJSortTypeCell.h"

static NSString* const COLCELLID = @"COLCELLID";

@interface JJProductCategoryView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, assign) BOOL isZK;
@property (nonatomic, strong) UIButton* zkBtn;
@end

@implementation JJProductCategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _block = [[NSMutableArray alloc] init];
        
        [self configCollectionViewWith:frame];
        self.isZK = NO;//初始状态
    }
    return self;
}

- (void)configCollectionViewWith:(CGRect)frame {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//设置布局方向
    //        layout.itemSize = CGSizeMake(SortTypeWidth, SortTypeHeight);//item大小
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-20, frame.size.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO; //滚动条
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[JJSortTypeCell class] forCellWithReuseIdentifier:COLCELLID];
    [self addSubview:self.collectionView];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.scrollEnabled = NO;
}

- (void)updateUI {
    
}

- (UIButton *)zkBtn {
    if (!_zkBtn) {
        _zkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zkBtn addTarget:self action:@selector(zkAction:) forControlEvents:UIControlEventTouchUpInside];
        _zkBtn.layer.cornerRadius = 10;
        _zkBtn.layer.masksToBounds = YES;
        
    }
    return _zkBtn;
}
- (void)zkAction:(UIButton*)button {
    [self zkBtnChangeStatus];
}
- (void)zkBtnWith {
    [self zkBtnChangeStatus];
}
- (void)zkBtnChangeStatus {
    if (self.isZK)
    {//展开状态
        self.isZK = NO;
        [self.zkBtn setBackgroundImage:[UIImage imageNamed:@"sq"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5 animations:^{
            //ceil(block.count/5.0f)
            self.hm_height = 10 + (HeightSortTypeCell+10)*ceil(_block.count/5.0f) + 10;
             _collectionView.hm_height =  10 + (HeightSortTypeCell+10)*ceil(_block.count/5.0f) + 10;
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotyUpdateTableView object:nil userInfo:@{@"isZK":@"1"}];
    }
    else
    {//收起状态
        self.isZK = YES;
        [self.zkBtn setBackgroundImage:[UIImage imageNamed:@"zk"] forState:UIControlStateNormal];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotyUpdateTableView object:nil userInfo:@{@"isZK":@"0"}];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.hm_height = HeightSortTypeCell + 10;
           _collectionView.hm_height = HeightSortTypeCell + 10;
        }];
    }
}

#pragma mark - conllection delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _block.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JJSortTypeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLCELLID forIndexPath:indexPath];
    if (!cell) {
        cell = [[JJSortTypeCell alloc] init];
    }
    if (indexPath.row < _block.count) {
        //JJProductCategoryModel* model = [JJProductCategoryModel modelFromDict:(NSDictionary*)_block[indexPath.row]];
        JJProductCategoryModel* model = [_block objectAtIndex:indexPath.row];
        [cell setModel:model];
        if ([model.imageUrl isEqualToString:@"zk"]) {
            [_collectionView addSubview:self.zkBtn];
            self.zkBtn.frame = CGRectMake(_collectionView.frame.size.width-cell.frame.size.width, 0, cell.size.width, cell.size.height);
            [self zkBtnWith];
        }
    }
    
    return cell;
}

//#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _block.count) {
        JJProductCategoryModel* model = _block[indexPath.row];
        NSLog(@"collectionView : %ld, jumpUrl : %@",(long)indexPath.row, model.jumpUrl);
        if (![model.imageUrl isEqualToString:@"zk"]) {
            [DCURLRouter pushURLString:_block[indexPath.row].jumpUrl animated:YES];
        }
    }
    
}
//#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(HeightSortTypeCell,HeightSortTypeCell);
}
//#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    if (SCREEN_INCH_4_0) {
//        return UIEdgeInsetsMake(0, 0, 0, 0);
//    }
//    if (SCREEN_INCH_4_7) {
//        return UIEdgeInsetsMake(0, 10, 0, 0);
//    }
//    if (SCREEN_INCH_5_5) {
//        return UIEdgeInsetsMake(0, 10, 0, 0);
//    }
    return UIEdgeInsetsMake(0, 0, 0, 0);//（上、左//(KSCREEN_WIDTH-20-SortTypeCellLen*5-4*10)/2、下、右）
}
//#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    if (SCREEN_INCH_5_5) {
//        return 3;
//    }
    return 0;
}
//#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}





@end
