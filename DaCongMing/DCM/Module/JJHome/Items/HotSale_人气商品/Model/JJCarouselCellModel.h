//
//  JJCarouselCellModel.h
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJCarouselCellModel : NSObject
/**
 {
     "itemName": "调和 佳品 肚痛健胃 整肠丸",
     "originalPrice": "240.0",
     "itemTitleImage": "http://pic.laopdr.cn:80/item_image/fae61c07c9c8455db7d7041d8d012c62.jpg",
     "origin": "泰国",
     "publicity": "调理人体肠胃奇效",
     "jumpUrl": "http://www.laopdr.cn/app/itemDetail?id=HL0109",
     "itemMinPrice": ""
 }
 */

+ (JJCarouselCellModel*)modelFromDict:(NSDictionary*)dict;

@property (nonatomic, copy) NSString* itemName;
@property (nonatomic, copy) NSString* originalPrice;
@property (nonatomic, copy) NSString* itemTitleImage;
@property (nonatomic, copy) NSString* origin;
@property (nonatomic, copy) NSString* publicity;
@property (nonatomic, copy) NSString* jumpUrl;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* itemId;

@end
