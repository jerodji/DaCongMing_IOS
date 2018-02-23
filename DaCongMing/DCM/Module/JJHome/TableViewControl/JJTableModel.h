//
//  JJTableModel.h
//  DaCongMing
//
//  Created by hailin on 2018/1/20.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJTableModel : NSObject

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, copy) NSString* showType;
@property (nonatomic, strong) NSArray* bannerList;
@property (nonatomic, strong) NSDictionary* MAP;//showTypeMap
@property (nonatomic, copy) NSString* title;     //MAP
@property (nonatomic, copy) NSString* smallTitle;//MAP
@property (nonatomic, strong) NSArray* block;//MAP
@property (nonatomic, copy) NSString* imageUrl;//MAP
@property (nonatomic, copy) NSString* jumpUrl;//MAP
@property (nonatomic,copy) NSString * name;//MAP
@property (nonatomic,copy) NSString * type;//MAP
@end

/**
 {
    "showType": "SortType"
    "SortType": {
        "block": [
             {"imageUrl": "http://pic.laopdr.cn:80/home_page_image/7e804310fd49423b9c305b48fe415403.png",
             "jumpUrl": "http://www.laopdr.cn/app/itemTypeDetail?id=008&title=产品分类"},
             {"imageUrl": "http://pic.laopdr.cn:80/home_page_image/7e804310fd49423b9c305b48fe415403.png",
             "jumpUrl": "http://www.laopdr.cn/app/itemTypeDetail?id=008&title=产品分类"},
         ],
        "title": "产品分类",
        "smallTtile": "Product categories"
     },
 }
 */
