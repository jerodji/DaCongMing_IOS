//
//  AreaView.m
//  Shihanbainian
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 Codeliu. All rights reserved.
//

#import "AreaView.h"
#import "HYProvinceModel.h"
#import "HYCityModel.h"
#import "HYAreaModel.h"

@implementation AreaView
{
    UIView *blackBaseView;
    CGFloat btn1Height;
    CGFloat btn2Height;
    CGFloat btn3Height;
}

CG_INLINE CGRect CGRectMakes(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    float secretNum = [[UIScreen mainScreen] bounds].size.width / 375;
    rect.origin.x = x*secretNum; rect.origin.y = y * secretNum;
    rect.size.width = width*secretNum; rect.size.height = height*secretNum;
    
    return rect;
}

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define HTFont(s) [UIFont fontWithName:@"Helvetica-Light" size:s / 2 * MULPITLE]
#define MULPITLE [[UIScreen mainScreen] bounds].size.width / 375

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizesSubviews = NO;
        _provinceArray = [[NSMutableArray alloc] init];
        _cityArray = [[NSMutableArray alloc] init];
        _areaArray = [[NSMutableArray alloc] init];
        
        [self creatBaseUI];
    }
    return self;
}


- (void)creatBaseUI{
    
    blackBaseView = [[UIView alloc] initWithFrame:self.bounds];
    blackBaseView.backgroundColor = [UIColor blackColor];
    blackBaseView.alpha = 0;
    [self addSubview:blackBaseView];
    
    _areaWhiteBaseView = [[UIView alloc] initWithFrame:CGRectMakes(0, 667, 375, 380)];
    _areaWhiteBaseView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_areaWhiteBaseView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMakes(0, 0, 375, 50)];
    titleLabel.text = @"所在地";
    titleLabel.textColor = RGBCOLOR(0, 0, 34);
    titleLabel.font = HTFont(34);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_areaWhiteBaseView addSubview:titleLabel];
    
    for (int i = 0; i < 3; i++) {
        UIButton *areaBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        areaBtn.frame = CGRectMakes(80 * i, 50, 80, 30);
        [areaBtn setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
        areaBtn.tag = 100 + i;
        [areaBtn setTitle:@"" forState:UIControlStateNormal];
        [areaBtn addTarget:self action:@selector(areaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        areaBtn.userInteractionEnabled = NO;
        [_areaWhiteBaseView addSubview:areaBtn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMakes(80 * i + 10, 78, 60, 2)];
        lineView.backgroundColor = RGBCOLOR(83, 215, 111);
        [_areaWhiteBaseView addSubview:lineView];
        lineView.tag = 300 + i;
        lineView.hidden = YES;
        if (i == 0) {
            areaBtn.userInteractionEnabled = YES;
            [areaBtn setTitle:@"请选择" forState:UIControlStateNormal];
            [areaBtn setTitleColor:RGBCOLOR(83, 215, 111) forState:UIControlStateNormal];
            lineView.hidden = NO;
        }
    }
    
    _areaScrollView = [[UIScrollView alloc]initWithFrame:CGRectMakes(0, 80, 375, 300)];
    _areaScrollView.delegate = self;
    _areaScrollView.contentSize = CGSizeMake(375 * MULPITLE * 1, 300 * MULPITLE);
    _areaScrollView.pagingEnabled = YES;
    _areaScrollView.showsVerticalScrollIndicator = NO;
    _areaScrollView.showsHorizontalScrollIndicator = NO;
    [_areaWhiteBaseView addSubview:_areaScrollView];

    for (int i = 0; i < 3; i++) {
        
        UITableView *area_tableView = [[UITableView alloc]initWithFrame:CGRectMakes(375 * i, 0, 375, 300) style:UITableViewStylePlain];
        area_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        area_tableView.delegate = self;
        area_tableView.dataSource = self;
        area_tableView.tag = 200 + i;
        [_areaScrollView addSubview:area_tableView];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHidenGes)];
    [blackBaseView addGestureRecognizer:tap];
}
#pragma mark - tapHidenGes
- (void)tapHidenGes{
    
    [self hidenAreaView];
}

#pragma mark - areaBtnAction
- (void)areaBtnAction:(UIButton *)btn
{
    for (UIView *view in _areaWhiteBaseView.subviews) {
        if (view.tag >= 300) {
            view.hidden = YES;
        }
    }
    UIView *lineView = [_areaWhiteBaseView viewWithTag:300 + btn.tag - 100];
    lineView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _areaScrollView.contentOffset = CGPointMake(375 * MULPITLE * (btn.tag - 100), 0);
    }];
}

- (void)setProvinceArray:(NSMutableArray *)provinceArray{
    
    _provinceArray = provinceArray;
    UITableView *tableView = [_areaScrollView viewWithTag:200];
    [tableView reloadData];
}

- (void)setCityArray:(NSMutableArray *)cityArray{
    
    _cityArray = cityArray;
    UITableView *tableView = [_areaScrollView viewWithTag:201];
    [tableView reloadData];
    _areaScrollView.contentSize = CGSizeMake(375 * MULPITLE * 2, 300 * MULPITLE);
    [UIView animateWithDuration:0.5 animations:^{
        
        _areaScrollView.contentOffset = CGPointMake(375 * MULPITLE, 0);
    }];
}

- (void)setAreaArray:(NSMutableArray *)areaArray{
    
    _areaArray = areaArray;
    UITableView *tableView = [_areaScrollView viewWithTag:202];
    [tableView reloadData];
    _areaScrollView.contentSize = CGSizeMake(375 * MULPITLE * 3, 300 * MULPITLE);
    [UIView animateWithDuration:0.5 animations:^{
        _areaScrollView.contentOffset = CGPointMake(375 * 2 * MULPITLE, 0);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag - 200) {
        case 0:
        {
            return _provinceArray.count;
        }
            break;
        case 1:
        {
            return _cityArray.count;
        }
            break;
        case 2:
        {
            return _areaArray.count;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44 * MULPITLE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"area_cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"area_cell"];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = RGBCOLOR(255,238,238);
    cell.textLabel.highlightedTextColor = RGBCOLOR(83, 215, 111);
    switch (tableView.tag - 200) {
        case 0:
        {
            HYProvinceModel *provinceModel = _provinceArray[indexPath.row];
            cell.textLabel.text = provinceModel.province;
            cell.textLabel.font = HTFont(28);
            cell.textLabel.textColor = RGBCOLOR(102, 102, 102);
        }
            break;
        case 1:
        {
            HYCityModel *cityModel = _cityArray[indexPath.row];
            cell.textLabel.text = cityModel.city;
            cell.textLabel.font = HTFont(28);
            cell.textLabel.textColor = RGBCOLOR(102, 102, 102);
        }
            break;
        case 2:
        {
            HYAreaModel *areaModel = _areaArray[indexPath.row];
            cell.textLabel.text = areaModel.area;
            cell.textLabel.font = HTFont(28);
            cell.textLabel.textColor = RGBCOLOR(102, 102, 102);
        }
            break;
        default:
            break;
    }

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIButton *btn1 = [_areaWhiteBaseView viewWithTag:100];
    UIButton *btn2 = [_areaWhiteBaseView viewWithTag:101];
    UIButton *btn3 = [_areaWhiteBaseView viewWithTag:102];
    
    for (UIView *view in _areaWhiteBaseView.subviews) {
        if (view.tag >= 300) {
            view.hidden = YES;
        }
    }
    
    UIView *lineView1 = [_areaWhiteBaseView viewWithTag:300];
    UIView *lineView2 = [_areaWhiteBaseView viewWithTag:301];
    UIView *lineView3 = [_areaWhiteBaseView viewWithTag:302];
    switch (tableView.tag - 200) {
        case 0:
        {
            HYProvinceModel *provinceModel = _provinceArray[indexPath.row];
            btn1Height = [AreaView getLabelWidth:provinceModel.province font:30 height:30] + 20;
            [btn1 setTitle:provinceModel.province forState:UIControlStateNormal];
            [btn1 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            btn1.frame = CGRectMakes(0, 50, btn1Height, 30);
            btn2.frame = CGRectMakes(btn1Height, 50, 80, 30);
            btn1.userInteractionEnabled = YES;
            btn2.userInteractionEnabled = YES;
            btn3.userInteractionEnabled = NO;
            [btn2 setTitle:@"请选择" forState:UIControlStateNormal];
            [btn2 setTitleColor:RGBCOLOR(83, 215, 111) forState:UIControlStateNormal];
            [btn3 setTitle:@"" forState:UIControlStateNormal];

            lineView2.hidden = NO;
            lineView1.frame = CGRectMakes(10, 78, btn1Height - 20, 2);
            lineView2.frame = CGRectMakes(btn1Height + 10, 78, 80 - 20, 2);
            
            //获取点击的省的市
            [self getCityDataFromProvinceModel:provinceModel];
        }
            break;
        case 1:
        {
            HYCityModel *cityModel = _cityArray[indexPath.row];
            btn2Height = [AreaView getLabelWidth:cityModel.city font:30 height:30] + 20;
            [btn2 setTitle:cityModel.city forState:UIControlStateNormal];
            [btn2 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            [btn3 setTitle:@"请选择" forState:UIControlStateNormal];
            [btn3 setTitleColor:RGBCOLOR(83, 215, 111) forState:UIControlStateNormal];
            lineView3.hidden = NO;
            lineView2.frame = CGRectMakes(btn1Height + 10, 78, btn2Height - 20, 2);
            lineView3.frame = CGRectMakes(btn1Height + btn2Height + 10, 78, 80 - 20, 2);
            btn3.userInteractionEnabled = YES;
            btn2.frame = CGRectMakes(btn1Height, 50, btn2Height, 30);
            btn3.frame = CGRectMakes(btn1Height + btn2Height, 50, 80, 30);
            //获取点击的城市的县
            [self getAreaDataFromProvinceModel:cityModel];
        }
            break;
        case 2:
        {
            HYAreaModel *areaModel = _areaArray[indexPath.row];
            btn3Height = [AreaView getLabelWidth:areaModel.area font:30 height:30] + 20;
            [btn3 setTitle:areaModel.area forState:UIControlStateNormal];
            [btn3 setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
            lineView3.hidden = NO;
            if (btn1Height + btn2Height + btn3Height > 375) {
                btn3Height = 375 - (btn1Height + btn2Height);
            }
            lineView3.frame = CGRectMakes(btn1Height + btn2Height + 10, 78, btn3Height - 20, 2);
            btn3.frame = CGRectMakes(btn1Height + btn2Height, 50, btn3Height, 30);
            [self hidenAreaView];
            
            
        }
            break;
        default:
            break;
    }

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (UIView *view in _areaWhiteBaseView.subviews) {
        if (view.tag >= 300) {
            
            view.hidden = YES;
        }
    }
    if (scrollView == _areaScrollView) {
        
        UIView *lineView = [_areaWhiteBaseView viewWithTag:300 + scrollView.contentOffset.x / (375 * MULPITLE)];
        lineView.hidden = NO;
    }
}

#pragma mark - dataHandel
- (void)getCityDataFromProvinceModel:(HYProvinceModel *)provinceModel{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dict in provinceModel.cities) {
        
        HYCityModel *cityModel = [HYCityModel modelWithDictionary:dict];
        [tempArray addObject:cityModel];
    }
    
    [self setCityArray:tempArray];
}

- (void)getAreaDataFromProvinceModel:(HYCityModel *)cityModel{
    
    NSMutableArray *tempArray = [NSMutableArray array];

    for (NSDictionary *dict in cityModel.areas) {
        
        HYAreaModel *areaModel = [HYAreaModel modelWithDictionary:dict];
        [tempArray addObject:areaModel];
    }
    [self setAreaArray:tempArray];
}

#pragma mark - showAreaView
- (void)showAreaView
{
    self.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        blackBaseView.alpha = 0.6;
        _areaWhiteBaseView.frame = CGRectMakes(0, 667 - 380, 375, 380);
    }];
}

#pragma mark - hidenAreaView
- (void)hidenAreaView
{
    UIButton *btn1 = [_areaWhiteBaseView viewWithTag:100];
    UIButton *btn2 = [_areaWhiteBaseView viewWithTag:101];
    UIButton *btn3 = [_areaWhiteBaseView viewWithTag:102];

    [UIView animateWithDuration:0.25 animations:^{
        blackBaseView.alpha = 0;
        _areaWhiteBaseView.frame = CGRectMakes(0, 667, 375, 380);
    }completion:^(BOOL finished) {
        self.hidden = YES;
        
        if (_delegate && [_delegate respondsToSelector:@selector(getSelectAddressProvince:city:area:)]) {
            
            [_delegate getSelectAddressProvince:btn1.titleLabel.text city:btn2.titleLabel.text area:btn3.titleLabel.text];
        }
    }];
}

+ (CGFloat)getLabelWidth:(NSString *)textStr font:(CGFloat)fontSize height:(CGFloat)labelHeight
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 5 * MULPITLE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attribute = @{NSFontAttributeName: HTFont(fontSize),NSParagraphStyleAttributeName:paraStyle};
    CGSize size = [textStr boundingRectWithSize:CGSizeMake(1000, labelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return size.width;
}


@end
