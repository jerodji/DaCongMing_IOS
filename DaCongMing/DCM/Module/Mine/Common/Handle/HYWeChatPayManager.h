//
//  HYWeChatPayManager.h
//  DaCongMing
//
//

#import "HYBaseModel.h"
#import "HYWeChatPayModel.h"

@interface HYWeChatPayManager : HYBaseModel

+ (void)wechatPayWith:(HYWeChatPayModel *)model;

@end
