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

@interface HYMyOrderChildViewController () <UITableViewDelegate,UITableViewDataSource>

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
    [HYRequestOrderHandle requestOrderDataWithState:state pageNo:1 andPage:5 complectionBlock:^(NSArray *datalist) {
        
        [self.datalist addObjectsFromArray:datalist];
        [self.tableView reloadData];
    }];
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
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 40 - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KCOLOR(@"f6f6f6");
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
