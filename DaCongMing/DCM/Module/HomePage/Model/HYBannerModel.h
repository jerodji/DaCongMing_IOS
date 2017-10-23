//
//  HYBannerModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYBannerModel : HYBaseModel

/** banner_id */
@property (nonatomic,copy) NSString *banner_id;
/** banner_type */
@property (nonatomic,copy) NSString *banner_type;
/** banner_imgUrl */
@property (nonatomic,copy) NSString *banner_imgUrl;
/** file_name */
@property (nonatomic,copy) NSString *file_name;


@end

/**
 *  "banner_id": "banner_572bec4b4c334cf8a6256b3e570aa65f",
 "banner_type": "001",
 "banner_imgUrl": "http://116.62.118.249:80/menu_image/banner_image/banner_b6b6f212f6044c849c0678432c469e72.jpg",
 "file_name": "banner_b6b6f212f6044c849c0678432c469e72.jpg",
 "file_path": "C:/menu_image/banner_image/banner_b6b6f212f6044c849c0678432c469e72.jpg"
 */