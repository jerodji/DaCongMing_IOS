//
//  HYHomeImgScrollCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeImgScrollCell.h"
#import "HYHomeCollectionViewCell.h"
#import "HYItemListModel.h"

@interface HYHomeImgScrollCell() <UICollectionViewDelegate,UICollectionViewDataSource>

/** img */
@property (nonatomic,strong) UIImageView *imgView;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HYHomeImgScrollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.imgView];
        [self addSubview:self.collectionView];

    }
    return self;
}

- (void)layoutSubviews{

    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self);
        make.height.equalTo(@150);
    }];
    
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(self.imgView.mas_bottom).offset(10);
        
        CGFloat itemWidth = (KSCREEN_WIDTH - 20) / 3;
        CGFloat height = (itemWidth * 1.2 + 50) * WIDTH_MULTIPLE;
        make.height.equalTo(@(height));
    }];

}

- (void)setGoodHealthModel:(HYGoodHealthModel *)goodHealthModel{
    
    _goodHealthModel = goodHealthModel;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:goodHealthModel.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
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
    
    return _goodHealthModel.itemList.count;
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
    
    NSDictionary *dict = _goodHealthModel.itemList[indexPath.item];
    cell.itemListModel = [HYItemListModel modelWithDictionary:dict];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = _goodHealthModel.itemList[indexPath.item];
    HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:dict];
    
    DLog(@"current itemID is %@",model.item_id);
    
    
    self.collectionSelect(model.item_id);
    
}


#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        
    }
    
    return _imgView;
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
