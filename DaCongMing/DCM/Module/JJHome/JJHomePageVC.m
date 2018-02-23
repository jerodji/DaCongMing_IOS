//
//  JJHomePageVC.m
//  DaCongMing
//
//  Created by hailin on 2018/1/18.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "JJHomePageVC.h"
#import "SDCycleScrollView.h"

#import "JJSearchController.h"
#import "JJTableController.h"

@interface JJHomePageVC ()<SDCycleScrollViewDelegate,JJTableScrollDelegate>
{
    UIView              * _headView;
    SDCycleScrollView   * _sdcyclesView;
    CGFloat border_top_y ; //上边界
    CGFloat border_btm_y ; //下边界
//    BOOL    IS_NEWY_EQUAL_TOP;
}

@property (nonatomic, strong) UIView * statusBarView;
@property (nonatomic, strong) JJSearchController * searchCtrl;
@property (nonatomic, strong) JJTableController * tableCtrl;

@property (nonatomic, assign) CGRect rect;

@property (nonatomic,strong) NSMutableArray* bannerImages;
@property (nonatomic,strong) NSMutableArray* bannerJumpUrls;
@end

@implementation JJHomePageVC

/**
 * 状态栏颜色
 */
- (void)configStatusWithBackcolor:(UIColor*)color {
    if (!_statusBarView) {
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -([[UIApplication sharedApplication] statusBarFrame].size.height), [UIScreen mainScreen].bounds.size.width, [[UIApplication sharedApplication] statusBarFrame].size.height)];
        [self.navigationController.navigationBar addSubview:_statusBarView];
    }
    _statusBarView.backgroundColor = color;//KAPP_NAV_COLOR;
    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;/* UIStatusBarStyleDefault 黑色 UIStatusBarStyleLightContent白色 */
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    _bannerImages = [[NSMutableArray alloc] init];
    _bannerJumpUrls = [[NSMutableArray alloc] init];
    border_top_y = -KNAV_HEIGHT + KSTATUSBAR_HEIGHT; /* 上边界 */
    border_btm_y = -KNAV_HEIGHT + HeightNewBanner;   /* 下边界 */
    
    [self configStatusWithBackcolor:[UIColor clearColor]];
    [self configTableList];
    [self configSearchBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /* 取消自动调整滚动视图的间距  UIViewController + Nav 会自动调整tabview的contentinset
     self.automaticallyAdjustsScrollViewInsets = NO; */
    [self setupNaviAlpha:YES];
    [self.searchCtrl searchBarShow];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setupNaviAlpha:NO];
    [self.searchCtrl searchBarHidden];
    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色  UIStatusBarStyleDefault;//黑色
}

#pragma mark- addsubview

- (void)addSubviews {
    [self.view addSubview:_headView];
    [self.view addSubview:self.tableCtrl.tableView];
    [self.navigationController.view addSubview:self.searchCtrl.searchBar];
}

#pragma mark - searchBar

- (void)configSearchBar {
    self.searchCtrl = [[JJSearchController alloc] init];
    self.searchCtrl.searchBar.frame = CGRectMake(25, KSTATUSBAR_HEIGHT+8, KSCREEN_WIDTH - 25*2, 29);
//    [self.view addSubview:self.searchCtrl.searchBar];
}

#pragma mark  table
- (void)configTableList
{
     __weak typeof(self) wkself = self;
    _rect = CGRectMake(0, -KNAV_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT - KSTATUSBAR_HEIGHT - KTABBAR_HEIGHT);
    self.tableCtrl = [[JJTableController alloc] initWithFrame:_rect];
    self.tableCtrl.scrollDelegate = self;
//    self.tableCtrl.scrolCB = ^(UIScrollView* scrollView){
//        [wkself setupTableViewFrameWith:scrollView];
//    };
    self.tableCtrl.typeCB = ^(NSArray* NewBannerList) {

        wkself.rect = CGRectMake(0, -KNAV_HEIGHT+HeightNewBanner, KSCREEN_WIDTH, KSCREEN_HEIGHT - KSTATUSBAR_HEIGHT - KTABBAR_HEIGHT);
        wkself.tableCtrl.tableView.frame = wkself.rect;
        
        for (int i=0; i<NewBannerList.count; i++) {
            [wkself.bannerImages addObject:[NewBannerList[i] objectForKey:@"imageUrl"]];
            [wkself.bannerJumpUrls addObject:[NewBannerList[i] objectForKey:@"jumpUrl"]];
        }
        
        [wkself configNewBanner:NewBannerList];
        [wkself addSubviews];
    };
    [self.tableCtrl fetchData];

    //添加手势
//    [self.tableCtrl.tableView.panGestureRecognizer addTarget:self action:@selector(panAction:)];
}

#pragma mark - new banner
//scrollDidscroll
//- (void)setupTableViewFrameWith:(UIScrollView*)scrollView
- (void)tableScrollDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top; /* contentoffset.y 是一个负值    contentInset.top 是一个正值。 符号相反 */
    //NSLog(@"offset --->  %f",offset);
    __block CGFloat newY = _tableCtrl.tableView.frame.origin.y - offset;
    
    if (offset <= 0) /* 下 */
    {
        _tableCtrl.tableView.backgroundColor = [UIColor whiteColor];
        if ( (border_top_y < newY)&&(newY < border_btm_y) ) {
//        if ( border_top_y < newY ) {
//            _tableCtrl.tableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
                _tableCtrl.tableView.y = newY;// newY
            
            if (newY >= (-KNAV_HEIGHT + KSTATUSBAR_HEIGHT) ) {
                [self configStatusWithBackcolor:[UIColor clearColor]];
            }
        } else {
            if (newY > border_btm_y) {
                _tableCtrl.tableView.backgroundColor = [UIColor clearColor];
                _tableCtrl.tableView.hm_y = border_btm_y;
                _sdcyclesView.hm_height = HeightNewBanner - offset; /* 放大, 正减负 等于正加正 */
            }
        }
    }
    else /* offset > 0 上 */
    {
        _tableCtrl.tableView.backgroundColor = [UIColor whiteColor];
        //CGFloat newY = (_tableCtrl.tableView.y-offset);
        //offset = offset/10000.0f;
        if (newY > border_top_y) {
            _tableCtrl.tableView.contentOffset = CGPointMake(0, 0);
            _tableCtrl.tableView.y = newY;
        }else {
            _tableCtrl.tableView.y = border_top_y;
            [self configStatusWithBackcolor:KAPP_NAV_COLOR];
        }
    }

}

- (void)tableScrollWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)tableScrollWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    /**
     * S = vt - (at^2)/2  匀减速运动公式
     */
    CGFloat S = fabs(scrollView.contentOffset.y);
    __block CGFloat v = velocity.y; /* 初速度 */
    CGFloat t = 0.02;       /* 单位时间 */
    CGFloat a = 2;         /* 减速度 */
    NSLog(@"v %f",v);
    if (fabs(v) < a) {
        return;
    }
    if (v < 0) { /* 下滑 */
        
        
        
//            v = v + a; // 负加正 -> 0
//            if (v >= 0) {
//
//                return ;
//            }
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                _tableCtrl.tableView.y = _tableCtrl.tableView.y - v*t;
//                NSLog(@"%f",_tableCtrl.tableView.y);
//            });
        
        
    } else { /* v<0 上滑 */
        
    }
}

- (void)tableScrollDidEndDragging:(UIScrollView *)scrollView {
    
}

-(void)panAction:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender translationInView:sender.view]; /* 获取手势一点的点 */
    CGFloat offset = self.tableCtrl.tableView.contentOffset.y + self.tableCtrl.tableView.contentInset.top; /* contentoffset.y 是一个负值    contentInset.top 是一个正值。 符号相反 */
    CGFloat newY = (_tableCtrl.tableView.y-offset);
//    if (newY <= border_top_y ) {
//        newY = border_top_y;
//    }
//    if (newY >= border_btm_y) {
//        newY = border_btm_y;
//    }
    NSLog(@"---->  %f",offset);
    
//
//    self.tableCtrl.tableView.y =  HeightNewBanner - offset;
//    self.tableCtrl.tableView.contentOffset = CGPointZero;
//    if (self.tableCtrl.tableView.y < border_top_y) {
//        self.tableCtrl.tableView.y = border_top_y;
//    }
//    if (self.tableCtrl.tableView.y > border_btm_y) {
//        self.tableCtrl.tableView.y = border_btm_y;
//    }
    
//    if ((border_top_y < sender.view.y) && (sender.view.y < border_btm_y)) {
        /* newY > border_top_y */
//        [UIView animateWithDuration:1.0 animations:^{
//            _tableCtrl.tableView.hm_y = border_top_y;
//        }];
//        sender.view.transform = CGAffineTransformTranslate(sender.view.transform, 0, point.y);
//        [sender setTranslation:CGPointZero inView:sender.view]; /* 重置 */
//    }
    
    

}

- (void)configNewBanner:(NSArray*)NewBannerList {
    //创建一个视图
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, -KNAV_HEIGHT, KSCREEN_WIDTH, HeightNewBanner)];
        _headView.backgroundColor = [UIColor clearColor];
        //_headView.userInteractionEnabled = NO;
//        [self.view addSubview:_headView];
        
        if (!_sdcyclesView)
        {
            _sdcyclesView = [SDCycleScrollView cycleScrollViewWithFrame:_headView.bounds imageURLStringsGroup:_bannerImages];
            _sdcyclesView.delegate = self;
            _sdcyclesView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
            _sdcyclesView.showPageControl = YES;
            _sdcyclesView.titleLabelHeight = 0;
            _sdcyclesView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
            _sdcyclesView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
            _sdcyclesView.autoScrollTimeInterval = NewBannerCycleTime; // 自定义轮播时间间隔
            //_sdcyclesView.backgroundColor = [UIColor redColor];
            [_headView addSubview:_sdcyclesView];
        }
    }
}



#pragma mark- /** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSString* jumpUrl = _bannerJumpUrls[index] ;
    NSLog(@"%@",jumpUrl);
    [DCURLRouter pushURLString:jumpUrl animated:YES];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

#pragma mark -

- (void)setupNaviAlpha:(BOOL)isAlpha {
    if (isAlpha) {
        //translucent为YES,设置导航栏背景图片为一个空的image，这样就透明了
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        //去掉透明后导航栏下边的黑边
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        return;
    }
    //如果不想让其他页面的导航栏变为透明 需要重置
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
