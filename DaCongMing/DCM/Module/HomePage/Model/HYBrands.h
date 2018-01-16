//
//  HYBrands.h
//  DaCongMing
//
//

#import "HYBaseModel.h"

/** -------------------商家推荐（也是banner）------------------------ */
@interface HYBrands : HYBaseModel

/**
 guid = "865d48af-7c32-11e7-9ae8-80a589568545";
 "image_url" = "http://116.62.118.249:80/menu_image/brands/bxyq.jpg";
 "item_type" = 001;
 */

/** guid */
@property (nonatomic,copy) NSString *guid;
/** image_url */
@property (nonatomic,copy) NSString *image_url;
/** seller_id */
@property (nonatomic,copy) NSString *item_type;

@end
