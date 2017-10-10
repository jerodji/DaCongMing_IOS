//
//  HYShoppingCartViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYShoppingCartViewController.h"
#import "HYGoodsDetailInfoViewController.h"

#import "HYNoGoodsTableViewCell.h"
#import "HYHomeDoodsCell.h"
#import "HYShoppingCartsTableViewCell.h"
#import "HYCartsBottomView.h"
#import "HYCartsHandle.h"
#import "HYCartsModel.h"

@interface HYShoppingCartViewController () <UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *datalist;
/** 商品列表 */
@property (nonatomic,strong) NSMutableArray *goodsList;
/** 购物车 */
@property (nonatomic,strong) HYCartsModel *cartsModel;
/** CellCount */
@property (nonatomic,assign) NSInteger tableCount;
/** 底部结算 */
@property (nonatomic,strong) HYCartsBottomView *bottomView;

@end

@implementation HYShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"购物车";
    
    [self setupData];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestShoppingCartsData];
}

- (void)setupData{
    
    _datalist = [NSMutableArray array];
    _goodsList = [NSMutableArray array];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self.view);
        if (_cartsModel) {
            
            make.bottom.equalTo(self.view).offset(60 * WIDTH_MULTIPLE);
        }
        else{
            
            make.bottom.equalTo(self.view);
        }
    }];
}

- (void)setupNavItem{
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editBtnAction:)];
    self.navigationItem.rightBarButtonItem = editItem;
    
}

- (void)requestShoppingCartsData{
    
    [HYCartsHandle showMyShoppingCartsWithComplectionBlock:^(HYCartsModel *cartsModel) {
       
        if (cartsModel) {
            
            //有数据
            self.cartsModel = cartsModel;
            [self.view addSubview:self.bottomView];

            [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.bottom.equalTo(self.view);
                make.height.mas_equalTo(60 * WIDTH_MULTIPLE);
            }];
        }
        
        [_tableView reloadData];
    }];
    
    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 andPage:5 order:nil hotsale:nil complectionBlock:^(NSArray *datalist) {
        
        [_goodsList addObjectsFromArray:datalist];
        [self.tableView reloadData];
    }];
}

#pragma mark - action
- (void)editBtnAction:(UIBarButtonItem *)barButtonItem{
    
    
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (!_cartsModel) {
        
        _tableCount = 3;
        return _tableCount;
    }
    _tableCount = self.cartsModel.cartSellers.count + 2;
    DLog(@"section count %ld",(long)_tableCount);
    return _tableCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        //空购物车
        static NSString *noGoodsCellID = @"noGoodsCellID";
        HYNoGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noGoodsCellID];
        if (!cell) {
            cell = [[HYNoGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noGoodsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (_cartsModel) {
            cell.hidden = YES;
        }
        return cell;
    }
    else if (indexPath.section == _tableCount - 1){
        
        //猜你喜欢
        static NSString *goodsCellID = @"goodsCellID";
        HYHomeDoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCellID];
        if (!cell) {
            cell = [[HYHomeDoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.datalist = self.goodsList;
        cell.collectionSelect = ^(NSString *productID) {
            
            HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
            detailVC.navigationController.navigationBar.hidden = YES;
            detailVC.goodsID = productID;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        return cell;
    }
    else{
        
        //购物车
        static NSString *cartsCellID = @"cartsCellID";
        HYShoppingCartsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cartsCellID];
        if (!cell) {
            cell = [[HYShoppingCartsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cartsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSDictionary *dict = _cartsModel.cartSellers[indexPath.section - 1];
        HYCartsSeller *cartSeller = [HYCartsSeller modelWithDictionary:dict];
        cell.cartsSeller = cartSeller;
        
        if (!_cartsModel) {
            cell.hidden = YES;
        }
        return cell;
    }
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_cartsModel) {
        
        //购物车无商品
        if (indexPath.section == 0) {
            
            return 240 * WIDTH_MULTIPLE;
        }
        else if(indexPath.section == 1){
            
            return 0;
        }
        else{
            
            //猜你喜欢
            CGFloat height = ceil(_goodsList.count / 2.0) * 350 * WIDTH_MULTIPLE;
            return 40 + 10 + height;
        }
    }
    else{
        
        if (indexPath.section == 0) {
            
            return 0;
        }
        else if(indexPath.section == _tableCount - 1){
            
            //猜你喜欢
            CGFloat height = ceil(_goodsList.count / 2.0) * 350 * WIDTH_MULTIPLE;
            return 40 + 10 + height;
        }
        else{
            
            NSDictionary *dict = _cartsModel.cartSellers[indexPath.section - 1];
            HYCartsSeller *cartSeller = [HYCartsSeller modelWithDictionary:dict];
            CGFloat height = 30 * WIDTH_MULTIPLE + cartSeller.cartItems.count * 80 * WIDTH_MULTIPLE;
            DLog(@"%ld行购物车高度%f",(long)indexPath.row,height);
            return height;
        }
    }
    
    
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
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (HYCartsBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [HYCartsBottomView new];
    }
    return _bottomView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
