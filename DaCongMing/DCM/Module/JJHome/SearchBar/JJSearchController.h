//
//  JJSearchController.h
//  DaCongMing
//
//  Created by hailin on 2018/1/19.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJSearchBar.h"

@interface JJSearchController : NSObject
@property (nonatomic, strong) JJSearchBar * searchBar;
@property (nonatomic,copy) NSString * jumpUrl;
- (void)searchBarShow ;
- (void)searchBarHidden ;
@end
