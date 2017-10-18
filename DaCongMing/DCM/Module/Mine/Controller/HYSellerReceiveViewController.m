//
//  HYSellerReceiveViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSellerReceiveViewController.h"
#import "HYOrderDetailImageCell.h"
#import "HYRefundSellerHandleCell.h"
#import "HYSendBackInfoCell.h"
#import "HYMineNetRequest.h"

@interface HYSellerReceiveViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** model */
@property (nonatomic,strong) HYRefundModel *refundModel;


@end

@implementation HYSellerReceiveViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self requestNetwork];
}

- (void)setupSubviews{
    
    self.title = @"商家收货";
    [self.view addSubview:self.tableView];
}

- (void)requestNetwork{
    
    [HYMineNetRequest getRefundDetailWithRefundID:self.refundID ComplectionBlock:^(HYRefundModel *refundModel) {
        
        self.refundModel = refundModel;
        [_tableView reloadData];
    }];
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
        cell.logisticsImgView.image = [UIImage imageNamed:@"salesReturnFourthStep"];
        return cell;
    }
    else if (indexPath.row == 1) {
        
        static NSString *refundSellerHandleCellID = @"refundSellerHandleCellID";
        HYRefundSellerHandleCell *cell = [tableView dequeueReusableCellWithIdentifier:refundSellerHandleCellID];
        if (!cell) {
            cell = [[HYRefundSellerHandleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:refundSellerHandleCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;
    }
    else{
        
        static NSString *sendBackCellID = @"sendBackCellID";
        HYSendBackInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:sendBackCellID];
        if (!cell) {
            cell = [[HYSendBackInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sendBackCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.model = self.refundModel;
        return cell;
    }
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 40 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 1){
        
        return 170 * WIDTH_MULTIPLE;
    }
    
    return 150 * WIDTH_MULTIPLE;
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
