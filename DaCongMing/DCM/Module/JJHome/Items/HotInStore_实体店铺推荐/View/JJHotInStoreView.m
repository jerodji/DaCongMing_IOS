//
//  JJHotInStoreView.m
//  DaCongMing
//
//  Created by hailin on 2018/1/24.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJHotInStoreView.h"
#import "JJHotInStoreCell.h"

static NSString* HOTINSTOREID = @"hot_in_store_id";

@interface JJHotInStoreView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, assign) CGRect frameRect;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UICollectionView* colecView;
@property (nonatomic, strong) NSMutableArray<JJHotInStoreModel*>* colecArray;
@property (nonatomic,strong) UILabel * storeLabel;
@property (nonatomic,strong) UILabel * LTDLabel;
@end

@implementation JJHotInStoreView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _frameRect = frame;
        _colecArray = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor clearColor];
//        [self layerShadowWithColor:UIColorRGB(83, 83, 83) Radius:20 Opacity:0.3 Offset:CGSizeMake(0, 0) Path:nil];
//        self.layer.masksToBounds = YES;
        UIView* cornerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        cornerView.backgroundColor = [UIColor whiteColor];
        cornerView.layer.cornerRadius = 20;
        [self addSubview:cornerView];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2.0)];
        _imageView.userInteractionEnabled = YES;
        [_imageView layerCorners:UIRectCornerTopLeft|UIRectCornerTopRight withRadiiSize:CGSizeMake(20, 20) viewRect:_imageView.frame];
        [self addSubview:_imageView];
        
        
        [self configColecViewWithFrame:frame];
//        [self configStoreLTD:frame];
    }
    return self;
}

- (void)configStoreLTD:(CGRect)frame {
    _storeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, (frame.size.height/2.0 + 10), (frame.size.width-20)/2, 20*WIDTH_MULTIPLE)];
    _storeLabel.backgroundColor = KCOLOR(@"#e2afa3");
    _storeLabel.textAlignment = NSTextAlignmentRight;
    _storeLabel.layer.cornerRadius = 2;
    _storeLabel.layer.masksToBounds = YES;
    [self addSubview: _storeLabel];
    
    _LTDLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-20)/2, (frame.size.height/2.0 + 10), (frame.size.width-20)/2, 20*WIDTH_MULTIPLE)];
    _LTDLabel.backgroundColor = [UIColor clearColor];
    _LTDLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_LTDLabel];
}

- (void)setupStoreLabelDataWith:(NSString*)store LTD:(NSString*)ltdName {
//    NSMutableAttributedString* attrstring = [[NSMutableAttributedString alloc] initWithString:@""];
//    [attrstring appendString:store];
//    [attrstring appendString:@" "];
//    [attrstring appendString:ltdName];
//    [attrstring addAttributes:@{
//                                NSFontAttributeName : [UIFont systemFontOfSize:10],
//                                NSForegroundColorAttributeName : [UIColor whiteColor],
//                                NSBackgroundColorAttributeName : KCOLOR(@"#e2afa3")
//                                } range:NSMakeRange(0, store.length)];
//
//    [attrstring addAttributes:@{
//                                NSFontAttributeName : [UIFont fontWithName:FONT_DINOT size:14]
//                                } range:NSMakeRange(store.length, ltdName.length+1)];
//
//    _storeLabel.textAlignment = NSTextAlignmentCenter;
//    _storeLabel.attributedText = attrstring;
    [self configStoreLTD:_frameRect];
    if (IsNull(store)) {
        return;
    }
    if (IsNull(ltdName)) {
        return;
    }
    
    _storeLabel.text = store;
    _storeLabel.font = [UIFont systemFontOfSize:10];
    _storeLabel.textColor = [UIColor whiteColor];
    
    _LTDLabel.text = ltdName;
    _LTDLabel.font = [UIFont fontWithName:FONT_DINOT size:18];
    
    [_storeLabel sizeToFit];
    [_LTDLabel sizeToFit];
    
    CGFloat allW = _storeLabel.frame.size.width + _LTDLabel.frame.size.width;
    CGFloat leftDis = (self.frame.size.width-allW)/2;
    _storeLabel.x = leftDis;
    _storeLabel.y = _storeLabel.y + 6;
    _LTDLabel.x = _storeLabel.right + 10;
}

- (void)configColecViewWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    flowLayout.itemSize = CGSizeMake(_colecView.frame.size.width/3.0, 130 * WIDTH_MULTIPLE);
    CGFloat dis = 0;
    if (SCREEN_INCH_4_0) {
        dis = -10;
    }
    
    _colecView = [[UICollectionView alloc] initWithFrame:CGRectMake(20 , (frame.size.height/2.0+15+20) + dis, (frame.size.width-40), 130 * WIDTH_MULTIPLE)
                                    collectionViewLayout:flowLayout];
    _colecView.backgroundColor = [UIColor clearColor];
    _colecView.delegate = self;
    _colecView.dataSource = self;
    _colecView.scrollEnabled = YES;
    _colecView.showsHorizontalScrollIndicator = NO; //滚动条
    _colecView.showsVerticalScrollIndicator = NO;
    [_colecView registerClass:[JJHotInStoreCell class] forCellWithReuseIdentifier:HOTINSTOREID];
//    _colecView.backgroundColor = [UIColor lightGrayColor];
}

- (void)setTableModel:(JJTableModel *)tableModel {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[tableModel.MAP objectForKey:@"imageUrl"]]];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        NSLog(@"%@",[tableModel.MAP objectForKey:@"jumpUrl"]);
        [DCURLRouter pushURLString:[tableModel.MAP objectForKey:@"jumpUrl"] animated:YES];
    }];
    [_imageView addGestureRecognizer:tap];
    
    
    for (int i =0; i<tableModel.block.count; i++) {
        JJHotInStoreModel* model = [JJHotInStoreModel modelWithDictionary:(NSDictionary*)tableModel.block[i]];
        [_colecArray addObject:model];
    }
    
    [self addSubview:self.colecView];
}

#pragma mark-

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colecArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JJHotInStoreModel* model = [_colecArray objectAtIndex:indexPath.row];
    JJHotInStoreCell* cell   = [collectionView dequeueReusableCellWithReuseIdentifier:HOTINSTOREID forIndexPath:indexPath];
    [cell setModel:model];
//    cell.backgroundColor = [UIColor yellowColor];
//    cell.contentView.backgroundColor = [UIColor yellowColor];
    return cell;
}

//  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JJHotInStoreModel* model = [self.colecArray objectAtIndex:indexPath.row];
    NSLog(@">> %@",model.jumpUrl);
    [DCURLRouter pushURLString:model.jumpUrl animated:YES];
}

//  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(50, 50);
    return  CGSizeMake(_colecView.frame.size.width/3.0 * WIDTH_MULTIPLE, 130*WIDTH_MULTIPLE);
}

//  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
