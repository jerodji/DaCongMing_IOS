//
//  HYRefundModel.h
//  DaCongMing
//
//

#import "HYBaseModel.h"

@interface HYRefundModel : HYBaseModel

/** guid */
@property (nonatomic,copy) NSString *guid;
/** refundOrder_id */
@property (nonatomic,copy) NSString *refundOrder_id;
/** sorder_id */
@property (nonatomic,copy) NSString *sorder_id;
/** seller_id */
@property (nonatomic,copy) NSString *seller_id;
/** seller_name */
@property (nonatomic,copy) NSString *seller_name;
/** summary_price */
@property (nonatomic,copy) NSString *summary_price;
/** summary_qty */
@property (nonatomic,copy) NSString *summary_qty;
/** trade_no */
@property (nonatomic,copy) NSString *trade_no;
/** 退款状态   1.申请退款  2.商家同意退款 3.买家发货 8.卖家发货 9. 10天后订单关闭  10. 订单入账*/
@property (nonatomic,copy) NSString *order_stat;
/** ref_reason */
@property (nonatomic,copy) NSString *ref_reason;
/** province_name */
@property (nonatomic,copy) NSString *province_name;
/** city_name */
@property (nonatomic,copy) NSString *city_name;
/** area_name */
@property (nonatomic,copy) NSString *area_name;
/** address */
@property (nonatomic,copy) NSString *address;
/** 退货地址 */
@property (nonatomic,copy) NSString *ref_address;
/** ref_postcode */
@property (nonatomic,copy) NSString *ref_postcode;
/** ref_receiver */
@property (nonatomic,copy) NSString *ref_receiver;
/** ref_phone */
@property (nonatomic,copy) NSString *ref_phone;
/** create_time */
@property (nonatomic,copy) NSString *create_time;

@end
