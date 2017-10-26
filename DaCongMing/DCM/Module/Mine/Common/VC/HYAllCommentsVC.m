//
//  HYAllCommentsVC.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYAllCommentsVC.h"
#import "HYCommentCell.h"

@interface HYAllCommentsVC ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation HYAllCommentsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self requestNetwork];
}

- (void)setupSubviews{
    
    self.title = @"所有评论";
    [self.view addSubview:self.tableView];
}

- (void)requestNetwork{
    
    [self.datalist removeAllObjects];
    [HYGoodsHandle requestProductsCommentsWithProductID:self.productID pageNo:1 complectionBlock:^(NSArray *datalist) {
        
        for (NSDictionary *dict in datalist) {
            
            HYCommentModel *commentModel = [HYCommentModel modelWithDictionary:dict];
            [self.datalist addObject:commentModel];
        }
       
        [_tableView reloadData];
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
    
    static NSString *commentCellID = @"commentCellID";
    HYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
    if (!cell) {
        cell = [[HYCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.commentModel = self.datalist[indexPath.row];
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYCommentModel *commentModel = self.datalist[indexPath.row];
    return commentModel.cellHeight;
}



#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
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
