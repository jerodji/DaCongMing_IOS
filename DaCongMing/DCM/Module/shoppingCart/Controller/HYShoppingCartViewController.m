//
//  HYShoppingCartViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYShoppingCartViewController.h"
#import "HYGoodsDetailInfoViewController.h"
#import "HYFillOrderViewController.h"
#import "HYShoppingCartsSellerView.h"
#import "HYNoGoodsTableViewCell.h"
#import "HYHomeDoodsCell.h"
#import "HYShoppingCartsTableViewCell.h"
#import "HYCartsItemTableViewCell.h"
#import "HYCartsBottomView.h"
#import "HYCartsHandle.h"
#import "HYCartsModel.h"
#import "HYMyUserInfo.h"

@interface HYShoppingCartViewController () <UITableViewDelegate,UITableViewDataSource,HYSelectCartSellerDelegate>

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
/** cartsSellerArray */
@property (nonatomic,strong) NSMutableArray *cartsSellerArray;
/** 底部结算 */
@property (nonatomic,strong) HYCartsBottomView *bottomView;
/** 结算时guid */
@property (nonatomic,strong) NSMutableString *guidStr;

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
    
    if ([[HYMyUserInfo sharedInstance].cartItemNum integerValue] > 1) {
        
        self.tabBarItem.badgeValue = [HYMyUserInfo sharedInstance].cartItemNum;

    }
    [self requestShoppingCartsData];
    [self cartsAmountClaculate];
    [self payShoppiingCarts];
}

- (void)setupData{
    
    _datalist = [NSMutableArray array];
    _goodsList = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleCartsChanged:) name:KShoppingCartsChanged object:nil];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.title = @"编辑";
    
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


- (void)requestShoppingCartsData{
    
    [HYCartsHandle showMyShoppingCartsWithComplectionBlock:^(HYCartsModel *cartsModel) {
       
        if (cartsModel.cartSellers.count) {
            
            //购物车有数据
            self.cartsModel = cartsModel;
            [self setupSubviews];
            [self.view addSubview:self.bottomView];
            [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.bottom.equalTo(self.view);
                make.height.mas_equalTo(60 * WIDTH_MULTIPLE);
            }];
            _bottomView.checkAllBtn.selected = NO;
            
        }
        else{
            
            [_bottomView removeFromSuperview];
            _bottomView = nil;
        }
        
        [_tableView reloadData];
    }];
    
    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 andPage:5 order:nil hotsale:nil complectionBlock:^(NSArray *datalist) {
        
        [_goodsList addObjectsFromArray:datalist];
        [self.tableView reloadData];
    }];
}

#pragma mark - 对数据处理

- (void)setCartsModel:(HYCartsModel *)cartsModel{
    
    _cartsModel = cartsModel;
    [self.cartsSellerArray removeAllObjects];
    NSMutableArray *tempArray = [NSMutableArray array];
    //所有的商家
    for (NSInteger i = 0; i < self.cartsModel.cartSellers.count; i++) {
        
        NSDictionary *dict = self.cartsModel.cartSellers[i];
        HYCartsSeller *cartsSeller = [HYCartsSeller modelWithDictionary:dict];
        NSMutableArray *cartItemsArray = [NSMutableArray array];
        for (NSDictionary *itemDict in cartsSeller.cartItems) {
                
            HYCartItems *cartItems = [HYCartItems modelWithDictionary:itemDict];
            [cartItemsArray addObject:cartItems];
        }
        cartsSeller.cartItems = cartItemsArray;
        [tempArray addObject:cartsSeller];
    }
    [self.cartsSellerArray addObjectsFromArray:tempArray];
}

#pragma mark - action
- (void)editBtnAction:(UIBarButtonItem *)barButtonItem{
    
    
}

//计算总金额
- (void)cartsAmountClaculate{
    
    __weak typeof (self) weakSelf = self;
    self.bottomView.amount = @"0.00";
    self.bottomView.checkAllBlock = ^(BOOL isCheckAll) {
        
        weakSelf.guidStr = [NSMutableString stringWithFormat:@""];
        for (NSInteger i = 0; i < weakSelf.cartsSellerArray.count; i++) {
            
            HYCartsSeller *cartsSeller = weakSelf.cartsSellerArray[i];
            cartsSeller.isSelect = isCheckAll;
            [weakSelf.cartsSellerArray replaceObjectAtIndex:i withObject:cartsSeller];
            
            for (NSDictionary *dict in cartsSeller.cartItems) {
                
                HYCartItems *items = [HYCartItems modelWithDictionary:dict];
                [weakSelf.guidStr appendString:items.guid];
                [weakSelf.guidStr appendString:@","];
                
            }
        }
        
        if (isCheckAll) {
            
            [HYCartsHandle calculateCartsAmountWithGuid:weakSelf.guidStr ComplectionBlock:^(NSString *amount) {
                
                weakSelf.bottomView.amount = amount;
            }];
        }
        else{
            
            weakSelf.bottomView.amount = @"0.00";
            weakSelf.guidStr = [NSMutableString stringWithFormat:@""];
        }
        
        [weakSelf.tableView reloadData];
    };
}

//商家购物车变化
- (void)shoppingCartsChanged{
    
    self.guidStr = [NSMutableString stringWithFormat:@""];
    for (HYCartsSeller *seller in self.cartsSellerArray) {
        
        if (seller.isSelect) {
            
            for (NSDictionary *dict in seller.cartItems) {
                
                HYCartItems *items = [HYCartItems modelWithDictionary:dict];
        
                [self.guidStr appendString:items.guid];
                [self.guidStr appendString:@","];
            }
        }
        
    }
    
    if ([self.guidStr isNotBlank]) {
        
        [HYCartsHandle calculateCartsAmountWithGuid:self.guidStr ComplectionBlock:^(NSString *amount) {
            
            self.bottomView.amount = amount;
        }];
    }
    else{
        
        self.bottomView.amount = @"0.00";
    }
    
    [_tableView reloadData];
}

//购物车结算
- (void)payShoppiingCarts{
    
    __weak typeof (self)weakSelf = self;
    self.bottomView.payAction = ^{
        
        if ([weakSelf.guidStr isNotBlank]) {
            
            HYFillOrderViewController *fillOrderVC = [HYFillOrderViewController new];
            [weakSelf.navigationController pushViewController:fillOrderVC animated:YES];
            fillOrderVC.guids = weakSelf.guidStr;
            
        }
        else{
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请选择需要结算的商品"];
        }
    };
}

#pragma mark - Notification
//单个购物车变化
- (void)singleCartsChanged:(NSNotification *)notification{
    
    NSString *changedGuid = [NSString stringWithFormat:@"%@,",notification.object];
    NSRange range = [self.guidStr rangeOfString:changedGuid];
    if ([self.guidStr containsString:changedGuid]) {
        
        [self.guidStr deleteCharactersInRange:range];
    }
    else{
        [self.guidStr appendString:changedGuid];
    }
    
    if ([self.guidStr isNotBlank]) {
        
        [HYCartsHandle calculateCartsAmountWithGuid:self.guidStr ComplectionBlock:^(NSString *amount) {
            
            self.bottomView.amount = amount;
        }];
    }
    else{
        
        self.bottomView.amount = @"0.00";
    }
    
}

//修改购物车数量成功
- (void)cartsCountChanged:(NSNotification *)notification{
    
    [self requestShoppingCartsData];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (!_cartsSellerArray.count) {
        
        _tableCount = 3;
        return _tableCount;
    }
    _tableCount = _cartsSellerArray.count + 2;
    return _tableCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 || section == _tableCount - 1) {
        
        return 1;
    }
    else{
        
        if (_cartsSellerArray) {
            
            HYCartsSeller *cartsSeller = _cartsSellerArray[section-1];
            return cartsSeller.cartItems.count;
        }
        else{
            
            return 1;
        }
    }
    
    
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
        
        if (_cartsSellerArray.count) {
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
        cell.title = @"为你精选";
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
        static NSString *cartsItemCellID = @"cartsItemCell";
        HYCartsItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cartsItemCellID];
        if (!cell) {
            cell = [[HYCartsItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cartsItemCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        HYCartsSeller *cartsSeller = _cartsSellerArray[indexPath.section - 1];
        cell.items = cartsSeller.cartItems[indexPath.row];
        cell.indexPath = indexPath;
        if (!_cartsSellerArray.count) {
            
            cell.hidden = YES;
        }
        return cell;
    }
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_cartsSellerArray) {
        
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
            
            return 80 * WIDTH_MULTIPLE;
        }
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HYShoppingCartsSellerView *cartSellerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HYCartsSellerHeaderView"];
    if (!cartSellerView) {
        
        cartSellerView = [[HYShoppingCartsSellerView alloc] initWithReuseIdentifier:@"HYCartsSellerHeaderView"];
    }
    
    HYCartsSeller *cartSellerModel = _cartsSellerArray[section - 1];
    cartSellerView.cartsSeller = cartSellerModel;
    cartSellerView.delegate = self;
    cartSellerView.index = section - 1;
    if (!_cartsSellerArray) {
        
        cartSellerView.hidden = YES;
    }
    return cartSellerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0 || section == _tableCount - 1) {
        
        return 0;
    }
    else{
        
        if (_cartsSellerArray) {
            
            return 40 * WIDTH_MULTIPLE;
        }
        else{
            
            return 0;
        }
    }
    
    return 0;
}

#pragma mark - tableViewEditing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - 全选每个商家delegate
- (void)cartSellerSelect:(BOOL)isSelect WithIndexPath:(NSInteger )index{
    
    HYCartsSeller *cartSeller = _cartsSellerArray[index];
    cartSeller.isSelect = isSelect;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (HYCartItems *items in cartSeller.cartItems) {
        
        items.isSelect = isSelect;
        [tempArray addObject:items];
    }
    cartSeller.cartItems = tempArray;
    [_cartsSellerArray replaceObjectAtIndex:index withObject:cartSeller];
    [_tableView reloadData];
    
}

#pragma mark - editingMode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    if (editing) {
        
        [self.tableView setEditing:YES animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"完成";
        
        [self.cartsSellerArray removeAllObjects];
        for (NSInteger i = 0; i < self.cartsModel.cartSellers.count; i++) {
            
            NSDictionary *dict = self.cartsModel.cartSellers[i];
            HYCartsSeller *cartsSeller = [HYCartsSeller modelWithDictionary:dict];
            cartsSeller.isEditing = YES;
            [self.cartsSellerArray addObject:cartsSeller];
        }
        [_tableView reloadData];
    }
    else {
        //点击完成按钮
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        [self.cartsSellerArray removeAllObjects];
        for (NSInteger i = 0; i < self.cartsModel.cartSellers.count; i++) {
            
            NSDictionary *dict = self.cartsModel.cartSellers[i];
            HYCartsSeller *cartsSeller = [HYCartsSeller modelWithDictionary:dict];
            cartsSeller.isEditing = NO;
            [self.cartsSellerArray addObject:cartsSeller];
        }
        [_tableView reloadData];

    }
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

- (NSMutableArray *)cartsSellerArray{
    
    if (!_cartsSellerArray) {
        
        _cartsSellerArray = [NSMutableArray array];
    }
    return _cartsSellerArray;
}

- (NSMutableString *)guidStr{
    
    if (!_guidStr) {
        
        _guidStr = [NSMutableString string];
    }
    return _guidStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
