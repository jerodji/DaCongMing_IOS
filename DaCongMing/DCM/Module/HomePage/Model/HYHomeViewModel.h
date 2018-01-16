//
//  HYHomeViewModel.h
//  DaCongMing
//
//

#import <Foundation/Foundation.h>
#import "HYHomePageModel.h"

@interface HYHomeViewModel : NSObject

+ (void)requestHomePageData:(void(^)(HYHomePageModel *model))complemtion failureBlock:(void(^)())failure;

@end
