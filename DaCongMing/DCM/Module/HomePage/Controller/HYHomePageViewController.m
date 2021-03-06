//
//  HYHomePageViewController.m
//  DaCongMing
//
//

#import "HYHomePageViewController.h"
#import "HYGoodsDetailInfoViewController.h"
#import "HYHomeSearchViewController.h"

#import "HYNavTitleView.h"
#import "HYHomePageView.h"
#import "HYHomeViewModel.h"

#import "HYHomeImgCell.h"
#import "HYHomeTitleScrollCell.h"
#import "HYHomeImgScrollCell.h"
#import "HYHomeCollectionCell.h"
#import "HYHomeBannerCell.h"
#import "HYHomeDoodsCell.h"
#import "HYTypeRecommendCell.h"
#import "HYBannerModel.h"
#import "HYOrderDetailImageCell.h"

#import "HYGoodsListViewController.h"
#import "HYBrandShopViewController.h"


@interface HYHomePageViewController () <UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

/** 导航栏 */
@property (nonatomic,strong) HYNavTitleView *navTitleView;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** headerView */
@property (nonatomic,strong) SDCycleScrollView *headerView;
/** model */
@property (nonatomic,strong) HYHomePageModel *model;
/** 商品列表 */
@property (nonatomic,strong) NSMutableArray *goodsList;
/** bannerArray */
@property (nonatomic,strong) NSMutableArray *bannerArray;
/** 存放Cell的高度 */
@property (nonatomic,strong) NSMutableDictionary *cellHeightDict;
/** cell信息 */
@property (nonatomic,strong) NSMutableArray *cellInfoArray;

@end

@implementation HYHomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self requestRecommendData];
    
    
    NSLog(@"StatusBarHeight:%f",KSTATUSBAR_HEIGHT);
    NSLog(@"TabBarHeight:%d",KTABBAR_HEIGHT);
    NSLog(@"NavHeight:%f",KNAV_HEIGHT);
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    NSLog(@"ScreenHeight:%f",KSCREEN_HEIGHT);
    NSLog(@"DBL_EPSILON:%f",DBL_EPSILON);
    
}

- (void)viewSafeAreaInsetsDidChange{
    
    [super viewSafeAreaInsetsDidChange];
    NSLog(@"safeAreaInsets:%@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    NSLog(@"additionalSafeAreaInsets:%@",NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets));
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setupCellData];
    [self setupUI];
    
    if (!_model) {
        
        [self requestNetwork];
        [self requestRecommendData];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_navTitleView removeFromSuperview];
    _navTitleView = nil;
    
}

- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
}

- (void)setupUI{
    
    [self.navigationController.navigationBar addSubview:self.navTitleView];
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.tableView];
}

- (void)setupCellData{
    
    _cellInfoArray = [NSMutableArray array];
    //将cell放入数组(indexPath其实就是个二维数组)中，然后根据数组中来判断
    [_cellInfoArray addObject:@[@"HYHomeCollectionCell"]];
    [_cellInfoArray addObject:@[@"HYHomeTitleScrollCell"]];
    [_cellInfoArray addObject:@[@"HYOrderDetailImageCell"]];
    [_cellInfoArray addObject:@[@"HYTypeRecommendCell"]];
    [_cellInfoArray addObject:@[@"HYHomeDoodsCell"]];

    
}

#pragma mark - network
- (void)requestNetwork{
    
    //先从缓存中取
    if ([HYPlistTools isFileExistWithFileName:[NSString stringWithFormat:@"%@.data",KHomePageDataModel]]) {
        
        HYHomePageModel *model = [HYPlistTools unarchivewithName:[NSString stringWithFormat:@"%@.data",KHomePageDataModel]];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *bannerDict in model.banners) {
            
            HYBannerModel *bannerModel = [HYBannerModel modelWithDictionary:bannerDict];
            [self.bannerArray addObject:bannerModel];
            [tempArray addObject:bannerModel.banner_imgUrl];
        }
        _headerView.imageURLStringsGroup = tempArray;
        _model = model;
        [self.tableView reloadData];
        return;
    }
    
    [HYHomeViewModel requestHomePageData:^(HYHomePageModel *model) {
        
        NSMutableArray *tempArray = [NSMutableArray array];
        [self.bannerArray removeAllObjects];
        for (NSDictionary *bannerDict in model.banners) {
            
            HYBannerModel *bannerModel = [HYBannerModel modelWithDictionary:bannerDict];
            [self.bannerArray addObject:bannerModel];
            [tempArray addObject:bannerModel.banner_imgUrl];
        }
        _headerView.imageURLStringsGroup = tempArray;
        _model = model;
        
        //存入plist
        [HYPlistTools archiveObject:model withName:[NSString stringWithFormat:@"%@.data",KHomePageDataModel]];
        [self.tableView reloadData];
    } failureBlock:^{
        
    }];
    
    
}

- (void)requestRecommendData{
    
    _goodsList = [NSMutableArray array];

    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 sortType:@"0" keyword:nil complectionBlock:^(NSArray *datalist)  {
        
        [_goodsList addObjectsFromArray:datalist];
        [self.tableView reloadData];
    }];
}

- (void)updateHomeData{
    
    [HYHomeViewModel requestHomePageData:^(HYHomePageModel *model) {
        
        NSMutableArray *tempArray = [NSMutableArray array];
        [self.bannerArray removeAllObjects];
        for (NSDictionary *bannerDict in model.banners) {
            
            HYBannerModel *bannerModel = [HYBannerModel modelWithDictionary:bannerDict];
            [self.bannerArray addObject:bannerModel];
            [tempArray addObject:bannerModel.banner_imgUrl];
        }
        _headerView.imageURLStringsGroup = tempArray;
        _model = model;
        
        //删掉本地的model
        [HYPlistTools removeDataWithName:[NSString stringWithFormat:@"%@.data",KHomePageDataModel]];
        //存入plist
        [HYPlistTools archiveObject:model withName:[NSString stringWithFormat:@"%@.data",KHomePageDataModel]];
        [self.tableView reloadData];
        
        //停止刷新
        [_tableView.mj_header endRefreshing];
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"刷新数据成功"];
    } failureBlock:^{
        
        //停止刷新
        [_tableView.mj_header endRefreshing];
    }];
}


#pragma mark - bannerTapDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    HYBannerModel *bannerModel = self.bannerArray[index];
    switch ([bannerModel.transition integerValue]) {
        case 0:{
            
            HYBrandShopViewController *shopVC = [HYBrandShopViewController new];
            shopVC.sellerID = bannerModel.seller_id;
            [self.navigationController pushViewController:shopVC animated:YES];
        }
            break;
        case 1:{
            
            HYGoodsListViewController *goodListVC = [HYGoodsListViewController new];
            goodListVC.type = bannerModel.item_type;
            [self.navigationController pushViewController:goodListVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cellInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellName = self.cellInfoArray[indexPath.row][0];
    
    if ([cellName isEqualToString:@"HYHomeTitleScrollCell"]) {
       
        //今日推荐
        static NSString *titleScrollID = @"HYTitle";
        HYHomeTitleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:titleScrollID];
        if (!cell) {
            cell = [[HYHomeTitleScrollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleScrollID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.model = _model;
        [self.cellHeightDict setValue:[NSNumber numberWithFloat:cell.cellHeight] forKey:cellName];
        cell.collectionSelect = ^(NSString *productID) {
            
            HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
            detailVC.navigationController.navigationBar.hidden = YES;
            detailVC.goodsID = productID;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        return cell;
    }
    else if ([cellName isEqualToString:@"HYHomeCollectionCell"]){
        //item
        static NSString *collectionCellID = @"HYCollectionCell";
        HYHomeCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionCellID];
        if (!cell) {
            cell = [[HYHomeCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collectionCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.model = _model;
        cell.selectItemBlock = ^(NSString *itemType) {
            
            HYGoodsListViewController *goodListVC = [HYGoodsListViewController new];
            goodListVC.type = itemType;
            [self.navigationController pushViewController:goodListVC animated:YES];
        };
        return cell;
    }
    else if ([cellName isEqualToString:@"HYOrderDetailImageCell"]){
        //类型推荐图片
        static NSString *typeRecommendImageID = @"typeRecommendImageID";
        HYOrderDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:typeRecommendImageID];
        if (!cell) {
            cell = [[HYOrderDetailImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:typeRecommendImageID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        [cell.logisticsImgView sd_setImageWithURL:[NSURL URLWithString:_model.typeReCommend.image_url] placeholderImage:[UIImage imageNamed:@"banner.jpg"]];
        return cell;
    }
    else if ([cellName isEqualToString:@"HYTypeRecommendCell"]){
        //类型推荐
        static NSString *typeRecommendID = @"typeRecommendID";
        HYTypeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:typeRecommendID];
        if (!cell) {
            cell = [[HYTypeRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:typeRecommendID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.selectItemBlock = ^(NSString *keyword, NSString *typeID) {
          
            HYGoodsListViewController *goodsListVC = [[HYGoodsListViewController alloc] init];
            goodsListVC.keyword = keyword;
            goodsListVC.type = typeID;
            goodsListVC.title = keyword;
            [self.navigationController pushViewController:goodsListVC animated:YES];
        };
        cell.model = _model;
        
        return cell;
    }
    else if ([cellName isEqualToString:@"HYHomeDoodsCell"]){
        //猜你喜欢
        static NSString *goodsCellID = @"goodsCellID";
        HYHomeDoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCellID];
        if (!cell) {
            cell = [[HYHomeDoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.datalist = self.goodsList;
        cell.title = @"猜你喜欢";
        cell.collectionSelect = ^(NSString *productID) {
          
            HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
            detailVC.navigationController.navigationBar.hidden = YES;
            detailVC.goodsID = productID;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        return cell;
    }
    else{
        static NSString *cellID = @"";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
    
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellName = self.cellInfoArray[indexPath.row][0];
    if ([cellName isEqualToString:@"HYOrderDetailImageCell"]) {
        
        HYBrandShopViewController *shopVC = [HYBrandShopViewController new];
        shopVC.sellerID = self.model.typeReCommend.seller_id;
        [self.navigationController pushViewController:shopVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellName = self.cellInfoArray[indexPath.row][0];
    if ([cellName isEqualToString:@"HYHomeTitleScrollCell"]) {
        
        NSNumber *num = [_cellHeightDict objectForKey:cellName];
        return num.floatValue;
    }
    else if([cellName isEqualToString:@"HYHomeCollectionCell"]) {
        
        //四个方块
        return ceil(_model.tags.count / 2.0) * 110 * WIDTH_MULTIPLE + 10 * WIDTH_MULTIPLE;
    }
    else if([cellName isEqualToString:@"HYOrderDetailImageCell"]) {
        
        //图片
        return 170 * WIDTH_MULTIPLE;
    }
    else if([cellName isEqualToString:@"HYTypeRecommendCell"]) {
        
        //类型
        CGFloat itemWidth = (KSCREEN_WIDTH - 5 * 3) / 4;
        return itemWidth + 10 * WIDTH_MULTIPLE;
    }
    else if([cellName isEqualToString:@"HYHomeDoodsCell"]) {
        
        //猜你喜欢
        CGFloat height = ceil(_goodsList.count / 2.0) * KItemHeight ;
        return  height + 40 * WIDTH_MULTIPLE;
    }
    
    return 100;
}

#pragma mark - lazyload
- (HYNavTitleView *)navTitleView{

    if (!_navTitleView) {
        
        _navTitleView = [[HYNavTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
        _navTitleView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
           
            HYHomeSearchViewController *homeSearchVC = [HYHomeSearchViewController new];
            [self.navigationController pushViewController:homeSearchVC animated:YES];
        }];
        [_navTitleView addGestureRecognizer:tap];
        _navTitleView.backgroundColor = KAPP_NAV_COLOR;
    }
    
    return _navTitleView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateHomeData)];
    }
    return _tableView;
}

- (SDCycleScrollView *)headerView{
    
    if (!_headerView) {
        
        //轮播图
        _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 180) delegate:self placeholderImage:[UIImage imageNamed:@"banner.jpg"]];
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _headerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _headerView.autoScrollTimeInterval = 3;
        _headerView.pageDotColor = KAPP_WHITE_COLOR;
        _headerView.currentPageDotColor = KAPP_THEME_COLOR;
        _headerView.imageURLStringsGroup = _model.banners;
        _headerView.autoScroll = YES;
        _headerView.infiniteLoop = YES;
        _headerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _headerView;
}

- (NSMutableDictionary *)cellHeightDict{
    
    if (!_cellHeightDict) {
        
        _cellHeightDict = [NSMutableDictionary dictionary];
    }
    return _cellHeightDict;
}

- (NSMutableArray *)bannerArray{
    
    if (!_bannerArray) {
        
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
