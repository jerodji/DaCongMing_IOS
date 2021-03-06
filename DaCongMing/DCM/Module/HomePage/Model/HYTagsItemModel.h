//
//  HYTagsItemModel.h
//  DaCongMing
//
//

#import "HYBaseModel.h"

@interface HYTagsItemModel : HYBaseModel

/**
 "id": "001",
 "name": "补肾",
 "image_url": "http://116.62.118.249:80/menu_image/brands/bod_24.png"
 */

/** id */
@property (nonatomic, copy) NSString *id;
/** name */
@property (nonatomic, copy) NSString *name;
/** img */
@property (nonatomic, copy) NSString *image_url;

@end
