//
//  Macro.h
//  xtd
//
//  Created by leimo on 2017/8/10.
//  Copyright © 2017年 sj. All rights reserved.
//

#pragma mark - 常用宏定义

#ifndef Macro_h
#define Macro_h

#ifdef DEBUG
#define NSLog(format, ...) NSLog((@"%s " "%s(%d)\n" format "\n-----------------------------------------------------"), __PRETTY_FUNCTION__, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, ##__VA_ARGS__);
#else
#define NSLog(format, ...)
#endif

//#ifdef DEBUG
//#define DLog(format, ...) NSLog(@"%s():%d " format, __func__, __LINE__, ##__VA_ARGS__)
//#else
//#define DLog(...)
//#endif

#define  KAdjustsScrollViewInsets_NO(vc,scrollView)\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
if (@available(iOS 11.0, *)) {\
vc.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;\
} else {\
    vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \


/* 商品站位图 */
#define ProductPlaceholder  @"zhanwei"


/** ----------------------------设备信息---------------------------------
 --------------------------------------------------------------------*/
#pragma mark - 设备信息
/** 是否大于iOS7 */
#define iOS7                    ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
/** 是否为iphone4 */
#define IS_IPHONE_4             ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
/** 是否为iphone5 */
#define IS_IPHONE_5             ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
/** 是否为iphone6 */
#define IS_IPHONE_6             ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
/** 是否为iphone6Plus */
#define IS_IPHONE_6PLUS         ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
/** 是否为iphoneX */
#define IS_IPHONE_X         ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )812 ) < DBL_EPSILON )
/** 设备的主window */
#define KEYWINDOW               [[[UIApplication sharedApplication] delegate] window]

/** ----------------------------尺寸信息---------------------------------
--------------------------------------------------------------------*/
#pragma mark - 尺寸信息
/** 屏幕宽度> */
#define KSCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define KSCREEN_HEIGHT      [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度比 */
#define WIDTH_MULTIPLE      KSCREEN_WIDTH / 375.0
/** 状态栏高度 */
#define KSTATUSBAR_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
/** 导航栏高度 */
#define KNAV_HEIGHT         (KSTATUSBAR_HEIGHT + 44)
/** tabBar高度 */
#define KTABBAR_HEIGHT      (KSTATUSBAR_HEIGHT > 20 ? 83 : 49)
/** 底部安全区高度 */
#define KSafeAreaBottom_Height  (KSCREEN_HEIGHT == 812.0 ? 34 : 0)

/** ------------------------- 屏幕尺寸 ----------------------------- **/
/**                                           尺寸       分辨率
 *  1 判断是否为3.5-inch - (@2x) 3GS(@1x) 4S   320*480    640*960
 *  2 判断是否为4.0-inch - (@2x) 5 5C 5S SE    320*568    640*1136
 *  3 判断是否为4.7-inch - (@2x) 6 6S 7        375*667    750*1334
 *  4 判断是否为5.5-inch - (@3x) 6P 7P         414*736    1242*2208
 *  5                    (@3x)  X            375*812    1125*2436
 */
#define SCREEN_INCH_3_5  ((KSCREEN_HEIGHT > 470) && (KSCREEN_HEIGHT < 490))
#define SCREEN_INCH_4_0  ((KSCREEN_HEIGHT > 558) && (KSCREEN_HEIGHT < 578))
#define SCREEN_INCH_4_7  ((KSCREEN_HEIGHT > 657) && (KSCREEN_HEIGHT < 687))
#define SCREEN_INCH_5_5  ((KSCREEN_HEIGHT > 726) && (KSCREEN_HEIGHT < 746))
#define SCREEN_X KSCREEN_HEIGHT == 821.0

/** ----------------------------颜色信息---------------------------------
 --------------------------------------------------------------------*/
#define UIColorRGB(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define UIColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorRandom UIColorRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1);

#pragma mark - APP颜色
/** APP主题色 */
#define KAPP_THEME_COLOR                   [UIColor colorWithHexString:@"53d76f"]
/** APP导航栏颜色 */
#define KAPP_NAV_COLOR                   [UIColor colorWithHexString:@"383938"]
/** 白色 */
#define KAPP_WHITE_COLOR                   [UIColor whiteColor]
/** 黑色 */
#define KAPP_BLACK_COLOR                   [UIColor blackColor]

#define KAPP_PRICE_COLOR                   [UIColor colorWithHexString:@"fb622d"]
/** APPb7b7b7文字颜色 */
#define KAPP_b7b7b7_COLOR                   [UIColor colorWithHexString:@"b7b7b7"]
/** APP272727文字颜色 */
#define KAPP_272727_COLOR                   [UIColor colorWithHexString:@"272727"]
/** APP484848文字颜色 */
#define KAPP_484848_COLOR                   [UIColor colorWithHexString:@"484848"]
/** APP7b7b7b文字颜色 */
#define KAPP_7b7b7b_COLOR                   [UIColor colorWithHexString:@"7b7b7b"]
/** APPTableView背景色 */
#define KAPP_TableView_BgColor              [UIColor colorWithHexString:@"f4f4f4"]
/** APP文字特殊颜色 */
#define KAPP_TextSpecial_COLOR              [UIColor colorWithHexString:@"5fc6ef"]
/** APP分割线颜色 */
#define KAPP_SEPERATOR_COLOR               [UIColor colorWithHexString:@"ebe9e9"]
/** 颜色宏 */
#define KCOLOR(hexStr)                     [UIColor colorWithHexString:hexStr]
/** RGB颜色 */
#define RGBColor(r, g, b)                  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
/** RGB颜色(带透明度) */
#define RGBAColor(r, g, b ,a)              [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
/** 随机颜色 */
#define KAPP_RANDOM_COLOR                  RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

/** ----------------------------字体设置---------------------------------
 --------------------------------------------------------------------*/
#pragma mark - 字体设置

#define FONT_DINOT @"DIN OT"
#define FONT_MicrosoftYaHei  @"MicrosoftYaHei"

/** 常用字体 */
#define KFONT10                 [UIFont systemFontOfSize:10.0f]
#define KFONT11                 [UIFont systemFontOfSize:11.0f]
#define KFONT12                 [UIFont systemFontOfSize:12.0f]
#define KFONT14                 [UIFont systemFontOfSize:14.0f]
#define KFONT16                 [UIFont systemFontOfSize:16.0f]
#define KFONT18                 [UIFont systemFontOfSize:18.0f]
#define KFONT20                 [UIFont systemFontOfSize:20.0f]
/** 设置字体 */
#define KFont(font)             [UIFont systemFontOfSize:((IS_IPHONE_6PLUS) ? (font + 2) : IS_IPHONE_5 ? (font - 2) : font)]
/** 字体适配，如果是plus+2 iphone5-2 */
#define KFitFont(font)          [UIFont systemFontOfSize:((IS_IPHONE_6PLUS) ? (font + 1) : IS_IPHONE_5 ? (font - 1) : font)]
/** 字体适配，如果是plus+2 */
#define KFitBoldFont(font)          [UIFont boldSystemFontOfSize:((IS_IPHONE_6PLUS) ? (font + 2) : IS_IPHONE_5 ? (font - 2) : font)]  

/** 字体适配，如果是plus+2 */
#define KPriceFont(font)           [UIFont fontWithName:@"DIN OT" size:((IS_IPHONE_6PLUS) ? (font + 2) : IS_IPHONE_5 ? (font - 2) : font)]

/** ----------------------------沙盒路径---------------------------------
 --------------------------------------------------------------------*/
#pragma mark - 沙盒路径
/** 沙盒document目录 */
#define KDOCUMENT_PATH          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
/** 沙盒cache目录 */
#define KCACHE_PATH             [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define KUSERDEFAULTS           [NSUserDefaults  standardUserDefaults]
#define KAccountPhone           [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]
#define KAccountPassword        [[NSUserDefaults standardUserDefaults] objectForKey:@"password"]
#define KLoginType              [[NSUserDefaults standardUserDefaults] objectForKey:@"loginType"]


#define KItemHeight             280 * WIDTH_MULTIPLE

#endif /* Macro_h */
