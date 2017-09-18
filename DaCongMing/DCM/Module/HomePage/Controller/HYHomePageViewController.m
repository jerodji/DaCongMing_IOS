//
//  HYHomePageViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomePageViewController.h"

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

@interface HYHomePageViewController () <UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

/** 导航栏 */
@property (nonatomic,strong) HYNavTitleView *navTitleView;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** headerView */
@property (nonatomic,strong) SDCycleScrollView *headerView;
/** model */
@property (nonatomic,strong) HYHomePageModel *model;

@end

@implementation HYHomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupUI];
    
    [self requestNetwork];
}

- (void)setupUI{
    
    [self.navigationController.navigationBar addSubview:self.navTitleView];
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.tableView];

}

- (void)requestNetwork{
    
    [HYHomeViewModel requestHomePageData:^(HYHomePageModel *model) {
        
        _headerView.imageURLStringsGroup = model.banners;
        _model = model;
        [self.tableView reloadData];
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
            cell = [[HYHomeImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imgCellID];
        }
        cell.imgUrl = _model.disCount.image_url;
        return cell;
    }
    else if (indexPath.row == 1){
        //今日推荐
        static NSString *titleScrollID = @"HYTitle";
        HYHomeTitleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:titleScrollID];
        if (!cell) {
            cell = [[HYHomeTitleScrollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleScrollID];
        }
        cell.model = _model;
        return cell;
    }
    else if (indexPath.row == 2){
        //健康养生
        static NSString *imageScrollID = @"HYImageScroll";
        HYHomeImgScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:imageScrollID];
        if (!cell) {
            cell = [[HYHomeImgScrollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageScrollID];
        }
        cell.goodHealthModel = _model.goodHealth;
        return cell;
    }
    else if (indexPath.row == 3){
        //item
        static NSString *collectionCellID = @"HYCollectionCell";
        HYHomeCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionCellID];
        if (!cell) {
            cell = [[HYHomeCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collectionCellID];
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
        }
        cell.model = _model;
        return cell;
    }
    else if (indexPath.row == 6){
        //猜你喜欢
        static NSString *typeRecommendID = @"typeRecommendID";
        HYHomeDoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:typeRecommendID];
        if (!cell) {
            cell = [[HYHomeDoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:typeRecommendID];
        }
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
        
        return 150;
    }
    else if(indexPath.row == 1) {
        
        //今日推荐
        return 76 +  (170 + 30) * WIDTH_MULTIPLE;
    }
    else if(indexPath.row == 2) {
        
        //健康养生
        return 150 + (170 + 30) * WIDTH_MULTIPLE;
    }
    else if(indexPath.row == 3) {
        
        //tags
        return 20 + _model.tags.count / 2 * 110 + 10;
    }
    else if(indexPath.row == 4) {
        
        //banner
        return 170;
    }
    else if(indexPath.row == 5) {
        
        //推荐
        return 90 + 10;
    }
    else if(indexPath.row == 6) {
        
        //猜你喜欢
        return 40 + 10;
    }
    
    return 100;
}

#pragma mark - lazyload
- (HYNavTitleView *)navTitleView{

    if (!_navTitleView) {
        
        _navTitleView = [[HYNavTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
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
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
