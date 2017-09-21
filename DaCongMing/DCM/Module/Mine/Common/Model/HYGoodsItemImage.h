//
//  HYGoodsItemImage.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

/**
 *  "guid": null,
 "id": "image_730a1cd8595342b1a00b3fa8997ad372",
 "imageName": null,
 "fileUrl": "http://116.62.118.249:80/item_image/image_730a1cd8595342b1a00b3fa8997ad372.jpg",
 "file_path": null,
 "item_id": null,
 "image_note": null,
 "image_type": "item_image_note",
 "sequence_name": null,
 "isdef": null
 */

@interface HYGoodsItemImage : HYBaseModel

/** id */
@property (nonatomic, copy) NSString *id;
/** url */
@property (nonatomic, copy) NSString *fileUrl;
/** image_type */
@property (nonatomic, copy) NSString *image_type;

@end
