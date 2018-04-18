//
//  JJHomeDefine.h
//  DaCongMing
//
//  Created by hailin on 2018/1/20.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TableItemStyle) {
    ItemBanner          = 0,
    ItemProductCategory = 1,
    ItemSelectedZone    = 2,
    ItemSellingProduct  = 3,
    ItemManWomanArea    = 4,
    ItemWildRecomend    = 5, //健康资讯
    ItemTimedSpecials   = 6,
    ItemNiceSelect      = 7,
    ItemMail            = 8
};


#define NewBannerCycleTime 5.0f //banner轮播时间

#define TitleViewHeight 60.0f //title高度
//#define SortTypeCellLen 60.0f //产品分类 cell
#define HeightSortTypeCell  (KSCREEN_WIDTH==320) ? 55.0f : ((KSCREEN_WIDTH==375) ? 60.0f : 70.0f )

#define HeightBoutique   (107.0f/315.0f)*(KSCREEN_WIDTH-50-10)
#define HeightHotInStore (330.0f/345.0f)*(KSCREEN_WIDTH-15-15)
#define HeightNewBanner  (315.0f/375.0f)*(KSCREEN_WIDTH) // 650 * 750
#define HeightForMale    (110.0f/375.0f)*KSCREEN_WIDTH

@interface JJHomeDefine : NSObject

extern NSString* const ShowTypeBanner;
extern NSString* const ShowTypeNewBanner;
extern NSString* const ShowTypeSortType;
extern NSString* const ShowTypeHotSale;
extern NSString* const ShowTypeHotInStore;
extern NSString* const ShowTypeForMale;
extern NSString* const ShowTypeNature;
extern NSString* const ShowTypeTimeReC;
extern NSString* const ShowTypeBoutique;
extern NSString* const ShowTypeLTC;

//UIKIT_EXTERN CGFloat const HeightNewBanner;
extern CGFloat const HeightBanner;
//extern CGFloat const HeightSortTypeCell;
extern CGFloat const HeightHotSale;
//extern CGFloat const HeightHotInStore;
//extern CGFloat const HeightForMale;
extern CGFloat const HeightNature;
extern CGFloat const HeightTimeReC;
//extern CGFloat const HeightBoutique;
extern CGFloat const HeightLTC;


UIKIT_EXTERN NSString* const NotyUpdateTableView;
UIKIT_EXTERN NSString* const NotySearchResultJumpURL;
UIKIT_EXTERN NSString* const NotyTimeUpdate;

@end
