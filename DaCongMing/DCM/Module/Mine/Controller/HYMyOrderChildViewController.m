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
    
    NSDictionary *dict = self.datalist[indexPath.section];
    HYMyOrderModel *model = [HYMyOrderModel modelWithDictionary:dict];
    cell.model = model;
    cell.indexPath = indexPath;
    cell.delegate = self;
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
            }
        }];
    }];
    [KEYWINDOW addSubview:customAlert];
}

#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 40 - 64) style:UITableViewStylePlain];
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
