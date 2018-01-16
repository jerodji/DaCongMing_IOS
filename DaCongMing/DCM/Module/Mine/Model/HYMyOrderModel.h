//
//  HYMyOrderModel.h
//  DaCongMing
//
//

#import "HYBaseModel.h"

@interface HYMyOrderModel : HYBaseModel

/** seller_id */
@property (nonatomic,copy) NSString *seller_id;
/** seller_name */
@property (nonatomic,copy) NSString *seller_name;
/** 订单号 */
@property (nonatomic,copy) NSString *sorder_id;
/** summary_qty */
@property (nonatomic,copy) NSString *summary_qty;
/** summary_price */
@property (nonatomic,copy) NSString *summary_price;
/** province_name */
@property (nonatomic,copy) NSString *province_name;
/** city_name */
@property (nonatomic,copy) NSString *city_name;
/** area_name */
@property (nonatomic,copy) NSString *area_name;
/** address */
@property (nonatomic,copy) NSString *address;
/** receiver */
@property (nonatomic,copy) NSString *receiver;
/** phoneNum */
@property (nonatomic,copy) NSString *phoneNum;
/** address */
@property (nonatomic,copy) NSString *create_time;
/** close_time */
@property (nonatomic,copy) NSString *close_time;
/** order_stat */
@property (nonatomic,copy) NSString *order_stat;
/** ispassentry */
@property (nonatomic,copy) NSString *ispassentry;
/** deliverytime */
@property (nonatomic,copy) NSString *deliverytime;
/** orderDtls */
@property (nonatomic, copy) NSArray *orderDtls;
/** 物流信息 */
@property (nonatomic,copy) NSString *express_msg;
/** 物流公司 */
@property (nonatomic,copy) NSString *express_name;
/** 物流H5 */
@property (nonatomic,copy) NSString *express_url;
/** 2为已评价，0为未评价 */
@property (nonatomic,copy) NSString *isevaluate;

@end

@interface HYMyOrderDetailsModel : HYBaseModel

/** guid */
@property (nonatomic,copy) NSString *guid;
/** sorder_id */
@property (nonatomic,copy) NSString *sorder_id;
/** item_id */
@property (nonatomic,copy) NSString *item_id;
/** summary_qty */
@property (nonatomic,copy) NSString *item_name;
/** unit */
@property (nonatomic,copy) NSString *unit;
/** province_name */
@property (nonatomic,copy) NSString *qty;
/** city_name */
@property (nonatomic,copy) NSString *price;
/** item_title_image */
@property (nonatomic,copy) NSString *item_title_image;
/** address */
@property (nonatomic,copy) NSString *seller_id;
/** isRefQty */
@property (nonatomic,copy) NSString *isRefQty;

@end

/**
 "seller_id": "001",
 "seller_name": "laohailin",
 "sorder_id": "010201710121000001860636272",
 "summary_qty": 1,
 "summary_price": 0.05,
 "province_name": "北京市",
 "city_name": "市辖区",
 "area_name": "东城区",
 "address": "老地方",
 "receiver": "哈哈哈",
 "phoneNum": "12345678901",
 "orderDtls": [
 {
 "guid": "201710121000002024806468",
 "sorder_id": "010201710121000001860636272",
 "item_id": "item_d386811840e747ec87420496c3f34619",
 "item_name": "蝶豆花",
 "unit": "500g",
 "qty": 1,
 "price": 0.05,
 "floor_price": 0,
 "item_title_image": "http://116.62.118.249:80/item_image/image_8d93b45b81fc4e95a599bd854a39896c.jpg",
 "seller_id": null,
 "user_id": null,
 "refingQty": 0,
 "isRefQty": 0
 }
 ],
 "user_id": "o-13MvxwjL-h-8jK4SP8BglgEYhc",
 "order_id": null,
 "note": null,
 "create_time": "2017-10-12 17:11:16.0",
 "close_time": "2017-10-12 17:26:16.0",
 "order_stat": "1",
 "ispassentry": "0",
 "receipt": null,
 "deliverytime": null
 */
