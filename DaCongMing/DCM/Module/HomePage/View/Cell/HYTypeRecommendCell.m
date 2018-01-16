//
//  HYTypeRecommendCell.m
//  DaCongMing
//
//

#import "HYTypeRecommendCell.h"
#import "HYTypeRecommendCollectionViewCell.h"

@interface HYTypeRecommendCell() <UICollectionViewDelegate,UICollectionViewDataSource>

/** collection */
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HYTypeRecommendCell

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
    
    return _model.typeReCommend.itemSecondaryTypeList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYTypeRecommendCollectionViewCell *cell = (HYTypeRecommendCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    NSDictionary *dict = _model.typeReCommend.itemSecondaryTypeList[indexPath.item];
    cell.typeItemModel = [HYTypeRecommendItemModel modelWithDictionary:dict];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYTypeRecommendCollectionViewCell *cell = (HYTypeRecommendCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.selectItemBlock) {
        
        self.selectItemBlock(cell.typeItemModel.keyWord,nil);
    }
}

#pragma mark - lazyload
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        CGFloat itemWidth = (KSCREEN_WIDTH - 5 * 3) / 4;
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = KAPP_WHITE_COLOR;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[HYTypeRecommendCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
