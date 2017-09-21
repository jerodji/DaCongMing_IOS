//
//  HYShoppingCartViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYShoppingCartViewController.h"

#import "HYNoGoodsTableViewCell.h"
#import "HYHomeDoodsCell.h"

@interface HYShoppingCartViewController () <UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *datalist;
/** 商品列表 */
@property (nonatomic,strong) NSMutableArray *goodsList;

@end

@implementation HYShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"购物车";
    
    [self setupData];
    [self setupSubviews];
}

- (void)setupData{
    
    _datalist = [NSMutableArray array];
    [_datalist addObject:@"noData"];
    
    [_tableView reloadData];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.tableView];
}

#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64 - 49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //空购物车
        static NSString *noGoodsCellID = @"noGoodsCellID";
        HYNoGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noGoodsCellID];
        if (!cell) {
            cell = [[HYNoGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noGoodsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
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
        return cell;
    }
    
    static NSString *cellID = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //购物车无商品
        return 240 * WIDTH_MULTIPLE;
    }
    return 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
