//
//  HYMyAddressModel.h
//  DaCongMing
//
//

#import "HYBaseModel.h"

@interface HYMyAddressModel : HYBaseModel

/** address_id */
@property (nonatomic,copy) NSString *address_id;
/** user_id */
@property (nonatomic,copy) NSString *user_id;
/** province */
@property (nonatomic,copy) NSString *province;
/** city */
@property (nonatomic,copy) NSString *city;
/** area */
@property (nonatomic,copy) NSString *area;
/** address */
@property (nonatomic,copy) NSString *address;
/** receiver */
@property (nonatomic,copy) NSString *receiver;
/** phoneNum */
@property (nonatomic,copy) NSString *phoneNum;
/** isdefault */
@property (nonatomic,copy) NSString *isdefault;

@end

/**
 *  "address_id": "address_201709071000000875556409",
 "user_id": "o-13MvzD5U5LVc",
 "province": "河北省",
 "city": "石家庄市",
 "area": "长安区",
 "address": "都不买看",
 "receiver": "范冰冰",
 "phoneNum": "12345685231",
 "isdefault": "1"
 */
