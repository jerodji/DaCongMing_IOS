//
//  HYMyOrderDetailViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyOrderDetailViewController.h"

#import "HYOrderDetailImageCell.h"
#import "HYOrderDetailReceiverTableViewCell.h"
#import "HYOrderDetailInfoCell.h"
#import "HYMyCollectionGoodsCell.h"

@interface HYMyOrderDetailViewController () <UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYMyOrderDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"订单详情";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.tableView];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.orderModel.orderDtls.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *orderDetailImageCellID = @"orderDetailImageCellID";
        HYOrderDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailImageCellID];
        if (!cell) {
            cell = [[HYOrderDetailImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailImageCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString *orderDetailReceiverCellID = @"orderDetailReceiverCellID";
        HYOrderDetailReceiverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailReceiverCellID];
        if (!cell) {
            cell = [[HYOrderDetailReceiverTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailReceiverCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.orderModel = self.orderModel;
        return cell;
        
    }
    else if (indexPath.row == 2){
        
        static NSString *orderDetailInfoCellID = @"orderDetailInfoCellID";
        HYOrderDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailInfoCellID];
        if (!cell) {
            cell = [[HYOrderDetailInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailInfoCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.orderModel = self.orderModel;
        return cell;
    }
    else{
        
        static NSString *orderDetailGoodInfoCellID = @"orderDetailGoodInfoCellID";
        HYMyCollectionGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailGoodInfoCellID];
        if (!cell) {
            cell = [[HYMyCollectionGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailGoodInfoCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        NSDictionary *dict = self.orderModel.orderDtls[indexPath.row - 3];
        HYMyOrderDetailsModel *orderDetailModel = [HYMyOrderDetailsModel modelWithDictionary:dict];
        cell.orderDetailModel = orderDetailModel;
        return cell;
    }
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 90 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 1){
        
        return 45 * WIDTH_MULTIPLE;

    }
    else if (indexPath.row == 2){
        
        return 380 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 3){
        
        return 80 * WIDTH_MULTIPLE;
    }
    return 10;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end