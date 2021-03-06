//
//  HYHomeCollectionCell.m
//  DaCongMing
//
//

#import "HYHomeCollectionCell.h"
#import "HYHomeTagsCollectionViewCell.h"
#import "HYTagsItemModel.h"


@interface HYHomeCollectionCell() <UICollectionViewDelegate,UICollectionViewDataSource>

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HYHomeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = KCOLOR(@"f0f7f4");
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - setter
- (void)setModel:(HYHomePageModel *)model{
    
    _model = model;
    
    [_collectionView reloadData];
}

#pragma mark - collectionViewDataSource
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _model.tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYHomeTagsCollectionViewCell *cell = (HYHomeTagsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    NSDictionary *dict = _model.brands[indexPath.item];
    cell.brandsModel = [HYBrands modelWithDictionary:dict];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYHomeTagsCollectionViewCell *cell = (HYHomeTagsCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.selectItemBlock) {
        
        self.selectItemBlock(cell.brandsModel.item_type);
    }
}

#pragma mark - lazyload
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((KSCREEN_WIDTH - 2) / 2, 110 * WIDTH_MULTIPLE);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = KCOLOR(@"f0f7f4");
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.scrollEnabled = NO;
        
        [_collectionView registerClass:[HYHomeTagsCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
