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
#import "HYOrderConfirmViewController.h"
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

@end

@implementation HYGoodsDetailInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
    [self requestNetwork];
    [self setupMasonryLayout];
    
    [self bottomBtnAction];
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
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.shareBtn];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.selectSpeciView];
    [self.view addSubview:self.shareView];
}

- (void)requestNetwork{
    
    [HYRequestGoodsList requestProductsDetailWithGoodsID:_goodsID andToken:nil complectionBlock:^(HYGoodsDetailModel *model) {
       
        self.detailModel = model;
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
        
        [_tableView reloadData];
    }];
}

- (void)setupMasonryLayout{
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self.view).offset(30 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@40);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view).offset(-10 * WIDTH_MULTIPLE);
        make.top.equalTo(self.view).offset(30 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@40);
    }];
    
  
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(60));
    }];
    
    [_selectSpeciView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
        make.height.equalTo(self.view);
    }];
    
    [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_top);
        make.height.equalTo(self.view);
    }];
}

#pragma mark - action
- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction{
    
    [self setupSubviews];
    [_shareView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self setupMasonryLayout];
        [self.view layoutIfNeeded];
    }];
}

- (void)bottomBtnAction{
    
    __weak typeof (self)weakSelf = self;
    self.bottomView.buyNowAction = ^{
        
        [weakSelf setupSubviews];
        weakSelf.selectSpeciView.goodsModel = weakSelf.detailModel;
        //规格
        [UIView animateWithDuration:0.2 animations:^{
            
            [weakSelf.selectSpeciView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.bottom.equalTo(weakSelf.view);
            }];
        }];
    };
}

#pragma mark - HYGoodsSpecSelectDelegate
- (void)confirmGoodsSpeciSelectWithModel:(HYGoodsItemProp *)item buyCount:(NSInteger)count{
    
    HYOrderConfirmViewController *orderConfirmVC = [[HYOrderConfirmViewController alloc] init];
    [self.navigationController pushViewController:orderConfirmVC animated:YES];
    
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
        
        [self setupSubviews];
        _selectSpeciView.goodsModel = _detailModel;
        [_selectSpeciView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.view);
        }];
        //规格
        [UIView animateWithDuration:0.2 animations:^{
           
            [self setupMasonryLayout];
            [self.view layoutIfNeeded];
        }];
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
        
    }
    return _bottomView;
}

- (HYGoodSpecificationSelectView *)selectSpeciView{
    
    if (!_selectSpeciView) {
        
        _selectSpeciView = [HYGoodSpecificationSelectView new];
        _selectSpeciView.delegate = self;
        
    }
    return _selectSpeciView;
}

- (HYShareView *)shareView{
    
    if (!_shareView) {
        
        _shareView = [HYShareView new];
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
