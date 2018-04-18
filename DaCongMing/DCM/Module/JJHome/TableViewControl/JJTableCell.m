//
//  JJTableCell.m
//  DaCongMing
//
//  Created by hailin on 2018/1/20.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJTableCell.h"
#import "JJBannerController.h"
#import "JJProductCategoryView.h"
#import "JJHotSaleView.h"
#import "JJForMaleView.h"
#import "JJNatureView.h"
#import "JJTimeReCView.h"
#import "JJBoutiquCell.h"
#import "JJLTCView.h"
#import "JJHotInStoreView.h"
#import "MoreArticleVC.h"

@interface JJTableCell()
@property (nonatomic, strong) JJTitleView* titleView;
@property (nonatomic, strong) JJBannerController* bannerCtrl;
@end

@implementation JJTableCell

#pragma mark - lazy load

- (JJBannerController *)bannerCtrl {
    if (!_bannerCtrl) {
        _bannerCtrl = [[JJBannerController alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 220)];
        [_bannerCtrl configModelWith:_model.bannerList];
    }
    return _bannerCtrl;
}

- (void)viewWillAppear {
    
}

#pragma mark - setModel
- (void)setModel:(JJTableModel *)model
{
    _model = model;
    
    if ([model.showType isEqualToString:ShowTypeSortType])  {[self UISortTypeWith:model.block  model:model];}
    if ([model.showType isEqualToString:ShowTypeHotSale])   {[self UIHotSaleWith:model.block  model:model];}
    if ([model.showType isEqualToString:ShowTypeHotInStore]){[self UIHotInStoreWith:model];}
    if ([model.showType isEqualToString:ShowTypeForMale])   {[self UIForMaleWith:model.block model:model]; }
    if ([model.showType isEqualToString:ShowTypeNature])    {[self UINatureWith:model.block model:model];}
    if ([model.showType isEqualToString:ShowTypeTimeReC])   {[self UITimeReCWith:model.block model:model];}
    if ([model.showType isEqualToString:ShowTypeBoutique])  {[self UIBoutiqueWith:model.block model:model];}
    if ([model.showType isEqualToString:ShowTypeLTC])       {[self UILTCWith:model.MAP model:model];}
    
}

#pragma mark - UI config

//产品分类
- (void)UISortTypeWith:(NSArray *)block model:(JJTableModel *)model
{
    self.titleView = [[JJTitleView alloc] initWithFrame:CGRectMake(0, 10, KSCREEN_WIDTH, TitleViewHeight)];
    self.titleView.titleLabel.text = model.title;
    self.titleView.englishTitleLabel.text = model.smallTitle;
    self.titleView.moreButton.hidden = YES;
    [self.contentView addSubview:self.titleView];

    JJProductCategoryView* productCategoryView = [[JJProductCategoryView alloc] initWithFrame:CGRectMake(0, TitleViewHeight+10, KSCREEN_WIDTH, HeightSortTypeCell)]; //ceil(block.count/5.0f)
    
    for (int i=0; i<block.count; i++) {
        NSDictionary* dic = (NSDictionary*)block[i];
        JJProductCategoryModel* model = [JJProductCategoryModel modelFromDict:dic];
        [productCategoryView.block addObject:model];
    }
    
    if (productCategoryView.block.count >= 5) {
        //展开/收起按钮的位置
        JJProductCategoryModel* m4 = [[JJProductCategoryModel alloc] init];
        m4.imageUrl = @"zk";
        m4.jumpUrl  = @"sq";
        [productCategoryView.block insertObject:m4 atIndex:4];
    }
    
    //[productCategoryView updateUI];
    [self.contentView addSubview:productCategoryView];
}

- (void)UIHotSaleWith:(NSArray *)block model:(JJTableModel *)model
{
    
    self.titleView = [[JJTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, TitleViewHeight)];
    self.titleView.titleLabel.text = model.title;
    self.titleView.englishTitleLabel.text = model.smallTitle;
    self.titleView.moreButton.hidden = YES;
    [self.contentView addSubview:self.titleView];
    
    JJHotSaleView* hotSaleView = [[JJHotSaleView alloc] initWithFrame:CGRectMake(0, TitleViewHeight, KSCREEN_WIDTH, HeightHotSale)];
    
    for (int i=0; i<block.count; i++) {
        NSDictionary* dict = (NSDictionary*)block[i];
        JJCarouselCellModel * model = [JJCarouselCellModel modelFromDict:dict];
        [hotSaleView.modelArray addObject:model];
    }
//    if (hotSaleView.modelArray.count <=4) {
//        [hotSaleView.modelArray addObjectsFromArray:hotSaleView.modelArray];
//    }
    [hotSaleView updateUI];
    [self.contentView addSubview:hotSaleView];
}

//实体店铺推荐
- (void)UIHotInStoreWith:(JJTableModel *)model {
    self.titleView = [[JJTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, TitleViewHeight)];
    self.titleView.titleLabel.text = model.title;
    self.titleView.englishTitleLabel.text = model.smallTitle;
    self.titleView.moreButton.hidden = YES;
    [self.contentView addSubview:self.titleView];
    
    JJHotInStoreView* hotInStoView = [[JJHotInStoreView alloc] initWithFrame:CGRectMake(15, TitleViewHeight, KSCREEN_WIDTH-30, 330*WIDTH_MULTIPLE)];
    [hotInStoView setTableModel:model];
    [hotInStoView setupStoreLabelDataWith:model.type LTD:model.name];
    [hotInStoView layerShadowWithColor:UIColorRGB(83, 83, 83) Radius:20 Opacity:0.3 Offset:CGSizeMake(0, 0) Path:nil];
    [self.contentView addSubview:hotInStoView];
}

//男女推荐
- (void)UIForMaleWith:(NSArray *)block model:(JJTableModel *)model
{
    self.titleView = [[JJTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, TitleViewHeight)];
    self.titleView.titleLabel.text = model.title;
    self.titleView.englishTitleLabel.text = model.smallTitle;
    self.titleView.moreButton.hidden = YES;
    [self.contentView addSubview:self.titleView];
    
    JJForMaleView* formaleView = [JJForMaleView loadXIB];
    for (int i=0; i<block.count; i++) {
        NSDictionary* d = (NSDictionary*)block[i];
        JJForMaleModel* model = [JJForMaleModel modelFromDict:d];
        [formaleView.modelArray addObject:model];
    }
    [self.contentView addSubview:formaleView];
    [formaleView updateUI];
}

//野生推荐, 健康资讯
- (void)UINatureWith:(NSArray *)block model:(JJTableModel *)model
{
    __weak typeof(self) wkself = self;
    
    self.titleView = [[JJTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, TitleViewHeight) itemType:ItemWildRecomend];
    self.titleView.titleLabel.text = model.title;
    self.titleView.englishTitleLabel.text = model.smallTitle;
    self.titleView.moreButton.hidden = NO;
    [self.contentView addSubview:self.titleView];
    self.titleView.moreNatureCB = ^{
        if (NotNull([HYUserModel sharedInstance].token)) {
            [wkself.viewController.navigationController pushViewController:[MoreArticleVC new] animated:YES];
        } else {
            [JRToast showWithText:@"请登录后操作"];
        }
    };
    
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (int i=0; i<block.count; i++) {
        JJNatureModel* model = [JJNatureModel modelFromDict:(NSDictionary*)block[i]];
        [arr addObject:model];
    }
    
    JJNatureView* natureView = [[JJNatureView alloc] initWithFrame:CGRectMake(0, TitleViewHeight, KSCREEN_WIDTH, 5 +  arr.count * (HeightNature+20)) modelArray:arr];
    
    [self.contentView addSubview:natureView];
}

//限时特价
- (void)UITimeReCWith:(NSArray *)block model:(JJTableModel *)model
{
    self.titleView = [[JJTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, TitleViewHeight)];
    self.titleView.titleLabel.text = model.title;
    self.titleView.englishTitleLabel.text = model.smallTitle;
    self.titleView.moreButton.hidden = YES;
    [self.contentView addSubview:self.titleView];
    
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<block.count; i++) {
        JJTimeReCModel* model = [JJTimeReCModel modelFromDict:block[i]];
        [arr addObject:model];
    }
    
    JJTimeReCView* timeView = [[JJTimeReCView alloc] initWithFrame:CGRectMake(10, TitleViewHeight+5, KSCREEN_WIDTH-20, HeightTimeReC-10-30) dataSource:arr];
//    [timeView updateUI];
    [self.contentView addSubview:timeView];
}

//精选专区
- (void)UIBoutiqueWith:(NSArray *)block model:(JJTableModel *)model {
    self.titleView = [[JJTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, TitleViewHeight)];
    self.titleView.titleLabel.text = model.title;
    self.titleView.englishTitleLabel.text = model.smallTitle;
    self.titleView.moreButton.hidden = YES;
    [self.contentView addSubview:self.titleView];
    
    for (int i=0; i<block.count; i++)
    {
        JJBoutiquModel* model = [JJBoutiquModel modelWithDictionary:(NSDictionary*)block[i]];
        int yu = i % 2;
        JJBoutiquCell * boutView;
        if (yu==0) {
            boutView = [[JJBoutiquCell alloc] initWithFrame:CGRectMake(50, TitleViewHeight + i*(HeightBoutique+20), KSCREEN_WIDTH-50-10, HeightBoutique)];
        } else { /* yu==1 */
            boutView = [[JJBoutiquCell alloc] initWithFrame:CGRectMake(30, TitleViewHeight + i*(HeightBoutique+20), KSCREEN_WIDTH-50-10, HeightBoutique)];
        }
        [boutView setModel:model];
        [self.contentView addSubview:boutView];
    }
   
}

//直邮
- (void)UILTCWith:(NSDictionary *)Map model:(JJTableModel *)model
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotySearchResultJumpURL object:@{@"jumpUrl":Map[@"jumpUrl"]}];
    
    //=----------
    self.titleView = [[JJTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, TitleViewHeight)];
    self.titleView.titleLabel.text = model.title;
    self.titleView.englishTitleLabel.text = model.smallTitle;
    self.titleView.moreButton.hidden = YES;
    [self.contentView addSubview:self.titleView];
    
    JJLTCView* ltc = [[JJLTCView alloc] initWithFrame:CGRectMake(10, TitleViewHeight+5, KSCREEN_WIDTH-20, (KSCREEN_WIDTH-20)*(331.f/356.f))];
    [ltc.imgView sd_setImageWithURL:[NSURL URLWithString:Map[@"imageUrl"]]];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        NSLog(@"%@",Map[@"jumpUrl"]);
        [DCURLRouter pushURLString:Map[@"jumpUrl"] animated:YES];
    }];
    
    ltc.imgView.userInteractionEnabled = YES;
    [ltc.imgView addGestureRecognizer:tap];
    [self.contentView addSubview:ltc];
}

@end
