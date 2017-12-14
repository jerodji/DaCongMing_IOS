//
//  HYUserModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//


#import "HYBaseModel.h"

@interface HYParterRecommend : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *recomlevel;
@property (nonatomic, copy) NSString *recomMsg;
@property (nonatomic, copy) NSString *recomer_name;
@property (nonatomic, copy) NSString *recomer_phone;
@property (nonatomic, copy) NSString *stat;

@end

@interface HYUserInfo : NSObject <NSCoding>

/** id */
@property (nonatomic, copy) NSString *id;
/** name */
@property (nonatomic, copy) NSString *name;
/** age */
@property (nonatomic, copy) NSString *age;
/** sex */
@property (nonatomic, copy) NSString *sex;
/** adress */
@property (nonatomic, copy) NSString *adress;
/** phone */
@property (nonatomic, copy) NSString *phone;
/** note */
@property (nonatomic, copy) NSString *note;
/** head_image_url */
@property (nonatomic, copy) NSString *head_image_url;
/** qr */
@property (nonatomic, copy) NSString *qrpath;
/** 推荐人 */
@property (nonatomic,strong) HYParterRecommend *userRemind;

@end

@interface HYUserModel : HYBaseModel <NSCoding>
/** token */
@property (nonatomic,copy) NSString *token;
/** userinfo */
@property (nonatomic,strong) HYUserInfo *userInfo;

/** 单例 */
+ (instancetype)sharedInstance;
/** 清除所有的数据 */
- (void)clearData;



@end
