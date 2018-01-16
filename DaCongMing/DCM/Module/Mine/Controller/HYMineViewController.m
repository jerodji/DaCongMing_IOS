//
//  HYMineViewController.m
//  DaCongMing
//
//

#import "HYMineViewController.h"
#import "HYGoodsDetailInfoViewController.h"

#import "HYMineHeaderView.h"
#import "HYInviteFriendsTableViewCell.h"
#import "HYOrderTableViewCell.h"
#import "HYMineInfoTableViewCell.h"
#import "HYHomeDoodsCell.h"

#import "HYLoginViewController.h"
#import "HYMyOrderViewController.h"
#import "HYMyAccountViewController.h"
#import "HYMyDisCouponViewController.h"
#import "HYMyAddressViewController.h"
#import "HYMyQRCodeViewController.h"
#import "HYFeedbackViewController.h"
#import "HYSystemMessageVC.h"

#import "HYMyCollectShopViewController.h"
#import "HYMyCollectGoodsViewController.h"
#import "HYRecentViewViewController.h"
#import "HYSaleAfterViewController.h"
#import "HYMyUserInfo.h"
#import "HYMineNetRequest.h"

@interface HYMineViewController ()<UITableViewDelegate,UITableViewDataSource,HYMineInfoBtnActionDelegate,HYMyOrderActionDelegate,HYMineHeaderTapDelegate>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *datalist;

/** header */
@property (nonatomic,strong) HYMineHeaderView *headerView;
/** 商品列表 */
@property (nonatomic,strong) NSMutableArray *goodsList;
/** 购物车数量 */
@property (nonatomic,strong) HYMyUserInfo *myUserInfo;
/** cell信息 */
@property (nonatomic,strong) NSMutableArray *cellInfoArray;

@end

@implementation HYMineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self requestNetwork];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if (@available(iOS 11.0, *)){
        
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    _headerView.user = [HYUserModel sharedInstance];
    [self requestMyUserInfo];
    [_tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)initUI{
    
    [self setupCellData];
    [self.view addSubview:self.tableView];
}

- (void)setupCellData{
    
    _cellInfoArray = [NSMutableArray array];
    //将cell放入数组(indexPath其实就是个二维数组)中，然后根据数组中来判断
    [_cellInfoArray addObject:@[@"HYOrderTableViewCell"]];
    [_cellInfoArray addObject:@[@"HYMineInfoTableViewCell"]];
    [_cellInfoArray addObject:@[@"HYHomeDoodsCell"]];
    
    
}

- (void)requestNetwork{

    _goodsList = [NSMutableArray array];
    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 sortType:@"0" keyword:nil complectionBlock:^(NSArray *datalist)  {
    
        [_goodsList addObjectsFromArray:datalist];
        [self.tableView reloadData];
    }];
    
}

- (void)requestMyUserInfo{
    
    if ([HYUserModel sharedInstance].token) {
        
        //获取购物车数量，收藏数量
        [HYMineNetRequest getMyUserInfoComplectionBlock:^(HYMyUserInfo *myUserInfo) {
            
            _headerView.myUserInfo = [HYMyUserInfo sharedInstance];
            [_tableView reloadData];
            
        }];
    }
}


#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.cellInfoArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSString *cellName = self.cellInfoArray[indexPath.section][0];
     if ([cellName isEqualToString:@"HYOrderTableViewCell"]){
        
        //订单
        static NSString *myOrderCellID = @"myOrderCellID";
        HYOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myOrderCellID];
        if (!cell) {
            cell = [[HYOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myOrderCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.myAllOrder = ^{
            
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyOrderViewController *myOrderVC = [HYMyOrderViewController new];
            [self.navigationController pushViewController:myOrderVC animated:YES];
            myOrderVC.selectTag = 0;

        };
        cell.delegate = self;
        return cell;
    }
    else if ([cellName isEqualToString:@"HYMineInfoTableViewCell"]){
        
        //我的账户
        static NSString *myInfoCellID = @"myInfoCellID";
        HYMineInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myInfoCellID];
        if (!cell) {
            cell = [[HYMineInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myInfoCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
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
    
    static NSString *cellID = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 0) {
//
//        if([HYUserHandle jumpToLoginViewControllerFromVC:self])
//            return ;
//        HYInvitateFriendsViewController *invitateFriendsVC = [HYInvitateFriendsViewController new];
//        [self.navigationController pushViewController:invitateFriendsVC animated:YES];
//    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellName = self.cellInfoArray[indexPath.section][0];
    if ([cellName isEqualToString:@"HYOrderTableViewCell"]){
        
        //订单
        return 110 * WIDTH_MULTIPLE;
    }
    else if ([cellName isEqualToString:@"HYMineInfoTableViewCell"]){
        
        //按钮
        return 150 * WIDTH_MULTIPLE;
    }
    else if ([cellName isEqualToString:@"HYHomeDoodsCell"]){
        
        //猜你喜欢
        CGFloat height = ceil(_goodsList.count / 2.0) * 330 * WIDTH_MULTIPLE;
        return  height + 40 * WIDTH_MULTIPLE;
        
    }
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10 * WIDTH_MULTIPLE)];
    view.backgroundColor = KCOLOR(@"f4f4f4");
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10 * WIDTH_MULTIPLE;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 10 * WIDTH_MULTIPLE;
    if (scrollView == _tableView) {
        
        //去掉UItableview的section的headerview黏性
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y>=0) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
        }
        else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}


#pragma mark - headerBtnActionDelegate
- (void)headerBtnTapIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyCollectGoodsViewController *myCollectGoods = [HYMyCollectGoodsViewController new];
            [self.navigationController pushViewController:myCollectGoods animated:YES];
        }
            break;
        case 1:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyCollectShopViewController *myCollectShopVC = [HYMyCollectShopViewController new];
            [self.navigationController pushViewController:myCollectShopVC animated:YES];
        }
            break;
        case 2:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYRecentViewViewController *recentViewVC = [HYRecentViewViewController new];
            [self.navigationController pushViewController:recentViewVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - CellDelegate
//订单Cell
- (void)jumpToMyOrderDetailVCWithTag:(NSInteger)tag{
    
//    @"待付款",@"待发货",@"待收货",@"已收货",@"售后服务"
    switch (tag) {
        case 0:{
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyOrderViewController *myOrderVC = [HYMyOrderViewController new];
            [self.navigationController pushViewController:myOrderVC animated:YES];
            myOrderVC.selectTag = 1;
        }
            break;
        case 1:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyOrderViewController *myOrderVC = [HYMyOrderViewController new];
            [self.navigationController pushViewController:myOrderVC animated:YES];
            myOrderVC.selectTag = 2;

        }
            break;
        case 2:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyOrderViewController *myOrderVC = [HYMyOrderViewController new];
            [self.navigationController pushViewController:myOrderVC animated:YES];
            myOrderVC.selectTag = 3;

        }
            break;
        case 3:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyOrderViewController *myOrderVC = [HYMyOrderViewController new];
            [self.navigationController pushViewController:myOrderVC animated:YES];
            myOrderVC.selectTag = 4;

        }
            break;
        case 4:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYSaleAfterViewController *saleAfter = [HYSaleAfterViewController new];
            [self.navigationController pushViewController:saleAfter animated:YES];
            
        }
            break;
        default:
            break;
    }
}

//我的账户
- (void)jumpToMineInfoDetailVCWithTag:(NSInteger)tag{
    
     //[@"我的账户",@"优惠券",@"我的地址",@"我的二维码",@"意见反馈",@"联系客服"];
    switch (tag) {
        case 0:{
            
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyAccountViewController *myAccountVC = [HYMyAccountViewController new];
            [self.navigationController pushViewController:myAccountVC animated:YES];
        }
            break;
        case 1:{
            
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyDisCouponViewController *discountCouponVC = [HYMyDisCouponViewController new];
            [self.navigationController pushViewController:discountCouponVC animated:YES];
             
        }
            break;
        case 2:{
            
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyAddressViewController *myAddressVC = [HYMyAddressViewController new];
            [self.navigationController pushViewController:myAddressVC animated:YES];
        }
            break;
        case 3:{
            
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyQRCodeViewController *myQRCodeVC = [HYMyQRCodeViewController new];
            [self.navigationController pushViewController:myQRCodeVC animated:YES];
        }
            break;
        case 4:{
            
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYFeedbackViewController *feedbackVC = [HYFeedbackViewController new];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
            break;
        case 5:{
            
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            NSString * str = [[NSString alloc] initWithFormat:@"tel://%@",KCustomerServicePhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
        case 6:{
            
            HYSystemMessageVC *systemMessageVC = [HYSystemMessageVC new];
            [self.navigationController pushViewController:systemMessageVC animated:YES];
        }
            break;
        default:
            break;
    }
    
}


#pragma mark - lazyload
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

- (HYMineHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[HYMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 220 * WIDTH_MULTIPLE)];
        _headerView.userInteractionEnabled = YES;
        _headerView.delegate = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
           
            HYUserModel *user = [HYUserModel sharedInstance];
            if (![user.token isNotBlank]) {
                
                [HYUserHandle jumpToLoginViewControllerFromVC:self];
            }
        }];
        [_headerView addGestureRecognizer:tap];
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
