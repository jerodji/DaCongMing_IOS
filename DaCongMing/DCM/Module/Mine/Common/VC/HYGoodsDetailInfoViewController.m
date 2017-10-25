//
//  HYGoodsDetailInfoViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGoodsDetailInfoViewController.h"

#import "HYProductsImageCell.h"
#import "HYProductsInfoTableViewCell.h"
#import "HYProductsSpecificationCell.h"
#import "HYProductsImageDetailCell.h"

#import "HYGoodsItemImage.h"
#import "HYGoodsDetailBottomView.h"
#import "HYGoodSpecificationSelectView.h"
#import "HYFillOrderViewController.h"
#import "HYBrandShopViewController.h"
#import "HYShareView.h"

@interface HYGoodsDetailInfoViewController () <UITableViewDelegate,UITableViewDataSource,HYGoodsSpecificationSelectDelegate>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *datalist;
/** back */
@property (nonatomic,strong) UIButton *backBtn;
/** share */
@property (nonatomic,strong) UIButton *shareBtn;
/** 商品详情model */
@property (nonatomic,strong) HYGoodsDetailModel *detailModel;
/** 评论model */
@property (nonatomic,strong) HYCommentModel *commentModel;
/** 图片 */
@property (nonatomic,strong) NSMutableArray *imageArray;
/** 图片详情 */
@property (nonatomic,strong) NSMutableArray *imageDetailArray;
/** 底部View */
@property (nonatomic,strong) HYGoodsDetailBottomView *bottomView;
/** 选择规格View */
@property (nonatomic,strong) HYGoodSpecificationSelectView *selectSpeciView;
/** shareView */
@property (nonatomic,strong) HYShareView *shareView;
/** 顶部导航 */
@property (nonatomic,strong) UIView *barView;
/** titleLabel */
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation HYGoodsDetailInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
    [self requestNetwork];
    [self setupMasonryLayout];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}

- (void)setupSubviews{
    
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.barView];
    [self.view addSubview:self.tableView];
    [self.barView addSubview:self.backBtn];
    [self.barView addSubview:self.shareBtn];
    [self.view bringSubviewToFront:self.barView];
    [self.view addSubview:self.bottomView];
}

- (void)requestNetwork{
    
    [HYGoodsHandle requestProductsDetailWithGoodsID:_goodsID andToken:nil complectionBlock:^(HYGoodsDetailModel *model, HYCommentModel *commentModel) {
       
        self.detailModel = model;
        self.commentModel = commentModel;
        for (NSDictionary *dict in model.item_images) {
            
            HYGoodsItemImage *imageModel = [HYGoodsItemImage modelWithDictionary:dict];
            if ([imageModel.image_type isEqualToString:@"item_image_prop1"]) {
                
                //上面的图片
                [self.imageArray addObject:imageModel.fileUrl];
            }
            else if ([imageModel.image_type isEqualToString:@"item_image_note"]){
                
                //图文详情
                [self.imageDetailArray addObject:imageModel.fileUrl];
            }
        }
        
        _bottomView.collectionBtn.selected = [model.isFavorite integerValue];
        [_tableView reloadData];
    }];
}

- (void)setupMasonryLayout{
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@40);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view).offset(-10 * WIDTH_MULTIPLE);
        make.top.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@40);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(60));
    }];
    
}

#pragma mark - action
- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction{
    
    
    [self.view addSubview:self.shareView];
    [self.shareView showShareView];
    
}

- (void)bottomBtnAction{
    
    __weak typeof (self)weakSelf = self;
    
    self.bottomView.buyNowAction = ^{
        
        [weakSelf.view addSubview:weakSelf.selectSpeciView];
        weakSelf.selectSpeciView.goodsModel = weakSelf.detailModel;
        weakSelf.selectSpeciView.isAddToCarts = NO;
        [weakSelf.selectSpeciView showGoodsSpecificationView];
    };
    
    self.bottomView.addToCartsAction = ^{
        
        [weakSelf.view addSubview:weakSelf.selectSpeciView];
        weakSelf.selectSpeciView.goodsModel = weakSelf.detailModel;
        weakSelf.selectSpeciView.isAddToCarts = YES;
        //规格
        [weakSelf.selectSpeciView showGoodsSpecificationView];

    };
    
    //收藏
    self.bottomView.collectAction = ^{
        
        if([HYUserHandle jumpToLoginViewControllerFromVC:weakSelf])
            return ;
        [HYGoodsHandle addToCollectionGoodsWithItemID:weakSelf.goodsID ComplectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                [UIView animateWithDuration:0.4 animations:^{
                    
                    weakSelf.bottomView.collectionBtn.transform = CGAffineTransformScale(weakSelf.bottomView.collectionBtn.transform, 1.4, 1.4);
                    weakSelf.bottomView.collectionBtn.selected = YES;


                } completion:^(BOOL finished) {
                    
                   weakSelf.bottomView.collectionBtn.transform = CGAffineTransformScale(weakSelf.bottomView.collectionBtn.transform, 1 / 1.4, 1 / 1.4);
                }];
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"添加收藏成功"];
            }
            else{
                weakSelf.bottomView.collectionBtn.selected = NO;
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"添加收藏失败"];
            }
        }];
    };
    
    self.bottomView.shoppingCartsAction = ^{
        
        if([HYUserHandle jumpToLoginViewControllerFromVC:weakSelf])
            return ;
        HYTabBarController *tabBarVC = [HYTabBarController new];
        tabBarVC.selectedIndex = 2;
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    };
    
    //品牌店铺
    self.bottomView.brandShopAction = ^{
        
        HYBrandShopViewController *brandShopVC = [HYBrandShopViewController new];
        brandShopVC.sellerID = weakSelf.detailModel.item_of_seller;
        [weakSelf.navigationController pushViewController:brandShopVC animated:YES];
    };
}

#pragma mark - HYGoodsSpecSelectDelegate
- (void)confirmGoodsSpeciSelectWithModel:(HYGoodsItemProp *)item buyCount:(NSInteger)count{
    
    if([HYUserHandle jumpToLoginViewControllerFromVC:self])
        return ;
    
    if (item) {
        
        if (_selectSpeciView.isAddToCarts) {
            
            [HYGoodsHandle addToShoppingCartsItemID:item.item_id count:count andUnit:item.unit ComplectionBlock:^(BOOL isSuccess) {
               
                if (isSuccess) {
                    
                    DLog(@"添加购物车成功");
                    [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"添加购物车成功"];
                }
                
                [_selectSpeciView removeFromSuperview];
            }];
        }
        else{
        
            HYFillOrderViewController *fillOrderVC = [[HYFillOrderViewController alloc] init];
            fillOrderVC.goodsDetailModel = _detailModel;
            fillOrderVC.specifical = item.unit;
            fillOrderVC.buyCount = count;
            [self.navigationController pushViewController:fillOrderVC animated:YES];
        }
       
    }
    else{
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请选择商品规格"];
    }
    
    
    

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
        
        //图片
        static NSString *imgCellID = @"imgCellID";
        HYProductsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:imgCellID];
        if (!cell) {
            cell = [[HYProductsImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imgCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.bannerArray = _imageArray;
        cell.title = _detailModel.item_name;
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString *productsInfo = @"productsInfo";
        HYProductsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productsInfo];
        if (!cell) {
            cell = [[HYProductsInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productsInfo];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSDictionary *dict =  _detailModel.item_prop[0];
        cell.price = [dict objectForKey:@"price"];
        cell.note = _detailModel.item_note;
        return cell;
    }
    else if (indexPath.row == 2){
        
        static NSString *specificationCellID = @"specificationCellID";
        HYProductsSpecificationCell *cell = [tableView dequeueReusableCellWithIdentifier:specificationCellID];
        if (!cell) {
            cell = [[HYProductsSpecificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:specificationCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.row == 3){
        
        static NSString *imageDetailCellID = @"imageDetailCellID";
        HYProductsImageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:imageDetailCellID];
        if (!cell) {
            cell = [[HYProductsImageDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageDetailCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.imageArray = _imageDetailArray;
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
    
    if (indexPath.row == 0) {
        
    }
    else if (indexPath.row == 1){
        
    }
    else if (indexPath.row == 2){
        //选规格
        [self.view addSubview:self.selectSpeciView];
        self.selectSpeciView.goodsModel = self.detailModel;
        self.selectSpeciView.isAddToCarts = NO;
        [self.selectSpeciView showGoodsSpecificationView];
    }
    else if (indexPath.row == 3){
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 500 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 1){
        
        return 70 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 2){
        
        return 50 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 3){
        
        HYProductsImageDetailCell *productsDetailCell = [[HYProductsImageDetailCell alloc] init];
        productsDetailCell.imageArray = _imageDetailArray;
        
        if (productsDetailCell.height == 0) {
            
            return 3000;
        }
        return productsDetailCell.height;
    }
    return 10;
}


#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 200) {
        
        UIColor *color = KAPP_NAV_COLOR;
        _barView.backgroundColor = [color colorWithAlphaComponent:offsetY / 500];
        [_shareBtn setImage:[UIImage imageNamed:@"product_share_white"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"product_back_white"] forState:UIControlStateNormal];
        _titleLabel.alpha = offsetY / 500;
    }
    else{
        
        UIColor *color = KAPP_NAV_COLOR;
        _barView.backgroundColor = [color colorWithAlphaComponent:0];
        [_shareBtn setImage:[UIImage imageNamed:@"product_share"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"product_back"] forState:UIControlStateNormal];
        _titleLabel.alpha = 0;
    }
}

#pragma mark - lazyload
- (UIButton *)backBtn{
    
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"product_back"] forState:UIControlStateNormal];
        _backBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)shareBtn{
    
    if (!_shareBtn) {
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"product_share"] forState:UIControlStateNormal];
        _shareBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, KSCREEN_WIDTH, KSCREEN_HEIGHT - 40) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (HYGoodsDetailBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[HYGoodsDetailBottomView alloc] init];
        [self bottomBtnAction];
    }
    return _bottomView;
}

- (HYGoodSpecificationSelectView *)selectSpeciView{
    
    if (!_selectSpeciView) {
        
        _selectSpeciView = [[HYGoodSpecificationSelectView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _selectSpeciView.delegate = self;
        
    }
    return _selectSpeciView;
}

- (HYShareView *)shareView{
    
    if (!_shareView) {
        
        _shareView = [[HYShareView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    }
    return _shareView;
}

- (NSMutableArray *)imageArray{
    
    if (!_imageArray) {
        
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSMutableArray *)imageDetailArray{
    
    if (!_imageDetailArray) {
        
        _imageDetailArray = [NSMutableArray array];
    }
    return _imageDetailArray;
}

- (UIView *)barView{
    
    if (!_barView) {
        
        _barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 64)];
        UIColor *color = KAPP_NAV_COLOR;
        _barView.backgroundColor = [color colorWithAlphaComponent:0];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, KSCREEN_WIDTH - 100, 44)];
        _titleLabel.text = @"商品详情";
        _titleLabel.font = KFitFont(16);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.alpha = 0;
        [_barView addSubview:_titleLabel];
    }
    return _barView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
