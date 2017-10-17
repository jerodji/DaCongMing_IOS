//
//  HYSaleAfterViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSaleAfterViewController.h"
#import "HYSaleAfterCell.h"
#import "HYMineNetRequest.h"
#import "HYMySaleAfterListModel.h"
#import "HYSellerHandleViewController.h"
#import "HYSendBackViewController.h"
#import "HYSellerReceiveViewController.h"
#import "HYWaitRefundViewController.h"
#import "HYRefundSuccessViewController.h"

@interface HYSaleAfterViewController ()<UITableViewDataSource,UITableViewDelegate>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation HYSaleAfterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self requsetNetwork];
}

- (void)setupSubviews{
    
    self.title = @"售后服务";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.tableView];
}

- (void)requsetNetwork{
    
    [HYMineNetRequest getMySellAfterWithPageNo:1 ComplectionBlock:^(NSArray *datalist) {
       
        if (datalist) {
            
            self.datalist = [datalist mutableCopy];
            [_tableView reloadData];
        }
    }];
}


#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *saleAfterCellID = @"saleAfterCellID";
    HYSaleAfterCell *cell = [tableView dequeueReusableCellWithIdentifier:saleAfterCellID];
    if (!cell) {
        cell = [[HYSaleAfterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:saleAfterCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSDictionary *dict = self.datalist[indexPath.row];
    HYMySaleAfterListModel *model = [HYMySaleAfterListModel modelWithDictionary:dict];
    cell.model = model;
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.datalist[indexPath.row];
    HYMySaleAfterListModel *model = [HYMySaleAfterListModel modelWithDictionary:dict];
    NSString *pushVCStr = @"";
    switch ([model.order_stat integerValue]) {
        case 1:
        {
            HYSellerHandleViewController *sellerHandleVC = [HYSellerHandleViewController new];
            [self.navigationController pushViewController:sellerHandleVC animated:YES];
            break;
        }
        case 2:
        {
            HYSendBackViewController *sendBackVC = [HYSendBackViewController new];
            [self.navigationController pushViewController:sendBackVC animated:YES];
            sendBackVC.refundID = model.refundOrder_id;
            break;
        }
        case 3:
        {
            HYSellerReceiveViewController *sellerReceiveVC = [HYSellerReceiveViewController new];
            [self.navigationController pushViewController:sellerReceiveVC animated:YES];
            break;
        }
        case 8:
        {
            HYSellerReceiveViewController *sellerReceiveVC = [HYSellerReceiveViewController new];
            [self.navigationController pushViewController:sellerReceiveVC animated:YES];
            break;
        }
        default:
            break;
    }
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160 * WIDTH_MULTIPLE;
}



#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_TableView_BgColor;
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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
