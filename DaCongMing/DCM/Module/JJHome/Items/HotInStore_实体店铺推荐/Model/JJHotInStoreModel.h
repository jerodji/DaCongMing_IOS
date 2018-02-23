//
//  JJHotInStoreModel.h
//  DaCongMing
//
//  Created by hailin on 2018/1/24.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJHotInStoreModel : NSObject
@property (nonatomic, copy) NSString* itemName;
@property (nonatomic, copy) NSString* itemTitleImage;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* jumpUrl;
@end

/**
 {
     "itemName": "滋补极品 营养 大燕条【批发100克*1盒】",
     "itemTitleImage": "http://pic.laopdr.cn:80/item_image/05e84920c2644362bef08f70582231d5.jpg",
     "price": "2500.0",
     "jumpUrl": "http://www.laopdr.cn/app/itemDetail?id=HL0048"
 }
 */
