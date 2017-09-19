//
//  HYHomeDoodsCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeDoodsCell.h"
#import "HYGoodsItemCollectionViewCell.h"

@interface HYHomeDoodsCell() <UICollectionViewDelegate,UICollectionViewDataSource>

/** 猜你喜欢  */
@property (nonatomic,strong) UILabel *guessLikeLabel;

/** line */
@property (nonatomic,strong) UIView *line;

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HYHomeDoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.line];
        [self addSubview:self.guessLikeLabel];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)setDatalist:(NSMutableArray *)datalist{
    
    _datalist = datalist;
    
    [_collectionView reloadData];
}

- (void)layoutSubviews{
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [_guessLikeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(_guessLikeLabel.mas_bottom).offset(10);
        
        CGFloat height = ceil(_datalist.count / 2.0) * 350 * WIDTH_MULTIPLE;
        make.height.equalTo(@(height));
    }];
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
    
    NSDictionary *dict = _datalist[indexPath.item];
    cell.goodsModel = [HYGoodsItemModel modelWithDictionary:dict];
    return cell;
}

#pragma mark - lazyload
- (UILabel *)guessLikeLabel{

    if (!_guessLikeLabel) {
        
        _guessLikeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _guessLikeLabel.font = KFitFont(15);
        _guessLikeLabel.textColor = KCOLOR(@"272727");
        _guessLikeLabel.textAlignment = NSTextAlignmentCenter;
        _guessLikeLabel.text = @"猜您喜欢";
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

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((KSCREEN_WIDTH - 10) / 2, 340 * WIDTH_MULTIPLE);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = KAPP_WHITE_COLOR;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        
        [_collectionView registerClass:[HYGoodsItemCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
