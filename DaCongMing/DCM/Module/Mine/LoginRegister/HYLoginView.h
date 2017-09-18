//
//  HYLoginView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^weChatSuccessBlock)();

@interface HYLoginView : UIView

/** block */
@property (nonatomic,copy) weChatSuccessBlock weChatBlock;

@end
