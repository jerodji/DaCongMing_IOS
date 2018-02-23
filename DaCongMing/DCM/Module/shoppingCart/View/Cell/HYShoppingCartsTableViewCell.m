//
//  HYShoppingCartsTableViewCell.m
//  DaCongMing
//
//

#import "HYShoppingCartsTableViewCell.h"
#import "HYCartsItemTableViewCell.h"

@interface HYShoppingCartsTableViewCell() <UITableViewDelegate,UITableViewDataSource>

/** 商家选择 */
@property (nonatomic,strong) UIButton *sellerCheackAllBtn;
/** 商家icon */
@property (nonatomic,strong) UIImageView *sellerIconImgView;
/** 商家名称 */
@property (nonatomic,strong) UILabel *sellerNameLabel;
/** 商家线 */
@property (nonatomic,strong) UIView *sellerLine;
/** 每个商品 */
@property (nonatomic,strong) UITableView *tableView;
/** 每个itemModel */
@property (nonatomic,strong) NSMutableArray *itemModelArray;

@end

@implementation HYShoppingCartsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        [self addNotification];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.sellerCheackAllBtn];
    [self addSubview:self.sellerIconImgView];
    [self addSubview:self.sellerNameLabel];
    [self addSubview:self.sellerLine];
    [self addSubview:self.tableView];
}

- (void)layoutSubviews{
    
    [_sellerCheackAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_sellerIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_sellerCheackAllBtn.mas_right).offset(6 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(6 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(18 * WIDTH_MULTIPLE);
    }];
    
    [_sellerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_sellerIconImgView.mas_right).offset(6 * WIDTH_MULTIPLE);
        make.top.equalTo(self);
        make.width.mas_equalTo(200);
        make.height.equalTo(_sellerCheackAllBtn);
    }];
    
    [_sellerLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(_sellerCheackAllBtn.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        CGFloat height = _cartsSeller.cartItems.count * 80 * WIDTH_MULTIPLE;
        make.left.right.equalTo(self);
        make.top.equalTo(_sellerLine.mas_bottom);
        make.height.mas_equalTo(height);
    }];
}

#pragma mark - notification
- (void)addNotification{
    
    //购物车数量发生变化，通知刷新tableView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartsValueChanged:) name:KShoppingCartsCountChanged object:nil];
}

- (void)shoppingCartsValueChanged:(NSNotification *)notification{
    
    NSLog(@"%@",notification.object);
    NSLog(@"%@",notification.userInfo);
    
}

#pragma mark - setter
- (void)setCartsSeller:(HYCartsSeller *)cartsSeller{
    
    _cartsSeller = cartsSeller;
    
    _sellerNameLabel.text = cartsSeller.seller_name;
    [self.itemModelArray removeAllObjects];
    _sellerCheackAllBtn.selected = cartsSeller.isSelect;
    for (HYCartItems *items in _cartsSeller.cartItems) {
        
        items.isSelect = _sellerCheackAllBtn.selected;
        items.isEditing = cartsSeller.isEditing;
        [self.itemModelArray addObject:items];
    }
    
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        CGFloat height = self.itemModelArray.count * 80 * WIDTH_MULTIPLE;
        make.height.mas_equalTo(height);
        [_tableView reloadData];
    }];
}

#pragma mark - action
- (void)sellerCheckAllBtnAction:(UIButton *)button{
    
    NSLog(@"button.select is %d",button.selected);
    button.selected = !button.selected;
    NSLog(@"button.select is %d",button.selected);
    _cartsSeller.isSelect = button.selected;
    for (NSInteger i = 0; i < self.itemModelArray.count; i++) {
        
        HYCartItems *items = self.itemModelArray[i];
        items.isSelect = button.isSelected;
        [self.itemModelArray replaceObjectAtIndex:i withObject:items];
    }
    if (self.shoppingCartsChangedBlock) {
        
        self.shoppingCartsChangedBlock(_cartsSeller, self.indexPath);
    }
    
    [_tableView reloadData];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cartsSeller.cartItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cartsItemCellID = @"cartsItemCell";
    HYCartsItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cartsItemCellID];
    if (!cell) {
        cell = [[HYCartsItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cartsItemCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    HYCartItems *items = self.itemModelArray[indexPath.row];
    cell.items = items;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80 * WIDTH_MULTIPLE;
}


#pragma mark - lazyload
- (UIButton *)sellerCheackAllBtn{
    
    if (!_sellerCheackAllBtn) {
        
        _sellerCheackAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sellerCheackAllBtn setImage:[UIImage imageNamed:@"selectIcon"] forState:UIControlStateNormal];
        [_sellerCheackAllBtn setImage:[UIImage imageNamed:@"selectIconSelect"] forState:UIControlStateSelected];
        [_sellerCheackAllBtn addTarget:self action:@selector(sellerCheckAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sellerCheackAllBtn;
}

- (UIImageView *)sellerIconImgView{
    
    if (!_sellerIconImgView) {
        
        _sellerIconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _sellerIconImgView.contentMode = UIViewContentModeScaleAspectFit;
        _sellerIconImgView.clipsToBounds = YES;
        _sellerIconImgView.image = [UIImage imageNamed:@"product_shop"];
    }
    
    return _sellerIconImgView;
}

- (UILabel *)sellerNameLabel{
    
    if (!_sellerNameLabel) {
        
        _sellerNameLabel = [[UILabel alloc] init];
        _sellerNameLabel.font = KFitFont(13);
        _sellerNameLabel.textColor = KAPP_272727_COLOR;
        _sellerNameLabel.text = @"海林官方旗舰店";
        _sellerNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _sellerNameLabel;
}

- (UIView *)sellerLine{
    
    if (!_sellerLine) {
        
        _sellerLine = [UIView new];
        _sellerLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _sellerLine;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (NSMutableArray *)itemModelArray{
    
    if (!_itemModelArray) {
        _itemModelArray = [NSMutableArray array];
    }
    return _itemModelArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
