//
//  HYPayResultViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYPayResultViewController.h"
#import "HYMyOrderViewController.h"

#import "HYGoodsDetailInfoViewController.h"
#import "HYPayResultTableViewCell.h"
#import "HYReceiverInfoTableViewCell.h"
#import "HYHomeDoodsCell.h"

@interface HYPayResultViewController () <UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 商品列表 */
@property (nonatomic,strong) NSMutableArray *goodsList;

@end

@implementation HYPayResultViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
    [self requestNetwork];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.tableView];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backBtnAction{
    
    NSArray *pushVCAry = [self.navigationController viewControllers];
    UIViewController *popVC = [pushVCAry objectAtIndex:pushVCAry.count - 3];
    [self.navigationController popToViewController:popVC animated:YES];
}

- (void)requestNetwork{
    
    _goodsList = [NSMutableArray array];
    
    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 andPage:5 order:nil hotsale:nil complectionBlock:^(NSArray *datalist) {
        
        [_goodsList addObjectsFromArray:datalist];
        [self.tableView reloadData];
    }];
}

- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.bottom.equalTo(self.view);
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
        
        static NSString *payResultCell = @"payResultCell";
        HYPayResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payResultCell];
        if (!cell) {
            cell = [[HYPayResultTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payResultCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.isPaySuccess = self.isPaySuccess;
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString *receiverInfoCell = @"receiverInfoCell";
        HYReceiverInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiverInfoCell];
        if (!cell) {
            cell = [[HYReceiverInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:receiverInfoCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.isPaySuccess = self.isPaySuccess;
        cell.addressMap = self.addressMap;
        cell.returnHome = ^{
          
            HYTabBarController *tabBar = [[HYTabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
        };
        cell.lookOrderInfo = ^{
            
            HYMyOrderViewController *myOrderVC = [HYMyOrderViewController new];
            [self.navigationController pushViewController:myOrderVC animated:YES];
            myOrderVC.selectTag = 0;
        };
        cell.payAgain = ^{
          
            [self.navigationController popViewControllerAnimated:YES];
        };
        return cell;
    }
    else if (indexPath.row == 2){
        
        //猜你喜欢
        static NSString *goodsCellID = @"goodsCellID";
        HYHomeDoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCellID];
        if (!cell) {
            cell = [[HYHomeDoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.title = @"猜你喜欢";
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //支付结果
        return 135 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 1){
        
        //收货信息
        return 180 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 2){
        
        //猜你喜欢
        CGFloat height = ceil(_goodsList.count / 2.0) * 350 * WIDTH_MULTIPLE;
        return 40 + 10 + height;
    }

    return 100;
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
