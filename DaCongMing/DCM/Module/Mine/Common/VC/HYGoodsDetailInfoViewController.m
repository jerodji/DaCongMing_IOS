//
//  HYGoodsDetailInfoViewController.m
//  DaCongMing
//
//

#import "HYGoodsDetailInfoViewController.h"

#import "HYProductsImageCell.h"
#import "HYProductsInfoTableViewCell.h"
#import "HYProductsSpecificationCell.h"
#import "HYProductsImageDetailCell.h"
#import "HYCommentTextCell.h"
#import "HYCommentCell.h"
#import "HYCommentLookMoreCell.h"

#import "HYGoodsItemImage.h"
#import "HYGoodsDetailBottomView.h"
#import "HYGoodSpecificationSelectView.h"
#import "HYFillOrderViewController.h"
#import "HYBrandShopViewController.h"
#import "HYShareView.h"
#import "HYAllCommentsVC.h"
#import "HYMineNetRequest.h"

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

<<<<<<< HEAD
- (void)setupMasonryLayout{
=======
- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(- KSafeAreaBottom_Height - 60);
    }];
>>>>>>> 1.1
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@40);
    }];
    
//    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.view).offset(-10 * WIDTH_MULTIPLE);
//        make.top.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
//        make.width.height.equalTo(@40);
//    }];
    
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
        
        if ([weakSelf.detailModel.isFavorite integerValue] == 0) {
            
            [HYGoodsHandle addToCollectionGoodsWithItemID:weakSelf.goodsID ComplectionBlock:^(BOOL isSuccess) {
                
                if (isSuccess) {
                    
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        weakSelf.bottomView.collectionBtn.transform = CGAffineTransformScale(weakSelf.bottomView.collectionBtn.transform, 1.4, 1.4);
                        weakSelf.bottomView.collectionBtn.selected = YES;
                        weakSelf.detailModel.isFavorite = @"1";
                        
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
        }
        else{
            
            [HYMineNetRequest deleteMyCollectionGoodsWithItemIDs:weakSelf.goodsID ComplectionBlock:^(BOOL isSuccess) {
                
                if (isSuccess) {
                    
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        weakSelf.bottomView.collectionBtn.transform = CGAffineTransformScale(weakSelf.bottomView.collectionBtn.transform, 1.4, 1.4);
                        weakSelf.bottomView.collectionBtn.selected = NO;
                        weakSelf.detailModel.isFavorite = @"0";

                        
                    } completion:^(BOOL finished) {
                        
                        weakSelf.bottomView.collectionBtn.transform = CGAffineTransformScale(weakSelf.bottomView.collectionBtn.transform, 1 / 1.4, 1 / 1.4);
                    }];
                    [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"取消收藏成功"];
                }
                else{
                    weakSelf.bottomView.collectionBtn.selected = YES;
                    [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"取消收藏失败"];
                }
            }];
        }
        
        
    };
    
    self.bottomView.shoppingCartsAction = ^{
        
        if([HYUserHandle jumpToLoginViewControllerFromVC:weakSelf])
            return ;
//        HYTabBarController *tabBarVC = [HYTabBarController new];
//        tabBarVC.selectedIndex = 2;
//        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
        
        [weakSelf contactServiceWithModel:weakSelf.goodsID];
    };
    
    //品牌店铺
    self.bottomView.brandShopAction = ^{
        
        HYBrandShopViewController *brandShopVC = [HYBrandShopViewController new];
        brandShopVC.sellerID = weakSelf.detailModel.item_of_seller;
        [weakSelf.navigationController pushViewController:brandShopVC animated:YES];
    };
}

//联系客服
- (void)contactServiceWithModel:(NSString *)productID{
    
    QYSource *source = [[QYSource alloc] init];
    source.title =  @"联系客服";
    source.urlString = @"https://8.163.com/";
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    
    sessionViewController.sessionTitle = @"联系客服";
    QYUserInfo *userInfo = [[QYUserInfo alloc] init];
    userInfo.userId = [HYUserModel sharedInstance].userInfo.id;
    NSMutableArray *array = [NSMutableArray new];
    NSMutableDictionary *dictRealName = [NSMutableDictionary new];
    [dictRealName setObject:@"real_name" forKey:@"key"];
    [dictRealName setObject:[HYUserModel sharedInstance].userInfo.name forKey:@"value"];
    [array addObject:dictRealName];
    
    NSMutableDictionary *dictMobilePhone = [NSMutableDictionary new];
    [dictMobilePhone setObject:@"mobile_phone" forKey:@"key"];
    [dictMobilePhone setObject:@"mobile_phone" forKey:@"key"];
    
    [dictMobilePhone setValue:[HYUserModel sharedInstance].userInfo.phone forKey:@"value"];
    [dictMobilePhone setObject:@(NO) forKey:@"hidden"];
    [array addObject:dictMobilePhone];
    
    NSMutableDictionary *orderDict = [NSMutableDictionary new];
    [orderDict setObject:@"productID" forKey:@"key"];
    [orderDict setObject:@"商品ID" forKey:@"label"];
    [orderDict setValue:productID forKey:@"value"];
    [array addObject:orderDict];
    
    NSMutableDictionary *userDict = [NSMutableDictionary new];
    [userDict setObject:@"userInfo" forKey:@"key"];
    [userDict setObject:@"用户ID" forKey:@"label"];
    [userDict setValue:[HYUserModel sharedInstance].userInfo.id forKey:@"value"];
    [array addObject:userDict];
    
    //    NSMutableDictionary *dictEmail = [NSMutableDictionary new];
    //    [dictEmail setObject:@"email" forKey:@"key"];
    //    [dictEmail setObject:@"bianchen@163.com" forKey:@"value"];
    //    [array addObject:dictEmail];
    
    //    NSMutableDictionary *dictAuthentication = [NSMutableDictionary new];
    //    [dictAuthentication setObject:@"0" forKey:@"index"];
    //    [dictAuthentication setObject:@"authentication" forKey:@"key"];
    //    [dictAuthentication setObject:@"实名认证" forKey:@"label"];
    //    [dictAuthentication setObject:@"已认证" forKey:@"value"];
    //    [array addObject:dictAuthentication];
    
    //    NSMutableDictionary *dictBankcard = [NSMutableDictionary new];
    //    [dictBankcard setObject:@"1" forKey:@"index"];
    //    [dictBankcard setObject:@"bankcard" forKey:@"key"];
    //    [dictBankcard setObject:@"绑定银行卡" forKey:@"label"];
    //    [dictBankcard setObject:@"622202******01116068" forKey:@"value"];
    //    [array addObject:dictBankcard];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:0
                                                     error:nil];
    if (data)
    {
        userInfo.data = [[NSString alloc] initWithData:data
                                              encoding:NSUTF8StringEncoding];
    }
    
    [[QYSDK sharedSDK] setUserInfo:userInfo];
    sessionViewController.source = source;
    [self.navigationController pushViewController:sessionViewController animated:YES];
}

#pragma mark - HYGoodsSpecSelectDelegate
- (void)confirmGoodsSpeciSelectWithModel:(HYGoodsItemProp *)item buyCount:(NSInteger)count{
    
    if([HYUserHandle jumpToLoginViewControllerFromVC:self])
        return ;
    
    if (item) {
        
        if (_selectSpeciView.isAddToCarts) {
            
            [HYGoodsHandle addToShoppingCartsItemID:item.item_id count:count andUnit:item.unit ComplectionBlock:^(BOOL isSuccess,NSString *cartsCount) {
                
                if (isSuccess) {
                    
                    DLog(@"添加购物车成功");
                    [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"添加购物车成功"];
                    
                    //发出通知，刷新购物车列表
                    [[NSNotificationCenter defaultCenter] postNotificationName:KAddShoppingCartsSuccess object:cartsCount];
                }
                
                [_selectSpeciView removeFromSuperview];
                _selectSpeciView = nil;
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
    
    return 7;
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
        //晒单评价
        static NSString *commentTextCellID = @"commentTextCellID";
        HYCommentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:commentTextCellID];
        if (!cell) {
            cell = [[HYCommentTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentTextCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.count = _commentModel.evaluateCount;
        if (!_commentModel) {
            cell.hidden = YES;
        }
        return cell;
    }
    else if (indexPath.row == 4){
        //评价内容
        static NSString *commentCellID = @"commentCellID";
        HYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
        if (!cell) {
            cell = [[HYCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.commentModel = _commentModel;
        if (!_commentModel) {
            cell.hidden = YES;
        }
        return cell;
    }
    else if (indexPath.row == 5){
        //查看更多
        static NSString *commentLookMoreCellID = @"commentLookMoreCellID";
        HYCommentLookMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:commentLookMoreCellID];
        if (!cell) {
            cell = [[HYCommentLookMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentLookMoreCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (!_commentModel) {
            cell.hidden = YES;
        }
        return cell;
    }
    else if (indexPath.row == 6){
        
        static NSString *imageDetailCellID = @"imageDetailCellID";
        HYProductsImageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:imageDetailCellID];
        if (!cell) {
            cell = [[HYProductsImageDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageDetailCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.imageArray = _imageDetailArray;
        return cell;
    }
    return nil;
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
    else if (indexPath.row == 5){
        
        HYAllCommentsVC *allCommentsVC = [HYAllCommentsVC new];
        allCommentsVC.productID = self.goodsID;
        [self.navigationController pushViewController:allCommentsVC animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 500 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 1){
        
        CGFloat strHeight = [_detailModel.item_note heightForFont:KFitFont(13) width:KSCREEN_WIDTH - 20 * WIDTH_MULTIPLE];
        return 40 * WIDTH_MULTIPLE + strHeight + 5;
    }
    else if (indexPath.row == 2){
        
        return 50 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 6){
        
        HYProductsImageDetailCell *productsDetailCell = [[HYProductsImageDetailCell alloc] init];
        productsDetailCell.imageArray = _imageDetailArray;
        
        if (productsDetailCell.height == 0) {
            
            return 4000;
        }
        return productsDetailCell.height;
    }
    
    if (_commentModel) {
        //有评价
        if (indexPath.row == 3) {
            
            return 48 * WIDTH_MULTIPLE;
        }
        
        if (indexPath.row == 4){
            
            
            return _commentModel.cellHeight;
        }
        
        if (indexPath.row == 5){
            
            return 40 * WIDTH_MULTIPLE;
        }
    }
    else{
        
        if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
            
            return 0;
        }
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
