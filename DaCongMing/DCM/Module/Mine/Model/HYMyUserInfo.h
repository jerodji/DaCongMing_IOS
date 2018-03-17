//
//  HYMyUserInfo.h
//  DaCongMing
//
//

#import <Foundation/Foundation.h>

@interface HYMyUserInfo : NSObject
@property (nonatomic, copy) NSString *id;/** id */
@property (nonatomic, copy) NSString *name;/** name */
@property (nonatomic, copy) NSString *age;/** age */
@property (nonatomic, copy) NSString *sex;/** sex */
@property (nonatomic, copy) NSString *adress;/** adress */
@property (nonatomic, copy) NSString *phone;/** phone */
@property (nonatomic, copy) NSString *note;/** note */
@property (nonatomic, copy) NSString *head_image_url;/** head_image_url */
@property (nonatomic, copy) NSString *qrpath;/** qr */
@property (nonatomic, copy) NSString *user_type;/** user_type */
@property (nonatomic, copy) NSString *favStoreNum;/** 收藏店铺数量 */
@property (nonatomic, copy) NSString *favItemNum;/** 收藏商品数量 */
@property (nonatomic, copy) NSString *cartItemNum;/** 购物车数量 */
@property (nonatomic, copy) NSString *browseRecordsNum;/** 最近浏览 */
@property (nonatomic,copy) NSString * hasUnreadMsg; /* 是否有未读消息 1-有 0-没有 */
@property (nonatomic,copy) NSString * level;
@property (nonatomic,copy) NSString * parent_uni;
@property (nonatomic,copy) NSString * uid;


/**
 *  单例
 */
+ (instancetype)sharedInstance;

/**
 *  清除所有的数据
 */
- (void)clearData;

/** V0没有权限(普通客户) V1普通客户 V2实习经销商 V3高级经销商 V4实习合伙人 V5高级合伙人 V6特约合伙人 */
+ (NSString*)getUserStatusWithLevel:(NSString*)level;

@end
