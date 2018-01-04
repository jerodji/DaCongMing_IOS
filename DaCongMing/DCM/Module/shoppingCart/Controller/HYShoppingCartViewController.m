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
#import "HYDeleteCartsView.h"

@interface HYShoppingCartViewController () <UITableViewDelegate,UITableViewDataSource,HYSelectCartSellerDelegate,HYSelectCartItemDelegate>

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
/** 删除 */
@property (nonatomic,strong) HYDeleteCartsView *deleteCartsView;
/** 结算时guid */
@property (nonatomic,strong) NSMutableString *guidStr;

@end

@implementation HYShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"购物车";
    [self setupSubviews];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    self.guidStr = [NSMutableString stringWithFormat:@""];
    [self requestShoppingCartsData];
    [self cartsAmountClaculate];
    [self payShoppiingCarts];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:KAddShoppingCartsSuccess object:nil];
    
    NSString  *cartsCount = [HYMyUserInfo sharedInstance].cartItemNum;
    if ([cartsCount integerValue] > 0) {
        
        self.tabBarItem.badgeValue = cartsCount;
    }
    else{
        self.tabBarItem.badgeValue = nil;
    }
}


- (void)setupSubviews{
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)setupBottomView{
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.title = @"编辑";
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.deleteCartsView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(60 * WIDTH_MULTIPLE);
    }];
    _bottomView.checkAllBtn.selected = NO;

    
    [_deleteCartsView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.top.equalTo(_bottomView);
    }];
    _deleteCartsView.hidden = YES;
}



#pragma mark - networkRequest
- (void)refreshData:(NSNotification *)notificaton{
    
    [self requestShoppingCartsData];
    
    NSString  *cartsCount = notificaton.object;
    if ([cartsCount integerValue] > 0) {
        
        self.tabBarItem.badgeValue = cartsCount;
    }
    else{
        self.tabBarItem.badgeValue = nil;
    }
}

- (void)requestShoppingCartsData{
    
    [HYCartsHandle showMyShoppingCartsWithComplectionBlock:^(HYCartsModel *cartsModel) {
       
        if (cartsModel.cartSellers.count) {
            
            //购物车有数据
            self.cartsModel = cartsModel;
            [self setupBottomView];
            _bottomView.hidden = NO;
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
               
                make.bottom.equalTo(self.view).offset(-60 * WIDTH_MULTIPLE);
            }];
            
        }
        else{
            
            _bottomView.hidden = YES;
            _deleteCartsView.hidden = YES;
            [_cartsSellerArray removeAllObjects];
            _cartsSellerArray = nil;
            
            self.navigationItem.rightBarButtonItem = nil;
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {

                make.bottom.equalTo(self.view);
            }];
        }
        
        [_tableView reloadData];
    }];
    
    [HYGoodsHandle requestGoodsListItem_type:@"001" pageNo:1 sortType:@"0" keyword:nil complectionBlock:^(NSArray *datalist) {
        
        [self.goodsList removeAllObjects];
        [self.goodsList addObjectsFromArray:datalist];
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

#pragma mark - 计算购物车总金额
- (void)cartsAmountClaculate{
    
    __weak typeof (self) weakSelf = self;
    self.bottomView.amount = @"0.00";
    self.bottomView.checkAllBlock = ^(BOOL isCheckAll) {
        
        weakSelf.guidStr = [NSMutableString stringWithFormat:@""];
        for (NSInteger i = 0; i < weakSelf.cartsSellerArray.count; i++) {
            
            HYCartsSeller *cartsSeller = weakSelf.cartsSellerArray[i];
            cartsSeller.isSelect = isCheckAll;
            NSMutableArray *tempArray = [NSMutableArray array];
            for (HYCartItems *items in cartsSeller.cartItems) {
                
                items.isSelect = isCheckAll;
                if (isCheckAll) {
                    
                    [weakSelf.guidStr appendString:items.guid];
                    [weakSelf.guidStr appendString:@","];
                }
                [tempArray addObject:items];
            }
            cartsSeller.cartItems = tempArray;
            [weakSelf.cartsSellerArray replaceObjectAtIndex:i withObject:cartsSeller];
        
        }
        [weakSelf.tableView reloadData];

        
        if ([weakSelf.guidStr isNotBlank]) {
            
            [HYCartsHandle calculateCartsAmountWithGuid:weakSelf.guidStr ComplectionBlock:^(NSString *amount) {
                
                weakSelf.bottomView.amount = amount;
            }];
        }
        else{
            
            weakSelf.bottomView.amount = @"0.00";
            weakSelf.guidStr = [NSMutableString stringWithFormat:@""];
        }
        
    };
}

//移除购物车
- (void)deleteCartsCheckAllAction{
    
    __weak typeof (self) weakSelf = self;
    self.deleteCartsView.deleteCheckAllBlock  = ^(BOOL isCheckAll) {
        
        
        weakSelf.guidStr = [NSMutableString stringWithFormat:@""];
        for (NSInteger i = 0; i < weakSelf.cartsSellerArray.count; i++) {
            
            HYCartsSeller *cartsSeller = weakSelf.cartsSellerArray[i];
            cartsSeller.isSelect = isCheckAll;
            NSMutableArray *tempArray = [NSMutableArray array];
            for (HYCartItems *items in cartsSeller.cartItems) {
                
                items.isSelect = isCheckAll;
                if (isCheckAll) {
                    
                    [weakSelf.guidStr appendString:items.guid];
                    [weakSelf.guidStr appendString:@","];
                }
                [tempArray addObject:items];
            }
            cartsSeller.cartItems = tempArray;
            [weakSelf.cartsSellerArray replaceObjectAtIndex:i withObject:cartsSeller];
            
        }
        [weakSelf.tableView reloadData];
    };
    
    self.deleteCartsView.deleteBlock = ^{
        
        [weakSelf deleteCartsAction];
    };
}

- (void)deleteCartsAction{
    
    if ([self.guidStr isNotBlank]) {
        
        HYCustomAlert *customAlert = [[HYCustomAlert alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) WithTitle:@"温馨提示" content:@"确定要删除所选产品吗?" confirmBlock:^{
           
            
            [HYCartsHandle deleteCartsAmountWithGuids:self.guidStr ComplectionBlock:^(BOOL isSuccess,NSString *cartsCount) {
                
                if (isSuccess) {
                    
                    [self requestShoppingCartsData];
                    if ([cartsCount integerValue] > 0) {
                        
                        self.tabBarItem.badgeValue = cartsCount;
                    }
                    else{
                        
                        self.tabBarItem.badgeValue = nil;
                    }
                    
                }
                else{
                    
                    [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"移除购物车出现问题"];
                }
            }];
        }];
        
        [KEYWINDOW addSubview:customAlert];
        [customAlert showCustomAlert];
    }
    else{
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请选择项目后删除"];
    }
}


#pragma mark - 计算购物车选中的价格
- (void)calcaluteShoppingCartsAmount{
    
    self.guidStr = [NSMutableString stringWithFormat:@""];
    NSMutableArray *tempArray = [NSMutableArray array];
    //所有的商家
    for (NSInteger i = 0; i < self.cartsSellerArray.count; i++) {
        
        HYCartsSeller *cartsSeller = self.cartsSellerArray[i];
        NSMutableArray *cartItemsArray = [NSMutableArray array];
        for (NSInteger j = 0; j < cartsSeller.cartItems.count; j++) {
            
            HYCartItems *cartItems = cartsSeller.cartItems[j];
            if (cartItems.isSelect) {
                
                [self.guidStr appendString:cartItems.guid];
                [self.guidStr appendString:@","];
            }
            else{
                cartsSeller.isSelect = NO;
                self.bottomView.checkAllBtn.selected = NO;
            }
            [cartItemsArray addObject:cartItems];
        }
        cartsSeller.cartItems = cartItemsArray;
        [tempArray addObject:cartsSeller];
    }
    [self.cartsSellerArray removeAllObjects];
    [self.cartsSellerArray addObjectsFromArray:tempArray];
    
    [_tableView reloadData];
    
    if ([self.guidStr isNotBlank]) {
        
        [HYCartsHandle calculateCartsAmountWithGuid:self.guidStr ComplectionBlock:^(NSString *amount) {
            
            self.bottomView.amount = amount;
        }];
    }
    else{
        
        self.bottomView.amount = @"0.00";
    }
    
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
    
    [self calcaluteShoppingCartsAmount];
    [_tableView reloadData];
}

#pragma mark - 点击单个项目delegate
- (void)cartItemSelect:(BOOL)isSelect WithIndexPath:(NSIndexPath *)indexPath{
    
    HYCartsSeller *cartSeller = _cartsSellerArray[indexPath.section - 1];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i < cartSeller.cartItems.count; i++) {
        
        HYCartItems *items = cartSeller.cartItems[i];
        if (i == indexPath.row) {
            
            items.isSelect = isSelect;
        }
        [tempArray addObject:items];
    }
    cartSeller.cartItems = tempArray;
    [_cartsSellerArray replaceObjectAtIndex:indexPath.section - 1 withObject:cartSeller];
    
    [self calcaluteShoppingCartsAmount];
    [_tableView reloadData];
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
        
        if (_cartsSellerArray.count) {
            
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
        cell.delegate = self;
        if (!_cartsSellerArray.count) {
            
            cell.hidden = YES;
        }
        return cell;
    }
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"cartsItemCell"]) {
        
        HYCartsSeller *cartsSeller = _cartsSellerArray[indexPath.section - 1];
        HYCartItem *item = cartsSeller.cartItems[indexPath.row];
        HYGoodsDetailInfoViewController *detailVC = [HYGoodsDetailInfoViewController new];
        detailVC.goodsID = item.item_id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
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
            CGFloat height = ceil(_goodsList.count / 2.0) * 340 * WIDTH_MULTIPLE;
            return  height + 40 * WIDTH_MULTIPLE;
        }
    }
    else{
        
        if (indexPath.section == 0) {
            
            return 0;
        }
        else if(indexPath.section == _tableCount - 1){
            
            //猜你喜欢
            CGFloat height = ceil(_goodsList.count / 2.0) * 350 * WIDTH_MULTIPLE;
            return  height + 40 * WIDTH_MULTIPLE;
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


#pragma mark - editingMode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.rightBarButtonItem.title = editing ? @"完成" : @"编辑" ;
    self.bottomView.hidden = editing;
    self.deleteCartsView.hidden = !editing;
    if (editing) {
        
        [self deleteCartsCheckAllAction];
    }
    
    for (NSInteger i = 0; i < self.cartsSellerArray.count; i++) {
        
        HYCartsSeller *cartsSeller = self.cartsSellerArray[i];
        cartsSeller.isEditing = editing;
        NSMutableArray *tempArray = [NSMutableArray array];
        for (HYCartItems *items in cartsSeller.cartItems) {
            
            items.isEditing = editing;
            [tempArray addObject:items];
        }
        cartsSeller.cartItems = tempArray;
        [self.cartsSellerArray replaceObjectAtIndex:i withObject:cartsSeller];
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

- (HYDeleteCartsView *)deleteCartsView{
    
    if (!_deleteCartsView) {
        
        _deleteCartsView = [HYDeleteCartsView new];
    }
    return _deleteCartsView;
}

- (NSMutableArray *)cartsSellerArray{
    
    if (!_cartsSellerArray) {
        
        _cartsSellerArray = [NSMutableArray array];
    }
    return _cartsSellerArray;
}

- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (NSMutableArray *)goodsList{
    
    if (!_goodsList) {
        
        _goodsList = [NSMutableArray array];
    }
    return _goodsList;
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
