//
//  ProductDynamicCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "ProductDynamicCollectionViewCell.h"
#import "DFProductDynamics.h"
#import "Borrower.h"

@interface ProductDynamicCollectionViewCell()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *owePeoplePhoneNumberLabel;
@property (nonatomic, strong) UILabel *owePeopleAmountLabel;
@property (nonatomic, strong) UILabel *owePeopleDateLabel;
@property (nonatomic, strong) UILabel *borrower1PhoneNumberLabel;
@property (nonatomic, strong) UILabel *borrower2PhoneNumberLabel;
@property (nonatomic, strong) UILabel *explainLabel;
@property (nonatomic, strong) UIImageView *centerArrowImageView;

@end

@implementation ProductDynamicCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self makeView];
    }
    return self;
}

+ (CGSize)cellSize
{
    return CGSizeMake(DFSCREENW, 85);
}
+ (NSString*)reuseIdentifier
{
    return NSStringFromClass([self class]);
}
+ (void)registCell:(UICollectionView *) collectionView
{
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:[self reuseIdentifier]];
}

- (void)makeView
{
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.width.height.mas_equalTo(16);
    }];
    
    [self.contentView addSubview:self.centerArrowImageView];
    [self.centerArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(24);
    }];
    
    [self.contentView addSubview:self.owePeoplePhoneNumberLabel];
    [self.owePeoplePhoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageView);
        make.left.mas_equalTo(self.headImageView.mas_right).mas_offset(7);
        make.height.mas_equalTo(23);
    }];
    [self.contentView addSubview:self.owePeopleAmountLabel];
    [self.owePeopleAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.owePeoplePhoneNumberLabel.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(self.owePeoplePhoneNumberLabel.mas_left);
        make.height.mas_equalTo(23);
    }];
    [self.contentView addSubview:self.owePeopleDateLabel];
    [self.owePeopleDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.owePeopleAmountLabel.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(self.owePeoplePhoneNumberLabel.mas_left);
        make.height.mas_equalTo(23);
    }];
    
    [self.contentView addSubview:self.borrower1PhoneNumberLabel];
    [self.borrower1PhoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.owePeoplePhoneNumberLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-53);
    }];
    [self.contentView addSubview:self.borrower2PhoneNumberLabel];
    [self.borrower2PhoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.owePeopleAmountLabel.mas_centerY);
        make.left.mas_equalTo(self.borrower1PhoneNumberLabel.mas_left);
    }];
    [self.contentView addSubview:self.explainLabel];
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.owePeopleDateLabel.mas_centerY);
        make.left.mas_equalTo(self.borrower1PhoneNumberLabel.mas_left);
    }];
    
}
#pragma mark - getter
- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_head"]];
    }
    return _headImageView;
}
- (UIImageView *)centerArrowImageView
{
    if (!_centerArrowImageView) {
        _centerArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"finacial_details"]];
    }
    return _centerArrowImageView;
}

- (UILabel *)owePeoplePhoneNumberLabel
{
    if (!_owePeoplePhoneNumberLabel) {
        _owePeoplePhoneNumberLabel = [UILabel new];
        _owePeoplePhoneNumberLabel.textAlignment = NSTextAlignmentCenter;
        _owePeoplePhoneNumberLabel.font = [UIFont systemFontOfSize:14];
        _owePeoplePhoneNumberLabel.textColor = DFColorWithHexString(@"#101010");
    }
    return _owePeoplePhoneNumberLabel;
}
- (UILabel *)owePeopleAmountLabel
{
    if (!_owePeopleAmountLabel) {
        _owePeopleAmountLabel = [UILabel new];
        _owePeopleAmountLabel.textAlignment = NSTextAlignmentCenter;
        _owePeopleAmountLabel.font = [UIFont systemFontOfSize:12];
        _owePeopleAmountLabel.textColor = DFColorWithHexString(@"#101010");
    }
    return _owePeopleAmountLabel;
}
- (UILabel *)owePeopleDateLabel
{
    if (!_owePeopleDateLabel) {
        _owePeopleDateLabel = [UILabel new];
        _owePeopleDateLabel.textAlignment = NSTextAlignmentCenter;
        _owePeopleDateLabel.font = [UIFont systemFontOfSize:12];
        _owePeopleDateLabel.textColor = DFColorWithHexString(@"#BBBBBB");
    }
    return _owePeopleDateLabel;
}


- (UILabel *)borrower1PhoneNumberLabel
{
    if (!_borrower1PhoneNumberLabel) {
        _borrower1PhoneNumberLabel = [UILabel new];
        _borrower1PhoneNumberLabel.textAlignment = NSTextAlignmentCenter;
        _borrower1PhoneNumberLabel.font = [UIFont systemFontOfSize:14];
        _borrower1PhoneNumberLabel.textColor = DFColorWithHexString(@"#101010");
    }
    return _borrower1PhoneNumberLabel;
}
- (UILabel *)borrower2PhoneNumberLabel
{
    if (!_borrower2PhoneNumberLabel) {
        _borrower2PhoneNumberLabel = [UILabel new];
        _borrower2PhoneNumberLabel.textAlignment = NSTextAlignmentCenter;
        _borrower2PhoneNumberLabel.font = [UIFont systemFontOfSize:14];
        _borrower2PhoneNumberLabel.textColor = DFColorWithHexString(@"#101010");
    }
    return _borrower2PhoneNumberLabel;
}
- (UILabel *)explainLabel
{
    if (!_explainLabel) {
        _explainLabel = [UILabel new];
        _explainLabel.textAlignment = NSTextAlignmentCenter;
        _explainLabel.font = [UIFont systemFontOfSize:12];
        _explainLabel.textColor = DFColorWithHexString(@"#BBBBBB");
    }
    return _explainLabel;
}

- (void)reloadProduct:(DFProductDynamics *)dynamic
{
    self.owePeoplePhoneNumberLabel.text = dynamic.product_name;
    self.owePeopleAmountLabel.text = dynamic.buy_amount;
    self.owePeopleDateLabel.text = dynamic.buy_time;
    if (dynamic.borrowers.count > 0) {
        self.borrower1PhoneNumberLabel.text = dynamic.borrowers[0].borrower;
    }
    if (dynamic.borrowers.count > 1) {
        self.borrower2PhoneNumberLabel.text = dynamic.borrowers[1].borrower;
    }
    if (dynamic.borrowers.count>2) {
        self.explainLabel.text = [NSString stringWithFormat:@"等%ld位借款人",dynamic.borrowers.count];
    }else{
        self.explainLabel.text = [NSString stringWithFormat:@"%ld位借款人",dynamic.borrowers.count];
    }    
}


@end
