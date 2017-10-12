//
//  HYMyCollectGoodsViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyCollectGoodsViewController.h"
#import "HYMineNetRequest.h"
#import "HYMyCollectionGoodsCell.h"

@interface HYMyCollectGoodsViewController () <UITableViewDelegate,UITableViewDataSource>

/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HYMyCollectGoodsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self requestNetWork];
}

- (void)setupSubviews{
    
    self.title = @"我的收藏";
    self.view.backgroundColor = KCOLOR(@"f4f4f4");
    [self.view addSubview:self.tableView];
}

- (void)requestNetWork{
    
    [self.datalist removeAllObjects];
    [HYMineNetRequest getMyCollectGoodsWithPageNo:1 ComplectionBlock:^(NSArray *datalist) {
        
        if (datalist) {
            
            for (NSDictionary *dict in datalist) {
                
                HYGoodsItemModel *itemModel = [HYGoodsItemModel modelWithDictionary:dict];
                [self.datalist addObject:itemModel];
            }
            
            [_tableView reloadData];
        }
        
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
    
    static NSString *myCollectionGoodsCellID = @"myCollectionGoodsCellID";
    HYMyCollectionGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:myCollectionGoodsCellID];
    if (!cell) {
        cell = [[HYMyCollectionGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCollectionGoodsCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    HYGoodsItemModel *model = self.datalist[indexPath.row];
    cell.itemModel = model;
    
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90 * WIDTH_MULTIPLE;
}


#pragma mark - lazyload
- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KCOLOR(@"f4f4f4");
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
