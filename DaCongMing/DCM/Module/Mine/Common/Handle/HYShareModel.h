//
//  HYShareModel.h
//  DaCongMing
//
//  Created by Jack on 2018/1/4.
//  Copyright © 2018年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HYShareType) {
    HYShareTypeImage,
    HYShareTypeText,
    HYShareTypeMusic,
    HYShareTypeVideo,
    HYShareTypeWebUrl,
};

typedef NS_ENUM(NSUInteger, HYShareScene) {
    HYShareSceneSession,
    HYShareSceneTimeline,
    HYShareSceneFavorite,
};

@interface HYShareModel : NSObject

@property (nonatomic,assign) HYShareType shareType;
@property (nonatomic,assign) HYShareScene shareScene;
/** 分享文本 */
@property (nonatomic, copy)  NSString *text;

/** 分享图片 */
@property (nonatomic, copy)  UIImage *thumbnailImage;
@property (nonatomic, copy)  UIImage *image;

/** 分享网页 */
@property (nonatomic, copy)  NSString *shareWebUrl;
@property (nonatomic, copy)  NSString *shareTitle;
@property (nonatomic, copy)  NSString *shareDescription;


@end
