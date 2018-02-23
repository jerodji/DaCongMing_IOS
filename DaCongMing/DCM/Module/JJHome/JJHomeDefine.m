//
//  JJHomeDefine.m
//  DaCongMing
//
//  Created by hailin on 2018/1/20.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJHomeDefine.h"

@implementation JJHomeDefine

NSString* const ShowTypeBanner     = @"Banner";
NSString* const ShowTypeNewBanner  = @"NewBanner";
NSString* const ShowTypeSortType   = @"SortType";
NSString* const ShowTypeHotSale    = @"HotSale";
NSString* const ShowTypeHotInStore = @"HotInStore";
NSString* const ShowTypeForMale    = @"ForMale";
NSString* const ShowTypeNature     = @"Nature";
NSString* const ShowTypeTimeReC    = @"TimeReC";
NSString* const ShowTypeBoutique   = @"Boutique";
NSString* const ShowTypeLTC        = @"LTC";

//new banner
//CGFloat const HeightNewBanner = 265;//530px
//banner
CGFloat const HeightBanner = 219;
//产品分类
//CGFloat const HeightSortTypeCell = (KSCREEN_WIDTH==320) ? 50.0f : 60.0f ;
//人气商品
CGFloat const HeightHotSale =  550.0/2.0 ;
//
//CGFloat const HeightHotInStore =  (150.0f/345.0f)*(KSCREEN_WIDTH-30);
//男女专区
//CGFloat const HeightForMale =  140;
//野生推荐,健康资讯
CGFloat const HeightNature =  102;
//限量特价
CGFloat const HeightTimeReC =  200;
//精选专区
//CGFloat const HeightBoutique =  (107.0f/315.0f) * (KSCREEN_WIDTH-50-10);
//老挝直邮
CGFloat const HeightLTC =  331.0f;



NSString* const NotyUpdateTableView   = @"notfy_updatetableview";
NSString* const NotySearchResultJumpURL = @"noty_searchResultJumpurl";
NSString* const NotyTimeUpdate = @"noty_timeUpdate";

@end
