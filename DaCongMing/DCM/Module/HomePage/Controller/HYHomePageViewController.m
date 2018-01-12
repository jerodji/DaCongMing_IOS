//
//  HYHomePageViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomePageViewController.h"
#import "HYGoodsDetailInfoViewController.h"
#import "HYHomeSearchViewController.h"
#import "HYGoodsListViewController.h"
#import "HYBrandShopViewController.h"

#import "HYHomeViewModel.h"
#import "HYHomeHeaderView.h"
#import "HYHomeTextHeaderView.h"
#import "HYProductCategoryCell.h"
#import "HYHomeBannerModel.h"

@interface HYHomePageViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *bannerModelArray;
@property (nonatomic,assign) BOOL isExpand;

@end

static NSString *homeBannerCellID = @"homeBannerCellID";
static NSString *titleHeaderCellID = @"titleHeaderCellID";
static NSString *productCategoryCellID = @"productCategoryCellID";

@implementation HYHomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self requestRecommendData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - setStatusBar
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (void)viewDidLayoutSubviews{
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
}


//- (void)setupCellData{
//
//    _cellInfoArray = [NSMutableArray array];
//    //将cell放入数组(indexPath其实就是个二维数组)中，然后根据数组中来判断
//    [_cellInfoArray addObject:@[@"HYHomeCollectionCell"]];
//    [_cellInfoArray addObject:@[@"HYHomeTitleScrollCell"]];
//    [_cellInfoArray addObject:@[@"HYOrderDetailImageCell"]];
//    [_cellInfoArray addObject:@[@"HYTypeRecommendCell"]];
//    [_cellInfoArray addObject:@[@"HYHomeDoodsCell"]];
//}

#pragma mark - network
- (void)requestNetwork{
    
    //先从缓存中取
    if ([HYPlistTools isFileExistWithFileName:[NSString stringWithFormat:@"%@.data",KHomePageDataModel]]) {
        
        
    }
    
    [HYHomeViewModel requestHomePageData:^(HYHomePageModel *model) {
        
        
    } failureBlock:^{
        
    }];
    
    
}

- (void)requestRecommendData{
    
    
}

- (void)updateHomeData{
    
    [HYHomeViewModel requestHomePageData:^(HYHomePageModel *model) {
        
        
        
        //删掉本地的model
        [HYPlistTools removeDataWithName:[NSString stringWithFormat:@"%@.data",KHomePageDataModel]];
        //存入plist
        [HYPlistTools archiveObject:model withName:[NSString stringWithFormat:@"%@.data",KHomePageDataModel]];
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"刷新数据成功"];
    } failureBlock:^{
        
        //停止刷新
    }];
}

#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        if (self.isExpand) {
            
            return 12;
        }
        return 5;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        HYProductCategoryCell *productCategoryCell = [collectionView dequeueReusableCellWithReuseIdentifier:productCategoryCellID forIndexPath:indexPath];
        return productCategoryCell;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HYHomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:homeBannerCellID forIndexPath:indexPath];
        headerView.bannerModelArray = self.bannerModelArray;
        return headerView;
    }
    else{
        
        HYHomeTextHeaderView *textHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:titleHeaderCellID forIndexPath:indexPath];
        return textHeaderView;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGSizeMake(KSCREEN_WIDTH, 220 * WIDTH_MULTIPLE);
    }
    return CGSizeMake(KSCREEN_WIDTH, 40 * WIDTH_MULTIPLE);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        CGFloat margin = 8 * WIDTH_MULTIPLE;
        CGFloat itemWidth = (KSCREEN_WIDTH - margin * 6) / 5;
        return CGSizeMake(itemWidth, itemWidth);
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (section == 0) {
        
        return UIEdgeInsetsMake(0, 0, 30 * WIDTH_MULTIPLE, 0);
    }
    return UIEdgeInsetsMake(10 * WIDTH_MULTIPLE, 5 * WIDTH_MULTIPLE, 20 * WIDTH_MULTIPLE, 5 * WIDTH_MULTIPLE);
}

#pragma mark - CollectionViewDeleagate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        if (indexPath.item == 4) {
            
            self.isExpand = !self.isExpand;
            // 去掉刷新时的动画
            [UIView animateWithDuration:0 animations:^{
                [collectionView performBatchUpdates:^{
                    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
                } completion: nil];
            }];
            
        }
    }
}

#pragma mark - lazyload
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
//        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 5 * WIDTH_MULTIPLE;
        layout.minimumLineSpacing = 10 * WIDTH_MULTIPLE;      //纵向间距
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = KAPP_WHITE_COLOR;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = YES;
        [_collectionView registerClass:[HYHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:homeBannerCellID];
        [_collectionView registerClass:[HYHomeTextHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:titleHeaderCellID];
        [_collectionView registerClass:[HYProductCategoryCell class] forCellWithReuseIdentifier:productCategoryCellID];
//        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadDataMore)];
//        _collectionView.mj_footer = footer;
    }
    return _collectionView;
}

- (NSMutableArray *)bannerModelArray{
    
    if (!_bannerModelArray) {
        
        _bannerModelArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 4; i++) {
            
            HYHomeBannerModel *model = [HYHomeBannerModel new];
            model.imgUrl = @"http://pic.laopdr.cn:80/menu_image/banner_image/banjia2.png";
            [_bannerModelArray addObject:model];
        }
    }
    return _bannerModelArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
