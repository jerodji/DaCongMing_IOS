//
//  HYConfirmReceiveGoodsVC.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/24.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYConfirmReceiveGoodsVC.h"
#import "HYHomeDoodsCell.h"
#import "HYConfirmSuccessCell.h"
#import "HYGoodsDetailInfoViewController.h"
#import "HYCommentVC.h"

@interface HYConfirmReceiveGoodsVC () <UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 商品列表 */
@property (nonatomic,strong) NSMutableArray *goodsList;


@end

@implementation HYConfirmReceiveGoodsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
    [self requestNetwork];
}

- (void)setupSubviews{
    
    self.title = @"确认收货";
    [self.view addSubview:self.tableView];
}

- (void)requestNetwork{
    
    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 andPage:5 order:nil hotsale:nil complectionBlock:^(NSArray *datalist) {
        
        [self.goodsList addObjectsFromArray:datalist];
        [self.tableView reloadData];
    }];
    
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        static NSString *confirmSuccessCellID = @"confirmSuccessCellID";
        HYConfirmSuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmSuccessCellID];
        if (!cell) {
            cell = [[HYConfirmSuccessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmSuccessCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.lookOrderBlock = ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        };
        cell.commentBlock = ^{
            
            HYCommentVC *commentVC = [HYCommentVC new];
            commentVC.orderID = self.orderID;
            [self.navigationController pushViewController:commentVC animated:YES];
        };
        return cell;
    }
    else if (indexPath.row == 1){
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
    
    return nil;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 260 * WIDTH_MULTIPLE;
    }
    else{
        
        //猜你喜欢
        CGFloat height = ceil(_goodsList.count / 2.0) * 350 * WIDTH_MULTIPLE;
        return  height + 40 * WIDTH_MULTIPLE;
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

- (NSMutableArray *)goodsList{
    
    if (!_goodsList) {
        _goodsList = [NSMutableArray array];
    }
    return _goodsList;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
