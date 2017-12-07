//
//  HYRecentViewViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRecentViewViewController.h"
#import "HYRequestOrderHandle.h"
#import "HYGoodsItemModel.h"
#import "HYMyCollectionGoodsCell.h"
#import "HYGoodsDetailInfoViewController.h"

@interface HYRecentViewViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation HYRecentViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self setupSubviews];
    
}

- (void)setupSubviews{
    
    self.title = @"最近浏览";
    self.view.backgroundColor = KCOLOR(@"f4f4f4");
    [self.view addSubview:self.tableView];
}

- (void)requestData{
    
    [self.datalist removeAllObjects];
    [HYRequestOrderHandle requestRecentViewWithpageNo:1 complectionBlock:^(NSArray *datalist) {
       
        if (datalist) {
            
            [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:obj];
                [self.datalist addObject:model];
                
            }];
            [_tableView reloadData];
        }
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
    
    static NSString *myCollectionGoodsCellID = @"myCollectionGoodsCellID";
    HYMyCollectionGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:myCollectionGoodsCellID];
    if (!cell) {
        cell = [[HYMyCollectionGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCollectionGoodsCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    HYGoodsItemModel *model = self.datalist[indexPath.section];
    cell.itemModel = model;
    return cell;
}

#pragma mark - emptyTable
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"目前还没有浏览记录";
    NSDictionary *attributes = @{NSFontAttributeName : KFitFont(18),NSForegroundColorAttributeName : KAPP_7b7b7b_COLOR};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYGoodsItemModel *model = self.datalist[indexPath.section];
    HYGoodsDetailInfoViewController *detailVC = [HYGoodsDetailInfoViewController new];
    detailVC.goodsID = model.item_id;
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90 * WIDTH_MULTIPLE;
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
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.emptyDataSetSource = self;
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



@end
