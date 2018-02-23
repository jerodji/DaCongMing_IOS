//
//  JJNatureView.m
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJNatureView.h"

@interface JJNatureView()
@property (nonatomic, assign) CGRect rectFrame;

@end

@implementation JJNatureView

- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSMutableArray*)dataArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.rectFrame = frame;
        _modelArray = [[NSMutableArray alloc] init];
        _modelArray = dataArray;
        
        
        for (int i=0; i<_modelArray.count; i++) {
            JJNatureCell* cell = [[JJNatureCell alloc] initWithFrame:CGRectMake(10, 5 + i*(HeightNature+20), KSCREEN_WIDTH-20, HeightNature)];
            JJNatureModel* model = _modelArray[i];
            
            cell.btnCB = ^{
                
                NSString* url = [NSString stringWithFormat:@"%@?img=%@&title=%@&descriptions=%@",model.jumpUrl,model.img,model.title,model.descriptions];
                [DCURLRouter pushURLString:url animated:YES];
            };
            [cell setModel:model];
            
            [self addSubview:cell];
        }
    }
    return self;
}

@end
