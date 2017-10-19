//
//  HYMyDisCouponViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyDisCouponViewController.h"
#import "HYRequestOrderHandle.h"
#import "HYNoDiscountCouponView.h"

@interface HYMyDisCouponViewController () <UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;
/** noDiscountCouponView */
@property (nonatomic,strong) HYNoDiscountCouponView *noDiscountCouponView;

@end

@implementation HYMyDisCouponViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"我的优惠券";
    [self setupSubviews];
    [self requestData];
}

- (void)setupSubviews{
    
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.noDiscountCouponView];
}

- (void)viewDidLayoutSubviews{
    
    [_noDiscountCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

- (void)requestData{
    
    [self.datalist removeAllObjects];
    [HYRequestOrderHandle requestDiscountCouponComplectionBlock:^(NSArray *datalist) {
        
        //[_noDiscountCouponView removeFromSuperview];
        //_noDiscountCouponView = nil;
        
    } noDataBlock:^{
        
        [_tableView removeFromSuperview];
        _tableView = nil;
        
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
    
    return 130 * WIDTH_MULTIPLE;
}


#pragma mark - lazyload
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _tableView;
}

- (HYNoDiscountCouponView *)noDiscountCouponView{
    
    if (!_noDiscountCouponView) {
        _noDiscountCouponView = [HYNoDiscountCouponView new];
        _noDiscountCouponView.strollActin = ^{
            
            [HYUserHandle jumpToHomePageVC];
        };
    }
    return _noDiscountCouponView;
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



@end
