//
//  JJTimeReCModel.h
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJTimeReCModel : NSObject

+ (JJTimeReCModel*)modelFromDict:(NSDictionary*)dict;

@property (nonatomic, copy) NSString* itemName;
@property (nonatomic, copy) NSString* originalPrice;
@property (nonatomic, copy) NSString* itemTitleImage;
@property (nonatomic, copy) NSString* startTime;
@property (nonatomic, copy) NSString* endTime;
@property (nonatomic, copy) NSString* publicity;
@property (nonatomic, copy) NSString* jumpUrl;
@property (nonatomic, copy) NSString* price;

@end

/**
 {
 "itemName": "静心养神 健康 纯天然 艾草线香",
 "originalPrice": "390.0",
 "itemTitleImage": "http://pic.laopdr.cn:80/item_image/3f1607f37de04206acea854ed01e4e78.jpg",
 "publicity": "安心定神，杀菌去味",
 "jumpUrl": "http://www.laopdr.cn/app/itemDetail?id=HL0139",
 "itemMinPrice": "800.0",
 "startTime": "2018-01-24 00:00:00.0",
 "endTime": "2018-05-01 00:00:00.0",
 }
 */
