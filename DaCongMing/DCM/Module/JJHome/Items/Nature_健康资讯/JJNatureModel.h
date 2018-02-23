//
//  JJNatureModel.h
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJNatureModel : NSObject

+ (JJNatureModel*)modelFromDict:(NSDictionary*)dict;

@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* descriptions;
@property (nonatomic, copy) NSString* jumpUrl;

@end

/**
 {
 "img": "http://pic.laopdr.cn/article_image/0c324171123143efac7e566e10f5eaae.jpg",
 "title": "这个疯狂的男人真的是一位50岁的大叔",
 "descriptions": "登上ins热搜的这个老男人，却依然是女人的迷魂药",
 "jumpUrl": "http://www.laopdr.cn/HAILIN_AGENT_SERVER/article/3f33f6dc-ae5f-4471-a398-3bb70e6f6660.do"
 }
 */

/**
 {
     content = "<null>";
     createdAt = 1517974420000;
     createdAtFormat = "2018-02-07 11:33:40";
     createdUserId = "<null>";
     descriptions = "\U8eab\U8fb9\U6709\U80c3\U75db\Uff0c\U80c3\U75c5\U7684\U4f19\U4f34\U4eec\U5feb\U4e3a\U4ed6\U4eec\U6536\U85cf\U5427\Uff01";
     id = 152;
     img = "http://pic.laopdr.cn/article_image/0acb1b25b2b74353b72f1cede2929b19.jpg";
     shareRate = "<null>";
     shareUrl = "http://www.laopdr.cn/HAILIN_SERVER/article/8e4b7d44-84a0-484a-ac8f-92daf675c5ce.do";
     status = "<null>";
     title = "\U80c3\U4e0d\U597d\U559d\U7ca5\U4e0d\U79d1\U5b66\Uff1f\U517b\U80c3\U5e94\U8be5\U5403\U4ec0\U4e48\Uff1f";
     updatedAt = 1517975276000;
     updatedUserId = "<null>";
     url = "http://www.laopdr.cn/HAILIN_AGENT_SERVER/article/8e4b7d44-84a0-484a-ac8f-92daf675c5ce.do";
     uuid = "8e4b7d44-84a0-484a-ac8f-92daf675c5ce";
 }
 */
