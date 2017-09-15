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
- (UIView *)headerView{
    
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
    
    NSLog(@"xxx");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"ggg");
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //纯图片的cell
        
        static NSString *cellID = @"HYImgCell";
        HYHomeImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[HYHomeImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.imgUrl = _model.disCount.image_url;
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString *cellID = @"HYTitle";
        HYHomeTitleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[HYHomeTitleScrollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.model = _model;
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
        
        return 170 * WIDTH_MULTIPLE;
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 49) style:UITableViewStylePlain];
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
