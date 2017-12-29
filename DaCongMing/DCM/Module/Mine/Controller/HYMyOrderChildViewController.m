//
//  HYMyOrderChildViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyOrderChildViewController.h"
#import "HYRequestOrderHandle.h"
#import "HYMyOrderTableViewCell.h"
#import "HYMyOrderDetailViewController.h"
#import "HYFillOrderViewController.h"
#import "HYConfirmReceiveGoodsVC.h"
#import "HYCommentVC.h"

@interface HYMyOrderChildViewController () <UITableViewDelegate,UITableViewDataSource,HYMyOrderBtnActionDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation HYMyOrderChildViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
}

- (void)setTag:(NSInteger)tag{
    
    _tag = tag;
    //未付款：1、待发货（已付款）：2、待收货：3、已收货：8
    switch (tag) {
        case 0:
            [self requestDataWithTag:0];
            break;
        case 1:
            [self requestDataWithTag:1];
            break;
        case 2:
            [self requestDataWithTag:2];
            break;
        case 3:
            [self requestDataWithTag:3];
            break;
        case 4:
            [self requestDataWithTag:8];
            break;
        default:
            break;
    }
}

- (void)requestDataWithTag:(NSInteger)state{
    
    [self.datalist removeAllObjects];
    if (state == 0) {
        
        [HYRequestOrderHandle requestAllOrderDataWithPageNo:1 andPage:5 ComplectionBlock:^(NSArray *datalist) {
            
            [self.datalist addObjectsFromArray:datalist];
            [self.tableView reloadData];
        }];
    }
    else{
        
        [HYRequestOrderHandle requestOrderDataWithState:state pageNo:1 andPage:5 complectionBlock:^(NSArray *datalist) {
            
            [self.datalist addObjectsFromArray:datalist];
            [self.tableView reloadData];
        }];
    }
    
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
   return self.datalist.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myOrderCellID = @"myOrderCellID";
    HYMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myOrderCellID];
    if (!cell) {
        cell = [[HYMyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myOrderCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (self.datalist.count) {
        
        NSDictionary *dict = self.datalist[indexPath.section];
        HYMyOrderModel *model = [HYMyOrderModel modelWithDictionary:dict];
        cell.model = model;
        cell.indexPath = indexPath;
        cell.delegate = self;
    }
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.datalist[indexPath.section];
    HYMyOrderModel *model = [HYMyOrderModel modelWithDictionary:dict];
    HYMyOrderDetailViewController *orderDetailVC = [HYMyOrderDetailViewController new];
    orderDetailVC.orderModel = model;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 230 * WIDTH_MULTIPLE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10 * WIDTH_MULTIPLE)];
    view.backgroundColor = KCOLOR(@"f4f4f4");
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10 * WIDTH_MULTIPLE;
}

#pragma mark - 没有数据
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"您目前还没有订单";
    NSDictionary *attributes = @{NSFontAttributeName : KFitFont(18),NSForegroundColorAttributeName : KAPP_7b7b7b_COLOR};
     return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    UIImage *image = [UIImage imageNamed:@"noOrder"];
    return image;
}

#pragma mark - BtnDelegate
- (void)myOrderBtnActionWithStr:(NSString *)title WithIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.datalist[indexPath.section];
    HYMyOrderModel *model = [HYMyOrderModel modelWithDictionary:dict];
    
    if ([title isEqualToString:@"去付款"]) {
        
        HYFillOrderViewController *fillOrderVC = [HYFillOrderViewController new];
        fillOrderVC.orderID = model.sorder_id;
        [self.navigationController pushViewController:fillOrderVC animated:YES];
    }
    else if ([title isEqualToString:@"再次购买"]){
        
        HYFillOrderViewController *fillOrderVC = [HYFillOrderViewController new];
        fillOrderVC.orderID = model.sorder_id;
        [self.navigationController pushViewController:fillOrderVC animated:YES];
    }
    else if ([title isEqualToString:@"确认收货"]){
        
        [self confirmOrderWithOrderID:model.sorder_id];
    }
    else if ([title isEqualToString:@"删除订单"]){
        

        [self deleteOrderWithOrderID:model.sorder_id];
    }
    else if ([title isEqualToString:@"评论"]){
        
        HYCommentVC *commentVC = [HYCommentVC new];
        commentVC.orderID = model.sorder_id;
        [self.navigationController pushViewController:commentVC animated:YES];
    }
    else if ([title isEqualToString:@"联系客服"]){
        
        [self contactServiceWithModel:model];
    }
}

- (void)contactServiceWithModel:(HYMyOrderModel *)orderModel{
    
    QYSource *source = [[QYSource alloc] init];
    source.title =  @"联系客服";
    source.urlString = @"https://8.163.com/";
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    
    sessionViewController.sessionTitle = @"联系客服";
    QYUserInfo *userInfo = [[QYUserInfo alloc] init];
    userInfo.userId = [HYUserModel sharedInstance].userInfo.id;
    NSMutableArray *array = [NSMutableArray new];
    NSMutableDictionary *dictRealName = [NSMutableDictionary new];
    [dictRealName setObject:@"real_name" forKey:@"key"];
    [dictRealName setObject:[HYUserModel sharedInstance].userInfo.name forKey:@"value"];
    [array addObject:dictRealName];
    
    NSMutableDictionary *dictMobilePhone = [NSMutableDictionary new];
    [dictMobilePhone setObject:@"mobile_phone" forKey:@"key"];
    [dictMobilePhone setObject:@"mobile_phone" forKey:@"key"];

    [dictMobilePhone setValue:[HYUserModel sharedInstance].userInfo.phone forKey:@"value"];
    [dictMobilePhone setObject:@(NO) forKey:@"hidden"];
    [array addObject:dictMobilePhone];
    
    NSMutableDictionary *orderDict = [NSMutableDictionary new];
    [orderDict setObject:@"orderID" forKey:@"key"];
    [orderDict setObject:@"订单号" forKey:@"label"];
    [orderDict setValue:orderModel.sorder_id forKey:@"value"];
    [array addObject:orderDict];
    
    NSMutableDictionary *userDict = [NSMutableDictionary new];
    [userDict setObject:@"userInfo" forKey:@"key"];
    [userDict setObject:@"用户ID" forKey:@"label"];
    [userDict setValue:[HYUserModel sharedInstance].userInfo.id forKey:@"value"];
    [array addObject:userDict];
    
//    NSMutableDictionary *dictEmail = [NSMutableDictionary new];
//    [dictEmail setObject:@"email" forKey:@"key"];
//    [dictEmail setObject:@"bianchen@163.com" forKey:@"value"];
//    [array addObject:dictEmail];
    
//    NSMutableDictionary *dictAuthentication = [NSMutableDictionary new];
//    [dictAuthentication setObject:@"0" forKey:@"index"];
//    [dictAuthentication setObject:@"authentication" forKey:@"key"];
//    [dictAuthentication setObject:@"实名认证" forKey:@"label"];
//    [dictAuthentication setObject:@"已认证" forKey:@"value"];
//    [array addObject:dictAuthentication];
    
//    NSMutableDictionary *dictBankcard = [NSMutableDictionary new];
//    [dictBankcard setObject:@"1" forKey:@"index"];
//    [dictBankcard setObject:@"bankcard" forKey:@"key"];
//    [dictBankcard setObject:@"绑定银行卡" forKey:@"label"];
//    [dictBankcard setObject:@"622202******01116068" forKey:@"value"];
//    [array addObject:dictBankcard];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:0
                                                     error:nil];
    if (data)
    {
        userInfo.data = [[NSString alloc] initWithData:data
                                              encoding:NSUTF8StringEncoding];
    }
    
    [[QYSDK sharedSDK] setUserInfo:userInfo];
    sessionViewController.source = source;
    [self.navigationController pushViewController:sessionViewController animated:YES];
}

#pragma mark - action
- (void)deleteOrderWithOrderID:(NSString *)orderID{
    
    HYCustomAlert *customAlert = [[HYCustomAlert alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) WithTitle:@"温馨提示" content:@"确认要删除订单吗？" confirmBlock:^{
        
        [HYRequestOrderHandle deleteOrderWithOrderID:orderID ComplectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"删除订单成功"];
                [self requestDataWithTag:_tag];
            }
        }];
        
    }];
    [KEYWINDOW addSubview:customAlert];
}

- (void)confirmOrderWithOrderID:(NSString *)orderID{
    
    HYCustomAlert *customAlert = [[HYCustomAlert alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) WithTitle:@"温馨提示" content:@"确认当前已经收到货物了吗？" confirmBlock:^{
        
        [HYRequestOrderHandle confirmReceiveProductWithOrderID:orderID ComplectionBlock:^(BOOL isSuccess) {
           
            if (isSuccess) {
                
                [self requestDataWithTag:_tag];
                HYConfirmReceiveGoodsVC *confirmReceiveVC = [HYConfirmReceiveGoodsVC new];
                confirmReceiveVC.orderID = orderID;
                [self.navigationController pushViewController:confirmReceiveVC animated:YES];
            }
        }];
    }];
    [KEYWINDOW addSubview:customAlert];
}

#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KCOLOR(@"f6f6f6");
        _tableView.emptyDataSetSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}




@end
