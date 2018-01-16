//
//  HYBrandShopHeaderView.m
//  DaCongMing
//
//

#import "HYBrandShopHeaderView.h"

@interface HYBrandShopHeaderView()

/** 背景图片 */
@property (nonatomic,strong) UIImageView *shopBgImgView;
/** icon */
@property (nonatomic,strong) UIImageView *shopIconImgView;
/** itemNameLabel */
@property (nonatomic,strong) UILabel *itemLabel;
/** 自营 */
@property (nonatomic,strong) UILabel *selfSellerLabel;
/** 收藏 */
@property (nonatomic,strong) UIButton *collectBtn;
/** 线 */
@property (nonatomic,strong) UIView *horizonLine;

@property (nonatomic,strong) UIButton *previousBtn;

@end

@implementation HYBrandShopHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
        [self createBrandShopButton];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.shopBgImgView];
    [self addSubview:self.shopIconImgView];
    [self addSubview:self.itemLabel];
    [self addSubview:self.selfSellerLabel];
    [self addSubview:self.collectBtn];
    
}

- (void)createBrandShopButton{
    
    NSArray *buttonTitleArray = @[@"首页",@"全部",@"热卖",@"新品"];
    CGFloat width = KSCREEN_WIDTH / 4;
    CGFloat buttonOrigin = self.height - 40 * WIDTH_MULTIPLE;
    for (NSInteger i = 0; i < buttonTitleArray.count; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, buttonOrigin, width, 40 * WIDTH_MULTIPLE)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:KAPP_b7b7b7_COLOR forState:UIControlStateNormal];
        [button setTitleColor:KCOLOR(@"272727") forState:UIControlStateSelected];
        [button addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 10;
        [self addSubview:button];
        
        if (button.tag == 10) {
            
            self.previousBtn = button;
            button.selected = YES;
        }
    }
    [self addSubview:self.horizonLine];
    
    for (NSInteger i = 0; i < buttonTitleArray.count - 1; i++) {
        
        UIView *view = [UIView new];
        view.backgroundColor = KAPP_7b7b7b_COLOR;
        view.frame = CGRectMake(width * i + width, buttonOrigin + 13 * WIDTH_MULTIPLE, 1, 14 * WIDTH_MULTIPLE);
        [self addSubview:view];
    }
}

- (void)layoutSubviews{
    
    [_shopBgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-40 * WIDTH_MULTIPLE);
    }];
    
    [_shopIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(55 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(12 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(50 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
        
    }];
    
    [_itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_shopIconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_shopIconImgView);
        make.height.mas_equalTo(25 * WIDTH_MULTIPLE);
        make.right.equalTo(_collectBtn.mas_left);
    }];
    
    [_selfSellerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_shopIconImgView.mas_bottom);
        make.left.equalTo(_itemLabel);
        make.height.mas_equalTo(15 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(40);
    }];
    
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.bottom.equalTo(_selfSellerLabel);
        make.size.mas_offset(CGSizeMake(60 * WIDTH_MULTIPLE, 24 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - setter
- (void)setStoreInfo:(HYBrandShopStoreInfo *)storeInfo{
    
    _storeInfo = storeInfo;
    [_shopBgImgView sd_setImageWithURL:[NSURL URLWithString:storeInfo.wall_img] placeholderImage:[UIImage imageNamed:@"forest"]];
    [_shopIconImgView sd_setImageWithURL:[NSURL URLWithString:storeInfo.store_logo] placeholderImage:[UIImage imageNamed:@"iconPlaceholder"]];
    _itemLabel.text = storeInfo.seller_name;
    self.collectBtn.selected = [_storeInfo.isFavorite integerValue];
}

#pragma mark - action
- (void)collectBtnAction:(UIButton *)button{
    
    if (![[HYUserModel sharedInstance].token isNotBlank]) {
        
        [JRToast showWithText:@"请登录后操作"];
        return;
    }
    BOOL isCollect = [self.storeInfo.isFavorite boolValue];
    if (isCollect) {
        
        [HYGoodsHandle cancelCollectShopWithSellerIDs:self.storeInfo.seller_id ComplectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                button.selected = NO;
                self.storeInfo.isFavorite = @"0";
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"取消收藏成功"];
            }
        }];
    }
    else{
        
        [HYGoodsHandle collectShopWithSellerID:self.storeInfo.seller_id ComplectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                button.selected = YES;
                self.storeInfo.isFavorite = @"1";
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"收藏店铺成功"];
            }
        }];
    }

}

- (void)topButtonAction:(UIButton *)button{
    
    self.previousBtn.selected = NO;
    button.selected = YES;
    self.previousBtn = button;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.horizonLine.frame = CGRectMake(button.left, button.bottom, button.width, 2);
    }];
    if (self.topBtnSelectBlock) {
        
        self.topBtnSelectBlock(button.tag - 10);
    }
}

#pragma mark - lazyload
- (UIImageView *)shopBgImgView{
    
    if (!_shopBgImgView) {
        
        _shopBgImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _shopBgImgView.contentMode = UIViewContentModeScaleAspectFill;
        _shopBgImgView.clipsToBounds = YES;
        _shopBgImgView.image = [UIImage imageNamed:@"forest"];
    }
    return _shopBgImgView;
}

- (UIView *)horizonLine{
    
    if (!_horizonLine) {
        
        _horizonLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom - 4, self.width / 4, 2)];
        _horizonLine.backgroundColor = KCOLOR(@"383938");
    }
    return _horizonLine;
}

- (UIImageView *)shopIconImgView{
    
    if (!_shopIconImgView) {
        
        _shopIconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _shopIconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _shopIconImgView.clipsToBounds = YES;
        _shopIconImgView.image = [UIImage imageNamed:@"iconPlaceholder"];
    }
    
    return _shopIconImgView;
}

- (UILabel *)itemLabel{
    
    if (!_itemLabel) {
        
        _itemLabel = [UILabel new];
        _itemLabel.text = @"海林官方旗舰店";
        _itemLabel.textColor = KAPP_WHITE_COLOR;
        _itemLabel.font = KFitFont(14);
        _itemLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _itemLabel;
}

- (UILabel *)selfSellerLabel{
    
    if (!_selfSellerLabel) {
        
        _selfSellerLabel = [UILabel new];
        _selfSellerLabel.text = @"自营";
        _selfSellerLabel.textColor = KAPP_WHITE_COLOR;
        _selfSellerLabel.font = KFitFont(10);
        _selfSellerLabel.backgroundColor = KAPP_THEME_COLOR;
        _selfSellerLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _selfSellerLabel;
}

- (UIButton *)collectBtn{
    
    if (!_collectBtn) {
        
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"collect_yes"] forState:UIControlStateSelected];
        [_collectBtn addTarget:self action:@selector(collectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

@end
