//
//  HYFillOrderViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYFillOrderViewController.h"

#import "HYReceiveAddressTableViewCell.h"
#import "HYGoodsPostageTableViewCell.h"
#import "HYDiscountTableViewCell.h"
#import "HYGoodsPayTableViewCell.h"

@interface HYFillOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYFillOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"填写订单";
    [self setupSubviews];
    [self setupMasonryLayout];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.tableView];
}

- (void)setupMasonryLayout{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-55 * WIDTH_MULTIPLE);
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
        
        //图片
        static NSString *receiveAddressCell = @"receiveAddressCell";
        HYReceiveAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiveAddressCell];
        if (!cell) {
            cell = [[HYReceiveAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:receiveAddressCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString *goodsPostageCell = @"goodsPostageCell";
        HYGoodsPostageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsPostageCell];
        if (!cell) {
            cell = [[HYGoodsPostageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsPostageCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    
        return cell;
    }
    else if (indexPath.row == 2){
        
        static NSString *discountCell = @"discountCell";
        HYDiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:discountCell];
        if (!cell) {
            cell = [[HYDiscountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:discountCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.row == 3){
        
        static NSString *goodsPayCell = @"goodsPayCell";
        HYGoodsPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsPayCell];
        if (!cell) {
            cell = [[HYGoodsPayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsPayCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
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
