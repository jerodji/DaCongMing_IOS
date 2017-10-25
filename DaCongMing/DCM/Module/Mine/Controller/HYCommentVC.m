//
//  HYCommentVC.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYCommentVC.h"
#import "HYRequestOrderHandle.h"
#import "HYCommentTableViewCell.h"
#import "HYMineNetRequest.h"

@interface HYCommentVC () <UITableViewDelegate,UITableViewDataSource,HYCommentProductsDelegate>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *datalist;
/** 订单模型 */
@property (nonatomic,strong) HYMyOrderModel *orderModel;
/** 请求参数 */
@property (nonatomic,strong) NSMutableArray *paramArray;

@end

@implementation HYCommentVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self requestNetwork];
}

- (void)setupSubviews{
    
    self.title = @"评价";
    [self.view addSubview:self.tableView];
    UIBarButtonItem *postCommentItem = [[UIBarButtonItem alloc] initWithTitle:@"发表评价" style:UIBarButtonItemStylePlain target:self action:@selector(postComment)];
    self.navigationItem.rightBarButtonItem = postCommentItem;
}

- (void)requestNetwork{
    
    [HYRequestOrderHandle requestOrderDetailWithOrderID:self.orderID complectionBlock:^(HYMyOrderModel *orderModel) {
        
        self.orderModel = orderModel;
        [_tableView reloadData];
    }];
}

- (void)postComment{
    
    NSString *str = [self.paramArray jsonStringEncoded];
    DLog(@"%@",str);
    
    BOOL isFillInfo = NO;       //记录是否填写了内容
    for (NSInteger i = 0; i < self.paramArray.count; i++) {
        
        NSDictionary *dict = self.paramArray[i];
        NSNumber *evaluate_level = dict[@"evaluate_level"];
        NSInteger score = [evaluate_level integerValue];
        if (score != 0 && [dict[@"evaluate_msg"] isNotBlank]) {
            
            isFillInfo = YES;
        }
        else{
            isFillInfo = NO;
        }
    }
    
    if (isFillInfo) {
        
        [HYMineNetRequest commentWithOrderID:self.orderID jsonText:str ComplectionBlock:^(BOOL isSuccess) {
           
            if (isSuccess) {
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"感谢你的评价"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"评价失败"];

            }
        }];
    }
    else{
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请填写评价和评分"];
    }
}

#pragma mark - cellDataCallBack
- (void)commentWithText:(NSString *)text andScore:(CGFloat)score WithIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.orderModel.orderDtls[indexPath.row];
    HYMyOrderDetailsModel *orderDetailModel = [HYMyOrderDetailsModel modelWithDictionary:dict];
    
    if (self.paramArray.count) {
        
        for (NSInteger i = 0; i < self.paramArray.count; i++) {
            
            if (i == indexPath.row) {
                
                NSMutableDictionary *mutableDict = self.paramArray[i];
                [mutableDict setValue:orderDetailModel.item_id forKey:@"item_id"];
                [mutableDict setValue:@(score) forKey:@"evaluate_level"];
                [mutableDict setValue:text forKey:@"evaluate_msg"];
                [self.paramArray replaceObjectAtIndex:i withObject:mutableDict];
            }
        }
    }

   
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.orderModel.orderDtls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *commentCellID = @"commentCellID";
    HYCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
    if (!cell) {
        cell = [[HYCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSDictionary *dict = self.orderModel.orderDtls[indexPath.row];
    HYMyOrderDetailsModel *orderDetailModel = [HYMyOrderDetailsModel modelWithDictionary:dict];
    cell.orderDetailModel = orderDetailModel;
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 270 * WIDTH_MULTIPLE;
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

- (NSMutableArray *)paramArray{
    
    if (!_paramArray) {
        
        _paramArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.orderModel.orderDtls.count; i++) {
            
            NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
            [paraDict setValue:@"" forKey:@"item_id"];
            [paraDict setValue:@(0) forKey:@"evaluate_level"];
            [paraDict setValue:@"" forKey:@"evaluate_msg"];
            [_paramArray addObject:paraDict];
        }
    }
    return _paramArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
