//
//  HYCreateOrder.h
//  DaCongMing
//
//

#import "HYBaseModel.h"

/**
 "data": {
 "summary_price": 0.03,
 "summary_qty": 3,
 "addressMap": {
 "area": "长安区",
 "address": "都不买看",
 "province": "河北省",
 "receiver": "范冰冰",
 "city": "石家庄市",
 "phoneNum": "12345685231"
 },
 */

@interface HYAddressMap : HYBaseModel

/** area */
@property (nonatomic,copy) NSString *area;
/** address */
@property (nonatomic,copy) NSString *address;
/** province */
@property (nonatomic,copy) NSString *province;
/** city */
@property (nonatomic,copy) NSString *city;
/** phoneNum */
@property (nonatomic,copy) NSString *phoneNum;
/** receiver */
@property (nonatomic,copy) NSString *receiver;

@end

@interface HYCreateOrder : HYBaseModel

/** 总价 */
@property (nonatomic,copy) NSString *summary_price;
/** 数量 */
@property (nonatomic,copy) NSString *summary_qty;
/** 收货地址 */
@property (nonatomic,strong) HYAddressMap *addressMap;
/** 展示图 */
@property (nonatomic,copy) NSArray *item_imageList;
/** 优惠券 */
@property (nonatomic,copy) NSArray *userCoupons;
/** dataList */
@property (nonatomic,copy) NSArray *dataList;


@end
