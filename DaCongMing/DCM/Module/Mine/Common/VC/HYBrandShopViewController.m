
//
//  HYBrandShopViewController.m
//  DaCongMing
//
//

#import "HYBrandShopViewController.h"
#import "HYBrandShopNavView.h"
#import "HYBrandShopHeaderView.h"

#import "HYShopCollectCell.h"
#import "HYShopImageCell.h"
#import "HYHomeBannerCell.h"
#import "HYHomeDoodsCell.h"
#import "HYBrandShopInfoModel.h"
#import "HYGoodsItemCollectionViewCell.h"
#import "HYSearchNoDataCollectionReusableView.h"
#import "HYGoodsDetailInfoViewController.h"
#import "HYBrandShopBottomView.h"
#import "HYShareView.h"
#import "HYSearchHandle.h"
#import "HYBrandShopImageCell.h"


@interface HYBrandShopViewController () <UITableViewDelegate,UITableViewDataSource,HYBrandsShopTapDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** brandsShopNavView */
@property (nonatomic,strong) HYBrandShopNavView *brandsShopNavView;
/** header */
@property (nonatomic,strong) HYBrandShopHeaderView *headerView;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** cell信息 */
@property (nonatomic,strong) NSMutableArray *cellInfoArray;
/** itemList */
@property (nonatomic,strong) NSMutableArray *itemList;
/** infoModel */
@property (nonatomic,strong) HYBrandShopInfoModel *shopInfoModel;
/** share */
@property (nonatomic,strong) HYShareView *shareView;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** 搜索结果 */
@property (nonatomic,strong) NSMutableArray *datalist;
/** 是否搜到数据 */
@property (nonatomic,assign) BOOL isNoData;
/** 分页页面 */
@property (nonatomic,assign) NSInteger pageNo;

@end

@implementation HYBrandShopViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"接收的参数%@", self.params);
    if (NotNull(self.params[@"id"])) {
        self.sellerID = self.params[@"id"];
    }

    [self setupUI];
    [self requestNetwork];
    
    KAdjustsScrollViewInsets_NO(self, self.tableView);
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [self setupUI];
}

- (void)setupUI{
    
    [self.navigationController.navigationBar addSubview:self.brandsShopNavView];
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.tableView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_brandsShopNavView removeFromSuperview];
    _brandsShopNavView = nil;
}

- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - network
- (void)requestNetwork{
    
    [self.itemList removeAllObjects];
    [HYGoodsHandle getBrandsShopWithSellerID:self.sellerID ComplectionBlock:^(NSDictionary *dict) {
       
        if (dict){
            
            self.shopInfoModel = [HYBrandShopInfoModel modelWithDictionary:dict];
            NSArray *itemList = [dict objectForKey:@"itemList"];
            [self.itemList addObjectsFromArray:itemList];
            self.headerView.storeInfo = self.shopInfoModel.storeInfo;
        }
        
        [self.tableView reloadData];
        
    }];
//    [self.tableView reloadData];
}

- (void)requestRecommendData{
    
    [self.datalist removeAllObjects];
    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 sortType:@"0" keyword:nil complectionBlock:^(NSArray *datalist)  {
        
        [self.datalist addObjectsFromArray:datalist];
        [self.collectionView reloadData];
    }];
}

- (void)requestDataWithType:(NSInteger)type{
    
    _pageNo = 1;
    [self.itemList removeAllObjects];
    [HYGoodsHandle getBrandsShopProductWithSeller:self.sellerID Type:type pageNo:_pageNo ComplectionBlock:^(NSArray *datalist) {
       
        [self.itemList addObjectsFromArray:datalist];
        [self.tableView reloadData];
        [_tableView.mj_footer endRefreshing];
    }];
}

- (void)reloadDataMoret {
    
    _pageNo++;
    [HYGoodsHandle getBrandsShopProductWithSeller:self.sellerID Type:self.topItem pageNo:_pageNo ComplectionBlock:^(NSArray *datalist) {
        
        [self.itemList addObjectsFromArray:datalist];
        if (datalist.count) {

            [_tableView.mj_footer endRefreshing];
        }
        else{
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.shopInfoModel.storeInfo.storeAdvertisingMaps.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *brandShopImageCell = @"brandShopImageCell";
        HYBrandShopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:brandShopImageCell];
        if (!cell) {
            cell = [[HYBrandShopImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:brandShopImageCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        HYBrandShopRecommendModel *model = [HYBrandShopRecommendModel modelWithDictionary:self.shopInfoModel.storeInfo.storeAdvertisingMaps[indexPath.row]];
        cell.model = model;
        
        if (self.topItem != HYBrandShopTopItemHome) {
            
            cell.hidden = YES;
        }
        else{
            cell.hidden = NO;
        }
        return cell;
    }
    else if(indexPath.section == 1){
        
        //猜你喜欢
        static NSString *goodsCellID = @"goodsCellID";
        HYHomeDoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCellID];
        if (!cell) {
            cell = [[HYHomeDoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.datalist = self.itemList ;
        //cell.collectionView.height = ceil(self.itemList.count / 2.0) * 287 * WIDTH_MULTIPLE;
        cell.collectionSelect = ^(NSString *productID) {
            
            HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
            detailVC.navigationController.navigationBar.hidden = YES;
            detailVC.goodsID = productID;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        [cell.collectionView reloadData];
//        [cell setNeedsLayout];
        return cell;
    }
    static NSString *cellID = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

#pragma mark  tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HYBrandShopImageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
        detailVC.navigationController.navigationBar.hidden = YES;
        detailVC.goodsID = cell.model.item_id;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (self.topItem != HYBrandShopTopItemHome) {
            
            return 0;
        }
        return 180 * WIDTH_MULTIPLE;
    }
    
    if (indexPath.section == 1){
        
        //猜你喜欢
        CGFloat height = ceil(self.itemList.count / 2.0) * 287 * WIDTH_MULTIPLE; //330 ??
        return height;
    }
    return 10;
}

#pragma mark - BrandsNavDelegate
- (void)brandsShopNavBtnTapIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            
            break;
        case 2:
            
            [KEYWINDOW addSubview:self.shareView];
            [self.shareView showShareView];
            break;
        default:
            break;
    }
}

#pragma mark - searchDelegate
- (void)searchTextFieldTextChanged:(NSString *)text{
    
    [self.datalist removeAllObjects];
    [self.view addSubview:self.collectionView];
    [HYSearchHandle searchProductsInShop:self.sellerID WithText:text complectionBlock:^(NSArray *datalist) {
        
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
    
        
    [_collectionView removeFromSuperview];
    _collectionView = nil;
    [self.view addSubview:self.tableView];

}

- (void)searchTextFieldStartInput{
    
    [_tableView removeFromSuperview];
    _tableView = nil;
    [self.view addSubview:self.collectionView];
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
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = _datalist[indexPath.item];
    HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:dict];
    
    NSLog(@"current itemID is %@",model.item_id);
    
    
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



#pragma mark - lazyload
- (HYBrandShopNavView *)brandsShopNavView{
    
    if (!_brandsShopNavView) {
        
        _brandsShopNavView = [[HYBrandShopNavView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
        _brandsShopNavView.delegate = self;
    }
    return _brandsShopNavView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KCOLOR(@"f6f6f6");
        _tableView.tableHeaderView = self.headerView;
/**
  这个应该是UITableView最大的改变。我们知道在iOS8引入Self-Sizing 之后，我们可以通过实现estimatedRowHeight相关的属性来展示动态的内容，实现了estimatedRowHeight属性后，得到的初始contenSize是个估算值，是通过estimatedRowHeight 乘以 cell的个数得到的，并不是最终的contenSize，只是当前屏幕能够显示的cell个数，滑动时，tableView不停地得到新的cell，更新自己的contenSize。
 Self-Sizing在iOS11下是默认开启的，Headers, footers, and cells都默认开启Self-Sizing，所有estimated 高度默认值从iOS11之前的 0 改变为UITableViewAutomaticDimension：
 如果目前项目中没有使用estimateRowHeight属性，在iOS11的环境下就要注意了，因为开启Self-Sizing之后，tableView是使用estimateRowHeight属性的，这样就会造成contentSize和contentOffset值的变化，如果是有动画是观察这两个属性的变化进行的，就会造成动画的异常，因为在估算行高机制下，contentSize的值是一点点地变化更新的，所有cell显示完后才是最终的contentSize值。因为不会缓存正确的行高，tableView reloadData的时候，会重新计算contentSize，就有可能会引起contentOffset的变化。
 iOS11下不想使用Self-Sizing的话，可以通过以下方式关闭://添加以下代码
*/
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadDataMoret)];
        _tableView.mj_footer.automaticallyHidden = YES;
    }
    return _tableView;
}


- (HYBrandShopHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[HYBrandShopHeaderView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 160 * WIDTH_MULTIPLE)];
        __weak typeof (self)weakSelf = self;
        _headerView.topBtnSelectBlock = ^(NSInteger tag) {
            weakSelf.topItem = tag;
            if (tag == 0) {
                
                [weakSelf requestNetwork];
                return;
            }
            [weakSelf requestDataWithType:tag];
        };
    }
    return _headerView;
}

- (HYShareView *)shareView{
    
    if (!_shareView) {
        
        _shareView = [[HYShareView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        
    }
    return _shareView;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(KSCREEN_WIDTH / 2 - 10, 340 * WIDTH_MULTIPLE);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 6 * WIDTH_MULTIPLE;      //纵向间距
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 6 * WIDTH_MULTIPLE, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNAV_HEIGHT) collectionViewLayout:layout];
        [_collectionView setCollectionViewLayout:layout];
        _collectionView.backgroundColor = KAPP_TableView_BgColor;
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

- (NSMutableArray *)cellInfoArray{
    
    if (!_cellInfoArray) {
        _cellInfoArray = [NSMutableArray array];
    }
    return _cellInfoArray;
}

- (NSMutableArray *)itemList{
    
    if (!_itemList) {
        _itemList = [NSMutableArray array];
    }
    return _itemList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
