//
//  HYShareHandle.h
//  DaCongMing
//
//

#import <Foundation/Foundation.h>
#import "HYShareModel.h"

@interface HYShareHandle : NSObject

+ (void)shareToWechatWithModel:(HYShareModel *)shareModel;

@end
