//
//  HYHomeSearchViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeSearchViewController.h"
#import "HYSearchTitleView.h"
#import "HYHotSearchView.h"
#import "HYSearchHandle.h"
#import "HYGoodsItemCollectionViewCell.h"
#import "HYSearchNoDataCollectionReusableView.h"
#import "HYGoodsDetailInfoViewController.h"

@interface HYHomeSearchViewController () <HYSearchTextFieldTextChangedDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HYHotSearchBtnActionDelegate>

/** searchTitleView */
@property (nonatomic,strong) HYSearchTitleView *searchTitleView;
/** hotSearchView */
@property (nonatomic,strong) HYHotSearchView *hotSearchView;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** 搜索结果 */
@property (nonatomic,strong) NSMutableArray *datalist;
/** 是否搜到数据 */
@property (nonatomic,assign) BOOL isNoData;

@end

@implementation HYHomeSearchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = KAPP_WHITE_COLOR;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setupUI];
}

- (void)setupUI{
    
    [self.navigationController.navigationBar addSubview:self.searchTitleView];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.hotSearchView];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_searchTitleView removeFromSuperview];
    _searchTitleView = nil;
}

- (void)viewWillLayoutSubviews{
    
    [_hotSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(150 * WIDTH_MULTIPLE));
    }];
}

- (void)requestRecommendData{
    
    [self.datalist removeAllObjects];
    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 andPage:5 order:nil hotsale:nil complectionBlock:^(NSArray *datalist) {
        
        [self.datalist addObjectsFromArray:datalist];
        [self.collectionView reloadData];
    }];
}


#pragma mark - searchDelegate
- (void)searchTextFieldTextChanged:(NSString *)text{
    
    [self.datalist removeAllObjects];
    [self.view addSubview:self.collectionView];
    [HYSearchHandle searchProductsWithText:text complectionBlock:^(NSArray *datalist) {
       
        if (datalist.count) {
            
            [self.datalist addObjectsFromArray:datalist];
            [_collectionView reloadData];
            self.isNoData = NO;
        }
        else{
            
            [self requestRecommendData];
            self.isNoData = YES;
        }
        
    }];
}

- (void)searchTextFieldResignFirstResponder{
    
    if (!self.datalist.count) {
       
        [_collectionView removeFromSuperview];
        _collectionView = nil;
        [self.view addSubview:self.hotSearchView];
    }

}

- (void)searchTextFieldStartInput{
    
    [_hotSearchView removeFromSuperview];
    _hotSearchView = nil;
    [self.view addSubview:self.collectionView];
}

#pragma mark - 点击热搜按钮delegate
- (void)hotSearchBtnTapWithText:(NSString *)text{
    
    [self.searchTitleView.textField becomeFirstResponder];
    self.searchTitleView.textField.text = text;
    [self searchTextFieldTextChanged:text];
}

#pragma mark - collectionViewDataSource
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYGoodsItemCollectionViewCell *cell = (HYGoodsItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    NSDictionary *dict = _datalist[indexPath.item];
    cell.goodsModel = [HYGoodsItemModel modelWithDictionary:dict];
    //cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((KSCREEN_WIDTH - 10) / 2, 340 * WIDTH_MULTIPLE);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = _datalist[indexPath.item];
    HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:dict];
    
    DLog(@"current itemID is %@",model.item_id);
    
    
    HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
    detailVC.navigationController.navigationBar.hidden = YES;
    detailVC.goodsID = model.item_id;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark - collectionHeader
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        HYSearchNoDataCollectionReusableView *headerView = (HYSearchNoDataCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYSearchNoDataHeaderView" forIndexPath:indexPath];
        return headerView;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (self.isNoData) {
        
        return CGSizeMake(KSCREEN_WIDTH, 115 * WIDTH_MULTIPLE);
    }
    
    return CGSizeMake(0, 0);
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 50) {
        
        [self.searchTitleView.textField resignFirstResponder];
    }
    else{
        
        [self.searchTitleView.textField becomeFirstResponder];
    }
}

#pragma mark - lazyload
- (HYSearchTitleView *)searchTitleView{
    
    if (!_searchTitleView) {
        
        _searchTitleView = [[HYSearchTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
        _searchTitleView.delegate = self;
        __weak typeof (self)weakSelf = self;
        _searchTitleView.cancenBlock = ^{
          
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _searchTitleView;
}

- (HYHotSearchView *)hotSearchView{
    
    if (!_hotSearchView) {
        
        _hotSearchView = [HYHotSearchView new];
        _hotSearchView.delegate = self;
    }
    return _hotSearchView;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-64) collectionViewLayout:layout];
        [_collectionView setCollectionViewLayout:layout];
        _collectionView.backgroundColor = KAPP_WHITE_COLOR;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        
        [_collectionView registerClass:[HYGoodsItemCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
        [_collectionView registerClass:[HYSearchNoDataCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYSearchNoDataHeaderView"];
    }
    return _collectionView;
}

- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
