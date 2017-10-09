//
//  HYAddressTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/28.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYAddressTableViewCell.h"

@interface HYAddressTableViewCell()

/** nameLabel */
@property (nonatomic,strong) UILabel *nameLabel;
/** phoneLabel */
@property (nonatomic,strong) UILabel *phoneLabel;
/** addressLabel */
@property (nonatomic,strong) UILabel *addressLabel;
/** setDefaultBtn */
@property (nonatomic,strong) UIButton *setDefaultBtn;
/** editBtn */
@property (nonatomic,strong) UIButton *editBtn;
/** deleteBtn */
@property (nonatomic,strong) UIButton *deleteBtn;
/** horizontalLine */
@property (nonatomic,strong) UIView *horizontalLine;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.setDefaultBtn];
    [self addSubview:self.editBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.horizontalLine];
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.width.mas_offset(50 * WIDTH_MULTIPLE);
        make.height.mas_offset(20);
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_nameLabel.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.top.equalTo(_nameLabel);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(13 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-60 * WIDTH_MULTIPLE);
    }];
    
    [_horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
        make.bottom.equalTo(self).offset(-40 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
        make.bottom.equalTo(self);
    }];
    
    [_setDefaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_nameLabel);
        make.height.mas_offset(40 * WIDTH_MULTIPLE);
        make.width.mas_offset(90 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.height.equalTo(_setDefaultBtn);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.mas_offset(60 * WIDTH_MULTIPLE);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(_setDefaultBtn);
        make.right.equalTo(_deleteBtn.mas_left).offset(-15 * WIDTH_MULTIPLE);
        make.width.mas_offset(60 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - setter
- (void)setAddressModel:(HYMyAddressModel *)addressModel{
    
    _addressModel = addressModel;
    
    _nameLabel.text = addressModel.receiver;
    _phoneLabel.text = addressModel.phoneNum;
     _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",addressModel.province,addressModel.city,addressModel.area,addressModel.address];
    
    if ([addressModel.isdefault integerValue] == 1) {
        
        _setDefaultBtn.selected = YES;
    }
}

#pragma mark - action
- (void)setDefaultBtnAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(addressBtnAcitonWithFlag:indexPath:)]) {
        
        [_delegate addressBtnAcitonWithFlag:0 indexPath:_indexPath];
    }
}

- (void)editBtnAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(addressBtnAcitonWithFlag:indexPath:)]) {
        
        [_delegate addressBtnAcitonWithFlag:1 indexPath:_indexPath];
    }
}

- (void)deleteBtnAction{
    
    
}

#pragma mark - lazyload
- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = KFitFont(14);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"哈罗德";
        _nameLabel.textColor = KAPP_272727_COLOR;
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = KFitFont(14);
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.text = @"13027104773";
        _phoneLabel.textColor = KAPP_272727_COLOR;
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel{
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = KFitFont(13);
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.text = @"13027104773";
        _addressLabel.textColor = KAPP_7b7b7b_COLOR;
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}

- (UIView *)horizontalLine{
    
    if (!_horizontalLine) {
        
        _horizontalLine = [[UIView alloc] init];
        _horizontalLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _horizontalLine;
}

- (UIButton *)setDefaultBtn{
    
    if (!_setDefaultBtn) {
        
        _setDefaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setDefaultBtn setImage:[UIImage imageNamed:@"order_pay"] forState:UIControlStateNormal];
        [_setDefaultBtn setTitle:@"设为默认" forState:UIControlStateNormal];
        [_setDefaultBtn setTitleColor:KAPP_7b7b7b_COLOR forState:UIControlStateNormal];
        _setDefaultBtn.titleLabel.font = KFitFont(14);
        [_setDefaultBtn setImage:[UIImage imageNamed:@"order_pay_select"] forState:UIControlStateSelected];
        _setDefaultBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _setDefaultBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        [_setDefaultBtn addTarget:self action:@selector(setDefaultBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _setDefaultBtn.tag = 101;
    }
    return _setDefaultBtn;
}

- (UIButton *)editBtn{
    
    if (!_editBtn) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"editAddress"] forState:UIControlStateNormal];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _editBtn.titleLabel.font = KFitFont(14);
        [_editBtn setTitleColor:KAPP_7b7b7b_COLOR forState:UIControlStateNormal];
        _editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        [_editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _editBtn.tag = 101;
    }
    return _editBtn;
}

- (UIButton *)deleteBtn{
    
    if (!_deleteBtn) {
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = KFitFont(14);
        _deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        [_deleteBtn setTitleColor:KAPP_7b7b7b_COLOR forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.tag = 101;
    }
    return _deleteBtn;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
