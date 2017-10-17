//
//  HYSublitApplyVC.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSublitApplyVC.h"
#import "HYOrderDetailImageCell.h"
#import "HYMyCollectionGoodsCell.h"
#import "HYFillSalesReturnCell.h"
#import "HYMineNetRequest.h"

@interface HYSublitApplyVC () <UITableViewDelegate,UITableViewDataSource,HYFillSalesReturnDelegate>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** count */
@property (nonatomic,copy) NSString *count;
/** reason */
@property (nonatomic,copy) NSString *reason;

@end

@implementation HYSublitApplyVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"提交申请";
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveSaleReturnAction)];
    self.navigationItem.rightBarButtonItem = saveItem;
    [self.view addSubview:self.tableView];
}

#pragma mark -action
- (void)saveSaleReturnAction{
    
    if (![self.count isNotBlank]) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请输入退款数量"];
        return;
    }
    
    if (![self.reason isNotBlank]) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请输入退款原因"];
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@"[{guid:%@,qty:%@}]",self.orderDetailModel.guid,self.count];
    
    [HYMineNetRequest submitApplySellAfterWithSellerID:self.orderDetailModel.seller_id orderID:self.orderDetailModel.sorder_id itemDetail:str reason:self.reason ComplectionBlock:^(BOOL isSuccess) {
        
        if (isSuccess) {
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"申请售后成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"申请售后失败"];
        }
        
    }];
}

#pragma mark - 回传数据delegate
- (void)fillSalesReturnInoInput:(NSString *)count andReason:(NSString *)reason{
    
    self.count = count;
    self.reason = reason;
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *orderDetailImageCellID = @"orderDetailImageCellID";
        HYOrderDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailImageCellID];
        if (!cell) {
            cell = [[HYOrderDetailImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailImageCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.logisticsImgView.image = [UIImage imageNamed:@"salesReturnFirstStep"];
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString *orderDetailGoodInfoCellID = @"orderDetailGoodInfoCellID";
        HYMyCollectionGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailGoodInfoCellID];
        if (!cell) {
            cell = [[HYMyCollectionGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailGoodInfoCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.orderDetailModel = self.orderDetailModel;
    
        return cell;
        
    }
    else if (indexPath.row == 2){
        
        static NSString *fillSalesReturnCellID = @"fillSalesReturnCellID";
        HYFillSalesReturnCell *cell = [tableView dequeueReusableCellWithIdentifier:fillSalesReturnCellID];
        if (!cell) {
            cell = [[HYFillSalesReturnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fillSalesReturnCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.delegate = self;
        return cell;
    }
    
    static NSString *cellID = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 40 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 1){
        
        return 90 * WIDTH_MULTIPLE;
        
    }
    else if (indexPath.row == 2){
        
        return 285 * WIDTH_MULTIPLE;
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
        _tableView.backgroundColor = KAPP_TableView_BgColor;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
