//
//  HYSortModel.h
//  DaCongMing
//
//

#import "HYBaseModel.h"

@interface HYSortModel : HYBaseModel <NSCoding>

/**
 *  "guid": null,
 "type_id": "001",
 "type_name": "干货药材",
 "img_url": "http://116.62.118.249/type_image/classify_1.png"
 */

/** guid */
@property (nonatomic, copy) NSString *guid;
/** type_id */
@property (nonatomic, copy) NSString *type_id;
/** type_name */
@property (nonatomic, copy) NSString *type_name;
/** img_url */
@property (nonatomic, copy) NSString *img_url;

@end
