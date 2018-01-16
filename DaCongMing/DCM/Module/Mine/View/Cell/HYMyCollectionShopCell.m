//
//  HYMyCollectionShopCell.m
//  DaCongMing
//
//

#import "HYMyCollectionShopCell.h"
#import "HYMyCollectShopImageCollectionViewCell.h"

@interface HYMyCollectionShopCell()<UICollectionViewDelegate,UICollectionViewDataSource>

/** 背景 */
@property (nonatomic,strong) UIView *bgView;
/** icon图片 */
@property (nonatomic,strong) UIImageView *shopIconImgView;
/** nameLabel */
@property (nonatomic,strong) UILabel *nameLabel;
/** 自营 */
@property (nonatomic,strong) UILabel *selfSellerLabel;
/** 收藏 */
@property (nonatomic,strong) UIButton *collectBtn;
/** shopImg */
@property (nonatomic,strong) UIImageView *shopImgView;
/** line */
@property (nonatomic,strong) UIView *bottomLine;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HYMyCollectionShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        self.backgroundColor = KAPP_TableView_BgColor;
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgView];
    [self addSubview:self.shopIconImgView];
    [self addSubview:self.shopImgView];
    [self addSubview:self.collectBtn];
    [self addSubview:self.nameLabel];
    [self addSubview:self.selfSellerLabel];
    [self addSubview:self.bottomLine];
    [self addSubview:self.collectionView];
    
}

- (void)layoutSubviews{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.left.right.bottom.equalTo(self);
    }];
    
    [_shopIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(_bgView).offset(10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(35 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(35 * WIDTH_MULTIPLE);
    }];
    
    [_shopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_shopIconImgView);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(20 * WIDTH_MULTIPLE, 20 * WIDTH_MULTIPLE));
    }];
    
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.width.height.equalTo(_shopImgView);
        make.right.equalTo(_shopImgView.mas_left).offset(-15 * WIDTH_MULTIPLE);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_shopIconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_shopIconImgView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(160);
    }];
    
    [_selfSellerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_shopIconImgView.mas_bottom);
        make.left.equalTo(_shopIconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(40);
    }];
    
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(_shopIconImgView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - setter
- (void)setCollectShopModel:(HYMyCollectShopModel *)collectShopModel{
    
    _collectShopModel = collectShopModel;
    
    [_shopIconImgView sd_setImageWithURL:[NSURL URLWithString:collectShopModel.storeImages] placeholderImage:[UIImage imageNamed:@"shopIconPlaceholder"]];
    _nameLabel.text = collectShopModel.seller_name;
    
}

#pragma mark - action
- (void)collectBtnAction{
    
    if (self.cancelCollect) {
        
        self.cancelCollect(self.collectShopModel.seller_id);
    }
}

#pragma mark - collectionViewDataSource
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.collectShopModel.item_list.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5.0f, 0, 5.0f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYMyCollectShopImageCollectionViewCell *cell = (HYMyCollectShopImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    NSDictionary *dict = self.collectShopModel.item_list[indexPath.item];
    HYMyCollectShopItemList *itemList = [HYMyCollectShopItemList modelWithDictionary:dict];
    cell.itemModel = itemList;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.collectShopModel.item_list[indexPath.item];
    HYMyCollectShopItemList *itemList = [HYMyCollectShopItemList modelWithDictionary:dict];
    
    DLog(@"current itemID is %@",itemList);
    self.collectionSelect(itemList.item_id);
}

#pragma mark - lazyload
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _bgView;
}

- (UIImageView *)shopIconImgView{
    
    if (!_shopIconImgView) {
        
        _shopIconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _shopIconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _shopIconImgView.clipsToBounds = YES;
        _shopIconImgView.image = [UIImage imageNamed:@"shopIconPlaceholder"];
    }
    
    return _shopIconImgView;
}

- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [UILabel new];
        _nameLabel.text = @"海林官方旗舰店";
        _nameLabel.textColor = KAPP_272727_COLOR;
        _nameLabel.font = KFitFont(14);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _nameLabel;
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
        [_collectBtn setImage:[UIImage imageNamed:@"product_collect_hl"] forState:UIControlStateNormal];
        [_collectBtn addTarget:self action:@selector(collectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

- (UIImageView *)shopImgView{
    
    if (!_shopImgView) {
        
        _shopImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _shopImgView.contentMode = UIViewContentModeScaleAspectFill;
        _shopImgView.clipsToBounds = YES;
        _shopImgView.image = [UIImage imageNamed:@"brandShopIcon"];
    }
    
    return _shopImgView;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        CGFloat itemWidth = (KSCREEN_WIDTH - 20) / 3;
        layout.itemSize = CGSizeMake(itemWidth, 39 * WIDTH_MULTIPLE + itemWidth);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = KAPP_WHITE_COLOR;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[HYMyCollectShopImageCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
