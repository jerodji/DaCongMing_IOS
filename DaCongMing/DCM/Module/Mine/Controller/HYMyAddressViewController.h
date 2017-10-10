//
//  HYMyAddressViewController.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"
#import "HYMyAddressModel.h"

typedef void(^selectAddressBlock)(HYMyAddressModel *addressModel);

@interface HYMyAddressViewController : HYBaseViewController

/** 是否从订单跳转过来 */
@property (nonatomic,assign) BOOL isJump;

/** 选择地址回传block */
@property (nonatomic,copy) selectAddressBlock selectAddBlock;

@end
