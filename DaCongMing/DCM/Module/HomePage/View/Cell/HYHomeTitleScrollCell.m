    //
//  HYHomeTitleScrollCell.m
//  DaCongMing
//
//

#import "HYHomeTitleScrollCell.h"
#import "HYHomeCollectionViewCell.h"

#define itemWidth (KSCREEN_WIDTH - 20) / 3

@interface HYHomeTitleScrollCell() <UICollectionViewDelegate,UICollectionViewDataSource>

/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** 副标题 */
@property (nonatomic,strong) UILabel *subTitleLabel;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** 背景 */
@property (nonatomic,strong) UIView *bgView;

@end

@implementation HYHomeTitleScrollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = KCOLOR(@"f0f7f4");
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.bgView];
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(35 * WIDTH_MULTIPLE);
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(15 * WIDTH_MULTIPLE);
    }];

    CGFloat itemHeight = itemWidth * 1.2 + 50 * WIDTH_MULTIPLE + 30 * WIDTH_MULTIPLE;
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_subTitleLabel.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(itemHeight);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_subTitleLabel.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(itemHeight - 30 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - setter
- (void)setModel:(HYHomePageModel *)model{

    _model = model;
    _titleLabel.text = model.menu_module.main_title;
    _subTitleLabel.text = model.menu_module.sub_title;
    [_collectionView reloadData];
    _cellHeight = _bgView.bottom + 10 * WIDTH_MULTIPLE;
}

#pragma mark - collectionViewDataSource
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.reCommendTday.count;
}

//设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    
//    return 10;
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 5.0f, 0, 5.0f);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HYHomeCollectionViewCell *cell = (HYHomeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    NSDictionary *dict = _model.reCommendTday[indexPath.item];
    cell.commendTodayModel = [HYReCommendTday modelWithDictionary:dict];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = _model.reCommendTday[indexPath.item];
    HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:dict];
    
    NSLog(@"current itemID is %@",model.item_id);
    
    
    self.collectionSelect(model.item_id);
    
}


#pragma mark - lazyload
-  (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _bgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        _titleLabel.font = KFitFont(16);
        _titleLabel.textColor = KCOLOR(@"272727");
        _titleLabel.backgroundColor = KAPP_WHITE_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"今日限时推荐";
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{

    if (!_subTitleLabel) {
        
        _subTitleLabel = [UILabel new];
        _subTitleLabel.font = KFitFont(12);
        _subTitleLabel.textColor = KCOLOR(@"7b7b7b");
        _subTitleLabel.backgroundColor = KAPP_WHITE_COLOR;
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.text = @"纯老挝进口，值得信赖";
    }
    return _subTitleLabel;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        
        layout.itemSize = CGSizeMake(itemWidth, itemWidth * 1.2 + 50 * WIDTH_MULTIPLE);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 0;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = KAPP_WHITE_COLOR;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[HYHomeCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
