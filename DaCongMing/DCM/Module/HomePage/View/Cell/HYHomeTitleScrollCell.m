    //
//  HYHomeTitleScrollCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeTitleScrollCell.h"
#import "HYHomeCollectionViewCell.h"

@interface HYHomeTitleScrollCell() <UICollectionViewDelegate,UICollectionViewDataSource>

/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** 副标题 */
@property (nonatomic,strong) UILabel *subTitleLabel;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HYHomeTitleScrollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)setModel:(HYHomePageModel *)model{

    _model = model;
    [_collectionView reloadData];
    
    _cellHeight = _collectionView.bottom + 20;
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
    
    DLog(@"current itemID is %@",model.item_id);
    
    
    self.collectionSelect(model.item_id);
    
}


#pragma mark - lazyload
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KSCREEN_WIDTH, 20)];
        _titleLabel.font = KFont(18);
        _titleLabel.textColor = KCOLOR(@"272727");
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"今日限时推荐";
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{

    if (!_subTitleLabel) {
        
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom + 6, KSCREEN_WIDTH, 20)];
        _subTitleLabel.font = KFont(12);
        _subTitleLabel.textColor = KCOLOR(@"7b7b7b");
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
        
        CGFloat itemWidth = (KSCREEN_WIDTH - 20) / 3;
         layout.itemSize = CGSizeMake(itemWidth, (itemWidth * 1.2 + 50) * WIDTH_MULTIPLE);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.subTitleLabel.bottom + 10, KSCREEN_WIDTH, (itemWidth * 1.2 * 1.2 + 50) * WIDTH_MULTIPLE) collectionViewLayout:layout];
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
