//
//  AreaView.h
//  Shihanbainian
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 Codeliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AreaSelectDelegate <NSObject>

- (void)getSelectAddressProvince:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end

@interface AreaView : UIView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIScrollView *areaScrollView;
@property(nonatomic,strong)UIView *areaWhiteBaseView;
@property(nonatomic,strong)NSMutableArray *provinceArray;
@property(nonatomic,strong)id <AreaSelectDelegate>delegate;

@property(nonatomic,strong)NSMutableArray *cityArray;
@property(nonatomic,strong)NSMutableArray *areaArray;

- (void)showAreaView;
- (void)hidenAreaView;

@end
