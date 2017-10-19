
//
//  HYBrandShopViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBrandShopViewController.h"
#import "HYBrandShopNavView.h"
#import "HYShopCollectCell.h"
#import "HYShopImageCell.h"
#import "HYHomeBannerCell.h"
#import "HYHomeDoodsCell.h"
#import "HYBrandShopInfoModel.h"
#import "HYGoodsDetailInfoViewController.h"
#import "HYBrandShopBottomView.h"
#import "HYShareView.h"


@interface HYBrandShopViewController () <UITableViewDelegate,UITableViewDataSource,HYBrandsShopTapDelegate,HYShopCollectDelegate>

/** brandsShopNavView */
@property (nonatomic,strong) HYBrandShopNavView *brandsShopNavView;
/** 底部 */
@property (nonatomic,strong) HYBrandShopBottomView *bottomView;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** itemList */
@property (nonatomic,copy) NSArray *itemList;
/** infoModel */
@property (nonatomic,strong) HYBrandShopInfoModel *shopInfoModel;
/** bannerArray */
@property (nonatomic,strong) NSMutableArray *bannerArray;
/** share */
@property (nonatomic,strong) HYShareView *shareView;

@end

@implementation HYBrandShopViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self requestNetwork];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setupUI];
}

- (void)setupUI{
    
    [self.navigationController.navigationBar addSubview:self.brandsShopNavView];
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_brandsShopNavView removeFromSuperview];
    _brandsShopNavView = nil;
}

- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50 * WIDTH_MULTIPLE);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - network
- (void)requestNetwork{
    
    [self.bannerArray removeAllObjects];
    [HYGoodsHandle getBrandsShopWithSellerID:self.sellerID ComplectionBlock:^(NSDictionary *dict) {
       
        if (dict) {
            
            NSDictionary *storeInfo = [dict objectForKey:@"storeInfo"];
            NSArray *itemList = [dict objectForKey:@"itemList"];
            self.itemList = itemList;
            self.shopInfoModel = [HYBrandShopInfoModel modelWithDictionary:storeInfo];
            
            for (NSDictionary *itemDict in storeInfo[@"storeImages"]) {
                
                [self.bannerArray addObject:[itemDict objectForKey:@"image_url"]];
            }
            
            [_bottomView.allGoodsBtn setTitle:[NSString stringWithFormat:@"%@\n全部商品",self.shopInfoModel.itemCount] forState:UIControlStateNormal];
            [_bottomView.hotSaleBtn setTitle:[NSString stringWithFormat:@"%@\n热销",self.shopInfoModel.hotsaleCount] forState:UIControlStateNormal];
            [_bottomView.allGoodsBtn setTitle:[NSString stringWithFormat:@"%@\n上新",self.shopInfoModel.justItem] forState:UIControlStateNormal];
        }
        
        [_tableView reloadData];
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *shopCollectCellID = @"shopCollectCellID";
        HYShopCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:shopCollectCellID];
        if (!cell) {
            cell = [[HYShopCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopCollectCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.infoModel = self.shopInfoModel;
        cell.delegate = self;
        return cell;
    }
    else if (indexPath.row == 1){
        //banner
        static NSString *bannerID = @"HYBannerCell";
        HYHomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:bannerID];
        if (!cell) {
            cell = [[HYHomeBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bannerID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.bannerArray = self.bannerArray;
        return cell;
    }
    else if (indexPath.row == 2){
        
        static NSString *shopImageCellID = @"shopImageCellID";
        HYShopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:shopImageCellID];
        if (!cell) {
            cell = [[HYShopImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopImageCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;
    }
    else if(indexPath.row == 3){
        
        //猜你喜欢
        static NSString *goodsCellID = @"goodsCellID";
        HYHomeDoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCellID];
        if (!cell) {
            cell = [[HYHomeDoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.datalist = [self.itemList copy];
        cell.collectionSelect = ^(NSString *productID) {
            
            HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
            detailVC.navigationController.navigationBar.hidden = YES;
            detailVC.goodsID = productID;
            [self.navigationController pushViewController:detailVC animated:YES];
        };
        return cell;
    }
    static NSString *cellID = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 60 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 1){
        
        return 150 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 2){
        
        return 70 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 3){
        
        //猜你喜欢
        CGFloat height = ceil(self.itemList.count / 2.0) * 350 * WIDTH_MULTIPLE;
        return 10 + height;
    }
    return 10;
}

#pragma mark - BrandsNavDelegate
- (void)brandsShopNavBtnTapIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            
            break;
        case 2:
            
            [KEYWINDOW addSubview:self.shareView];
            [self.shareView showShareView];
            break;
        default:
            break;
    }
}

#pragma mark - searchDelegate
- (void)searchTextFieldTextChanged:(NSString *)text{
    
    
}

- (void)searchTextFieldResignFirstResponder{
    
    
    
}

- (void)searchTextFieldStartInput{
    
    
}

#pragma mark - 收藏delegate
- (void)shopCollectClick:(BOOL)isCollect{
    
    if([HYUserHandle jumpToLoginViewControllerFromVC:self])
        return ;
    
    if (isCollect) {
        
        [HYGoodsHandle cancelCollectShopWithSellerIDs:self.sellerID ComplectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"取消收藏成功"];
                [self requestNetwork];
            }
        }];
    }
    else{
        
        [HYGoodsHandle collectShopWithSellerID:self.sellerID ComplectionBlock:^(BOOL isSuccess) {
           
            if (isSuccess) {
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"收藏店铺成功"];
                
                [self requestNetwork];
            }
        }];
        
    }
}


#pragma mark - lazyload
- (HYBrandShopNavView *)brandsShopNavView{
    
    if (!_brandsShopNavView) {
        
        _brandsShopNavView = [[HYBrandShopNavView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
        _brandsShopNavView.delegate = self;
    }
    return _brandsShopNavView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KCOLOR(@"f6f6f6");
    }
    return _tableView;
}

- (NSMutableArray *)bannerArray{
    
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}

- (HYBrandShopBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [HYBrandShopBottomView new];
    }
    return _bottomView;
}

- (HYShareView *)shareView{
    
    if (!_shareView) {
        
        _shareView = [[HYShareView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"大聪明" forKey:@"shareTitle"];
        [dict setValue:[HYUserModel sharedInstance].userInfo.qrpath forKey:@"shareImgUrl"];
        [dict setObject:@"老铁，没毛病，双击666\n老铁，没毛病，双击666\n老铁，没毛病，双击666" forKey:@"shareDesc"];
        
        _shareView.shareDict = dict;
    }
    return _shareView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
