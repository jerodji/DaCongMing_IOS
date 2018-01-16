//
//  HYBrandShopInfoModel.h
//  DaCongMing
//
//

#import <Foundation/Foundation.h>

@interface HYBrandShopRecommendModel : NSObject

@property (nonatomic,copy) NSString *seller_id;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *img_url;
@property (nonatomic,copy) NSString *item_id;


@end

@interface HYBrandShopStoreInfo : NSObject

@property (nonatomic,copy) NSString *seller_id;
@property (nonatomic,copy) NSString *seller_name;
@property (nonatomic,copy) NSString *seller_pwd;
@property (nonatomic,copy) NSString *isFavorite;
@property (nonatomic,copy) NSArray *storeImages;
@property (nonatomic,copy) NSString *hotsaleCount;
@property (nonatomic,copy) NSString *itemCount;
@property (nonatomic,copy) NSString *itemNewCount;
@property (nonatomic,copy) NSString *wall_img;
@property (nonatomic,copy) NSString *store_logo;
@property (nonatomic,copy) NSArray *storeAdvertisingMaps;

@end

@interface HYBrandShopInfoModel : NSObject

/** Item列表 */
@property (nonatomic,copy) NSArray *itemList;
/** 店铺信息 */
@property (nonatomic,strong) HYBrandShopStoreInfo *storeInfo;

@end

