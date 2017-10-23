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

@end

@implementation HYHomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self requestRecommendData];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
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

- (void)setupUI{
    
    [self.navigationController.navigationBar addSubview:self.navTitleView];
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.tableView];

}

#pragma mark - network
- (void)requestNetwork{
    
    //先从缓存中取
    if ([HYPlistTools isFileExistWithFileName:[NSString stringWithFormat:@"%@.data",KHomePageDataModel]]) {
        
        HYHomePageModel *model = [HYPlistTools unarchivewithName:[NSString stringWithFormat:@"%@.data",KHomePageDataModel]];
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

    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 andPage:5 order:nil hotsale:nil complectionBlock:^(NSArray *datalist) {
        
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

#pragma mark - lazyload
- (SDCycleScrollView *)headerView{
    
    if (!_headerView) {
        
        //轮播图
        _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 180) delegate:self placeholderImage:[UIImage imageNamed:@"banner.jpg"]];
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _headerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _headerView.autoScrollTimeInterval = 2;
        _headerView.pageDotColor = KAPP_THEME_COLOR;
        _headerView.imageURLStringsGroup = _model.banners;
        _headerView.autoScroll = YES;
        _headerView.infiniteLoop = YES;
        _headerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _headerView;
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //纯图片的cell
        
        static NSString *imgCellID = @"HYImgCell";
        HYHomeImgCell *cell = [tableView dequeueReusableCellWithIdentifier:imgCellID];
        if (!cell) {
            cell = [[HYHomeImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imgCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.imgUrl = _model.disCount.image_url;
        [self.cellHeightDict setValue:[NSNumber numberWithFloat:cell.cellHeight] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        return cell;
    }
    else if (indexPath.row == 1){
        //今日推荐
        static NSString *titleScrollID = @"HYTitle";
        HYHomeTitleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:titleScrollID];
        if (!cell) {
            cell = [[HYHomeTitleScrollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleScrollID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.model = _model;
        [self.cellHeightDict setValue:[NSNumber numberWithFloat:cell.cellHeight] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        cell.collectionSelect = ^(NSString *productID) {
            
            HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
            detailVC.navigationController.navigationBar.hidden = YES;
            detailVC.goodsID = productID;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        return cell;
    }
    else if (indexPath.row == 2){
        //健康养生
        static NSString *imageScrollID = @"HYImageScroll";
        HYHomeImgScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:imageScrollID];
        if (!cell) {
            cell = [[HYHomeImgScrollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageScrollID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.goodHealthModel = _model.goodHealth;
        [self.cellHeightDict setValue:[NSNumber numberWithFloat:cell.cellHeight] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        cell.collectionSelect = ^(NSString *productID) {
            
            HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
            detailVC.navigationController.navigationBar.hidden = YES;
            detailVC.goodsID = productID;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        return cell;
    }
    else if (indexPath.row == 3){
        //item
        static NSString *collectionCellID = @"HYCollectionCell";
        HYHomeCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionCellID];
        if (!cell) {
            cell = [[HYHomeCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collectionCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.model = _model;
        
        return cell;
    }
    else if (indexPath.row == 4){
        //banner
        static NSString *bannerID = @"HYBannerCell";
        HYHomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:bannerID];
        if (!cell) {
            cell = [[HYHomeBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bannerID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.model = _model;
        return cell;
    }
    else if (indexPath.row == 5){
        //类型推荐
        static NSString *typeRecommendID = @"typeRecommendID";
        HYTypeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:typeRecommendID];
        if (!cell) {
            cell = [[HYTypeRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:typeRecommendID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.model = _model;
        return cell;
    }
    else if (indexPath.row == 6){
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
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        NSNumber *num = [_cellHeightDict objectForKey:@"0"];
        if (isnan(num.floatValue) || num.floatValue == 0) {
            return 150 * WIDTH_MULTIPLE;
        }
        return num.floatValue;
    }
    else if(indexPath.row == 1) {
        
        //今日推荐
//        return 76 +  (170 + 30) * WIDTH_MULTIPLE;
        
        NSNumber *num = [_cellHeightDict objectForKey:@"1"];
        return num.floatValue;
    }
    else if(indexPath.row == 2) {
        
        //健康养生
//        return 150 + (170 + 30) * WIDTH_MULTIPLE;
        NSNumber *num = [_cellHeightDict objectForKey:@"2"];
        return num.floatValue;
    }
    else if(indexPath.row == 3) {
        
        //tags
        return ceil(_model.tags.count / 2.0) * 110 * WIDTH_MULTIPLE + 10 * WIDTH_MULTIPLE;
    }
    else if(indexPath.row == 4) {
        
        //banner
        return 170 * WIDTH_MULTIPLE;
    }
    else if(indexPath.row == 5) {
        
        //推荐
        CGFloat itemWidth = (KSCREEN_WIDTH - 5 * 3) / 4;
        return itemWidth + 10 * WIDTH_MULTIPLE;
    }
    else if(indexPath.row == 6) {
        
        //猜你喜欢
        CGFloat height = ceil(_goodsList.count / 2.0) * 350 * WIDTH_MULTIPLE;
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 49 - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateHomeData)];
    }
    return _tableView;
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
