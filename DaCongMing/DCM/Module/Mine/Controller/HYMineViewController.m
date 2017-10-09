//
//  HYMineViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
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

@interface HYMineViewController ()<UITableViewDelegate,UITableViewDataSource,HYMineInfoBtnActionDelegate,HYMyOrderActionDelegate>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *datalist;

/** header */
@property (nonatomic,strong) HYMineHeaderView *headerView;
/** 商品列表 */
@property (nonatomic,strong) NSMutableArray *goodsList;

@end

@implementation HYMineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initUI];
    [self requestNetwork];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;

    _headerView.user = [HYUserModel sharedInstance];
    [_tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)initUI{
    
    [self.view addSubview:self.tableView];
}

- (void)requestNetwork{
    
    _goodsList = [NSMutableArray array];

    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 andPage:5 order:nil hotsale:nil complectionBlock:^(NSArray *datalist) {
   
        [_goodsList addObjectsFromArray:datalist];
        [self.tableView reloadData];
    }];
}


#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //邀请好友
        static NSString *inviteCellID = @"inviteCellID";
        HYInviteFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inviteCellID];
        if (!cell) {
            cell = [[HYInviteFriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inviteCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.row == 1){
        
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
    else if (indexPath.row == 2){
        
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
    else if (indexPath.row == 3){
        //猜你喜欢
        static NSString *goodsCellID = @"goodsCellID";
        HYHomeDoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCellID];
        if (!cell) {
            cell = [[HYHomeDoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.datalist = self.goodsList;
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
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //邀请好友
        return 50 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 1){
        
        //订单
        return 130 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 2){
        
        //按钮
        return 170 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 3){
        
        //猜你喜欢
        CGFloat height = ceil(_goodsList.count / 2.0) * 350 * WIDTH_MULTIPLE;
        return 40 + 10 + height;
    }
    return 100;
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
            
            break;
        default:
            break;
    }
}

//我的账户
- (void)jumpToMineInfoDetailVCWithTag:(NSInteger)tag{
    
     //[@"我的账户",@"优惠券",@"我的地址",@"我的二维码",@"意见反馈",@"联系客服"];
    switch (tag) {
        case 0:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyAccountViewController *myAccountVC = [HYMyAccountViewController new];
            [self.navigationController pushViewController:myAccountVC animated:YES];
        }
            break;
        case 1:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyDisCouponViewController *discountCouponVC = [HYMyDisCouponViewController new];
            [self.navigationController pushViewController:discountCouponVC animated:YES];
             
        }
            break;
        case 2:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyAddressViewController *myAddressVC = [HYMyAddressViewController new];
            [self.navigationController pushViewController:myAddressVC animated:YES];
        }
            break;
        case 3:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYMyQRCodeViewController *myQRCodeVC = [HYMyQRCodeViewController new];
            [self.navigationController pushViewController:myQRCodeVC animated:YES];
        }
            break;
        case 4:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            HYFeedbackViewController *feedbackVC = [HYFeedbackViewController new];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
            break;
        case 5:
        {
            if([HYUserHandle jumpToLoginViewControllerFromVC:self])
                return ;
            NSString * str = [[NSString alloc] initWithFormat:@"tel://%@",KCustomerServicePhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
        
            break;
        default:
            break;
    }
    
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, KSCREEN_WIDTH, KSCREEN_HEIGHT - 49 + 20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (HYMineHeaderView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[HYMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 190 * WIDTH_MULTIPLE)];
        _headerView.userInteractionEnabled = YES;
        
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
