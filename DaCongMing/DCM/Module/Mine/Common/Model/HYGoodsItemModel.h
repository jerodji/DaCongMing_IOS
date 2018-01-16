//
//  HYGoodsItemModel.h
//  DaCongMing
//
//

#import "HYBaseModel.h"

/**
 *  "item_id": "item_2acb6c17b13d405280e8d94fb273426c",
 "item_name": "诺丽果",
 "item_type": "002",
 "item_min_price": "0.02",
 "item_prop": null,
 "item_note": "老挝纯天然野生产品",
 "item_of_seller": "001",
 "item_title_image": "http://116.62.118.249:80/item_image/image_9fd0b4a2115f402280c01651f9e8db85.jpg",
 "item_images": null,
 "isFavorite": "0",
 "salesVolume": 1,
 "provincePrice": null
 */

@interface HYGoodsItemModel : HYBaseModel

/** item_id */
@property (nonatomic, copy) NSString *item_id;
/** item_name */
@property (nonatomic, copy) NSString *item_name;
/** item_type */
@property (nonatomic, copy) NSString *item_type;
/** item_min_price */
@property (nonatomic, copy) NSString *item_min_price;
/** item_prop */
@property (nonatomic, copy) NSString *item_prop;
/** item_note */
@property (nonatomic, copy) NSString *item_note;
/** item_of_seller */
@property (nonatomic, copy) NSString *item_of_seller;
/** item_title_image */
@property (nonatomic, copy) NSString *item_title_image;
/** isFavorite */
@property (nonatomic, copy) NSString *isFavorite;
/** salesVolume */
@property (nonatomic, copy) NSString *salesVolume;
/** provincePrice */
@property (nonatomic, copy) NSString *provincePrice;
/** 规格 */
@property (nonatomic, copy) NSString *unit;
/** 产地 */
@property (nonatomic, copy) NSString *origin;
/** 副标题 */
@property (nonatomic, copy) NSString *publicity;
/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;
/** 是否选中 */
@property (nonatomic,assign) BOOL isSelect;
/** 是否编辑 */
@property (nonatomic,assign) BOOL isEdit;

@end
