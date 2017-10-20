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
#import "HYDeleteCartsView.h"
#import "HYNoCollectImgView.h"

@interface HYMyCollectGoodsViewController () <UITableViewDelegate,UITableViewDataSource>

/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 删除 */
@property (nonatomic,strong) HYDeleteCartsView *deleteCartsView;
/** deleteStr */
@property (nonatomic,strong) NSMutableString *deleteStr;
/** 没有数据 */
@property (nonatomic,strong) HYNoCollectImgView *noDataView;

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

- (void)setupBottomView{
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.title = @"编辑";
    
}

- (void)requestNetWork{
    
    [self.datalist removeAllObjects];
    [HYMineNetRequest getMyCollectGoodsWithPageNo:1 ComplectionBlock:^(NSArray *datalist) {
        
        if (datalist.count) {
            
            for (NSDictionary *dict in datalist) {
                
                HYGoodsItemModel *itemModel = [HYGoodsItemModel modelWithDictionary:dict];
                [self.datalist addObject:itemModel];
            }
            
            [_tableView reloadData];
            [self setupBottomView];
        }
        else{
            
            self.navigationItem.rightBarButtonItem = nil;
            [self.tableView removeFromSuperview];
            self.tableView = nil;
            [self.view addSubview:self.noDataView];
        }
        
    }];
}

#pragma mark - action
- (void)deleteAction{
    
    __weak typeof (self)weakSelf = self;
    weakSelf.deleteStr = [NSMutableString stringWithFormat:@""];
    _deleteCartsView.deleteCheckAllBlock = ^(BOOL isCheckAll) {
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (HYGoodsItemModel *item in weakSelf.datalist) {
            
            item.isSelect = isCheckAll;
            if (item.isSelect) {
                
                [weakSelf.deleteStr appendString:item.item_id];
                [weakSelf.deleteStr appendString:@","];
            }
            [tempArray addObject:item];
        }
        [weakSelf.datalist removeAllObjects];
        [weakSelf.datalist addObjectsFromArray:tempArray];
        [weakSelf.tableView reloadData];
    };
    
    _deleteCartsView.deleteBlock = ^{
        
        [HYMineNetRequest deleteMyCollectionGoodsWithItemIDs:weakSelf.deleteStr ComplectionBlock:^(BOOL isSuccess) {
           
            if (isSuccess) {
                
                [weakSelf requestNetWork];
                [weakSelf setEditing:NO animated:YES];
            }
        }];
    };
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
    cell.itemSelect = ^(BOOL isSelect) {
      
        model.isSelect = isSelect;
        if ([self.deleteStr containsString:model.item_id]) {
            
            NSRange range = [self.deleteStr rangeOfString:[NSString stringWithFormat:@"%@,",model.item_id]];
            [self.deleteStr deleteCharactersInRange:range];
        }
        else{
            
            [self.deleteStr appendString:model.item_id];
            [self.deleteStr appendString:@","];
        }
        
    };
    [self.datalist replaceObjectAtIndex:indexPath.row withObject:model];
    
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90 * WIDTH_MULTIPLE;
}

#pragma mark - CellEdit
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYGoodsItemModel *model = self.datalist[indexPath.row];
    [HYMineNetRequest deleteMyCollectionGoodsWithItemIDs:model.item_id ComplectionBlock:^(BOOL isSuccess) {
        
        if (isSuccess) {
            
            [self.datalist removeObjectAtIndex:indexPath.row];
            [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
        }
        else{
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"删除收藏失败"];
        }
    }];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

#pragma mark - editingMode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    self.navigationItem.rightBarButtonItem.title = editing ? @"完成" : @"编辑" ;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (HYGoodsItemModel *item in self.datalist) {
        
        item.isEdit = editing;
        [tempArray addObject:item];
    }
    [self.datalist removeAllObjects];
    [self.datalist addObjectsFromArray:tempArray];
    [_tableView reloadData];

    if (editing) {
        
        [self.view addSubview:self.deleteCartsView];
        [_deleteCartsView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
        }];
        _deleteCartsView.hidden = NO;
    }
    else{
        
        _deleteCartsView.hidden = YES;
    }
    
    [self deleteAction];
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

- (HYDeleteCartsView *)deleteCartsView{
    
    if (!_deleteCartsView) {
        
        _deleteCartsView = [HYDeleteCartsView new];
    }
    return _deleteCartsView;
}

- (NSMutableString *)deleteStr{
    
    if (!_deleteStr) {
        
        _deleteStr = [NSMutableString string];
    }
    return _deleteStr;
}

- (HYNoCollectImgView *)noDataView{
    
    if (!_noDataView) {
        
        _noDataView = [[HYNoCollectImgView alloc] init];
    }
    return _noDataView;
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
