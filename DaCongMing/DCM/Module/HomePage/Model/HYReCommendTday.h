//
//  HYReCommendTday.h
//  DaCongMing
//
//

#import "HYBaseModel.h"

@interface HYReCommendTday : HYBaseModel

/** -------------------今日推荐------------------------ */
/**
 "guid": "608508a8-88af-11e7-bef8-00163e0f0441",
 "item_id": "item_157239920d8743f5a438a6109df45640",
 "item_name": "疏盏",
 "image_url": "http://116.62.118.249:80/item_image/image_e610a00a2b93419885806e9831f95317.jpg",
 "price": 0.03
 */

/** guid */
@property (nonatomic,copy) NSString *guid;
/** image_url */
@property (nonatomic,copy) NSString *item_id;
/** note */
@property (nonatomic,copy) NSString *item_name;
/** image_url */
@property (nonatomic,copy) NSString *image_url;
/** price */
@property (nonatomic,strong) NSNumber *price;


@end
