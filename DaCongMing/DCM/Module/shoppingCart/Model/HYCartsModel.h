//
//  HYCartsModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCartsModel : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *cart_id;
@property (nonatomic,copy) NSArray *cartSellers;

@end

//商家
@interface HYCartsSeller : NSObject

@property (nonatomic,copy) NSString *seller_id;
@property (nonatomic,copy) NSString *seller_name;
@property (nonatomic,copy) NSString *cart_id;
@property (nonatomic,copy) NSArray *cartItems;
/** 商家购物车购物车是否选中 */
@property (nonatomic,assign) BOOL isSelect;

@end

@interface HYCartItem : NSObject

@property (nonatomic,copy) NSString *item_id;
@property (nonatomic,copy) NSString *item_name;
@property (nonatomic,copy) NSString *item_type;
@property (nonatomic,copy) NSString *item_min_price;
@property (nonatomic,copy) NSString *item_note;
@property (nonatomic,copy) NSString *item_of_seller;
@property (nonatomic,copy) NSString *item_title_image;
@property (nonatomic,copy) NSString *isFavorite;
@property (nonatomic,copy) NSString *salesVolume;
@property (nonatomic,copy) NSString *provincePrice;


@end

@interface HYCartItems : NSObject

@property (nonatomic,copy) NSString *guid;
@property (nonatomic,copy) NSString *unit;
@property (nonatomic,copy) NSString *qty;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *cart_id;
@property (nonatomic,copy) NSString *item_id;
@property (nonatomic,copy) NSString *seller_id;
@property (nonatomic,strong) HYCartItem *item;

/** 购物车是否选中 */
@property (nonatomic,assign) BOOL isSelect;

@end

