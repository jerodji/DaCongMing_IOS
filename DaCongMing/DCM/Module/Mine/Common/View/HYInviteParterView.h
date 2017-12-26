//
//  HYInviteParterView.h
//  DaCongMing
//
//  Created by Jack on 2017/12/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^jumpToPayVCBlock)(void);

@interface HYInviteParterView : UIView

/** 立即支付 */
@property (nonatomic,copy) jumpToPayVCBlock payBlock;

- (void)showInviteView;

@end
