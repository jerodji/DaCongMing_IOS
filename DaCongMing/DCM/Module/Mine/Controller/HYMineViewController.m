//
//  HYMineViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMineViewController.h"

#import "HYMineHeaderView.h"
#import "HYInviteFriendsTableViewCell.h"
#import "HYOrderTableViewCell.h"
#import "HYMineInfoTableViewCell.h"
#import "HYHomeDoodsCell.h"

#import "HYLoginViewController.h"

@interface HYMineViewController ()<UITableViewDelegate,UITableViewDataSource>

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
    _headerView.user = [HYUserModel sharedInstance];
    [_tableView reloadData];
}

- (void)initUI{
    
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.tableView];
}

- (void)requestNetwork{
    
    _goodsList = [NSMutableArray array];

    [HYRequestGoodsList requestGoodsListItem_type:@"001" pageNo:1 andPage:5 complectionBlock:^(NSArray *datalist) {
        
        [_goodsList addObjectsFromArray:datalist];
        [self.tableView reloadData];
    }];
}


#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
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
        return cell;
    }
    else if (indexPath.row == 2){
        
        //订单
        static NSString *myInfoCellID = @"myInfoCellID";
        HYMineInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myInfoCellID];
        if (!cell) {
            cell = [[HYMineInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myInfoCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.row == 3){
        
        //退出登录
        static NSString *logoutCell = @"logoutCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:logoutCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logoutCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 20)];
        label.text = @"退出登录";
        label.font = KFitFont(14);
        label.textColor = KCOLOR(@"272727");
        [cell addSubview:label];
        return cell;
    }
    else if (indexPath.row == 4){
        //猜你喜欢
        static NSString *goodsCellID = @"goodsCellID";
        HYHomeDoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCellID];
        if (!cell) {
            cell = [[HYHomeDoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.datalist = self.goodsList;
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
        return 90 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 2){
        
        //按钮
        return 170 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 3){
    
        //退出登录
        return 50 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 4){
        
        //猜你喜欢
        CGFloat height = ceil(_goodsList.count / 2.0) * 350 * WIDTH_MULTIPLE;
        return 40 + 10 + height;
    }
    return 100;
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
