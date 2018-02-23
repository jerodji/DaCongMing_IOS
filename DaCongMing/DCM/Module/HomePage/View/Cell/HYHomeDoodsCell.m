//
//  HYHomeDoodsCell.m
//  DaCongMing
//
//

#import "HYHomeDoodsCell.h"
#import "HYGoodsItemCollectionViewCell.h"
#import "HYGoodsDetailInfoViewController.h"

@interface HYHomeDoodsCell() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** 猜你喜欢  */
@property (nonatomic,strong) UILabel *guessLikeLabel;

/** line */
@property (nonatomic,strong) UIView *line;



@end

@implementation HYHomeDoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake( (KSCREEN_WIDTH-30)/2, KItemHeight-10);
//        layout.estimatedItemSize = CGSizeMake((KSCREEN_WIDTH - 15) / 2, KItemHeight - 10);
        //        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
        //        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;      //纵向间距
        layout.sectionInset = UIEdgeInsetsMake(10, 10 , 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setCollectionViewLayout:layout];
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        
        [_collectionView registerClass:[HYGoodsItemCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
        [self addSubview:self.collectionView];
        self.backgroundColor = KAPP_WHITE_COLOR;
        
    }
    return self;
}

- (void)setDatalist:(NSMutableArray *)datalist{
    
    _datalist = datalist;
    
    [_collectionView reloadData];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];

    [_guessLikeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];

    [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.left.right.equalTo(self);
        CGFloat height = ceil(_datalist.count / 2.0) * 348 * WIDTH_MULTIPLE;
        make.height.equalTo(@(height));
        if (_guessLikeLabel) {

            make.top.equalTo(_guessLikeLabel.mas_bottom).offset(1 * WIDTH_MULTIPLE);
        }
        else{

            make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        }

    }];
}

#pragma mark - setter
- (void)setTitle:(NSString *)title{
    
    _title = title;
    [self addSubview:self.line];
    self.line.hidden = YES;
    [self addSubview:self.guessLikeLabel];
    self.guessLikeLabel.text = title;
}

#pragma mark - collectionViewDataSource
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYGoodsItemCollectionViewCell *cell = (HYGoodsItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.backgroundColor = KAPP_WHITE_COLOR;
    NSDictionary *dict = _datalist[indexPath.item];
    cell.goodsModel = [HYGoodsItemModel modelWithDictionary:dict];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = _datalist[indexPath.item];
    HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:dict];
    
    NSLog(@"current itemID is %@",model.item_id);
    
    
    self.collectionSelect(model.item_id);
    
}

#pragma mark - lazyload
- (UILabel *)guessLikeLabel{

    if (!_guessLikeLabel) {
        
        _guessLikeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _guessLikeLabel.font = KFitFont(15);
        _guessLikeLabel.textColor = KCOLOR(@"272727");
        _guessLikeLabel.textAlignment = NSTextAlignmentCenter;
        _guessLikeLabel.text = @"猜您喜欢";
        _guessLikeLabel.backgroundColor= self.backgroundColor;
    }
    return _guessLikeLabel;
}

- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = KCOLOR(@"ebe9e9");
    }
    return _line;
}

//- (UICollectionView *)collectionView{
//
//    if (!_collectionView) {
//
//        //1.初始化layout
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        layout.estimatedItemSize = CGSizeMake((KSCREEN_WIDTH - 15) / 2, KItemHeight - 10);
////        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
////        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        layout.minimumInteritemSpacing = 5;
//        layout.minimumLineSpacing = 10 * WIDTH_MULTIPLE;      //纵向间距
//        layout.sectionInset = UIEdgeInsetsMake(10, 5 , 0, 5);
//
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        [_collectionView setCollectionViewLayout:layout];
//        _collectionView.backgroundColor = self.backgroundColor;
//        _collectionView.showsVerticalScrollIndicator = NO;
//        _collectionView.showsHorizontalScrollIndicator = NO;
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//        _collectionView.bounces = NO;
//
//        [_collectionView registerClass:[HYGoodsItemCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
//    }
//    return _collectionView;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
