//
//  HYCommentModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYCommentModel : HYBaseModel

/** 图像 */
@property (nonatomic,strong) NSString *head_image_url;
/** create_time */
@property (nonatomic,copy) NSString *create_time;
/** evaluate_level */
@property (nonatomic,copy) NSString *evaluate_level;
/** evaluate_msg */
@property (nonatomic,copy) NSString *evaluate_msg;
/** user_name */
@property (nonatomic,copy) NSString *user_name;
/** sorder_id */
@property (nonatomic,copy) NSString *sorder_id;
/** item_id */
@property (nonatomic,copy) NSString *item_id;
/** cell高度 */
@property (nonatomic,assign) CGFloat cellHeight;
/** evaluateCount */
@property (nonatomic,copy) NSString *evaluateCount;

@end

/**
 *  "create_time" = "2017-10-25 17:38:55.0";
 evaluateImgList = "<null>";
 "evaluate_level" = 5;
 "evaluate_msg" = "\U547c\U547c\U9ad8\U9ad8\U4f4e\U4f4e";
 guid = 201710251000000761322569;
 "item_id" = "item_d386811840e747ec87420496c3f34619";
 "sorder_id" = 010201710251000001085984828;
 "user_id" = "o-13MvxwjL-h-8jK4SP8BglgEYhc";
 "user_name" = "\U897f\U4f2f\U5229\U4e9a\U72fc";
 */
