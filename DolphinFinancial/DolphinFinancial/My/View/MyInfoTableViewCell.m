//
//  MyInfoTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/20.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyInfoTableViewCell.h"

@interface MyInfoTableViewCell()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *tagLabel;        //标签
@property (nonatomic, strong) UILabel *phoneNumber;     //手机号

@end

@implementation MyInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}
+ (CGFloat)cellHeight
{
    return 70;
}

+ (void)registerCellTableView:(UITableView *)tableView{
    [tableView registerClass:[self class] forCellReuseIdentifier:[self reuseIdentifier]];
}

- (void)makeView
{
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.with.mas_equalTo(40);
    }];
    
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_top);
        make.left.mas_equalTo(self.headImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
    
    [self.contentView addSubview:self.phoneNumber];
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tagLabel.mas_left);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom);
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
- (UILabel *)tagLabel
{
    if (!_tagLabel) {
        _tagLabel = [UILabel new];
        _tagLabel.textColor = DFColorWithHexString(@"#101010");
        _tagLabel.layer.borderColor = DFColorWithHexString(@"#BBBBBB").CGColor;
        _tagLabel.layer.borderWidth = 1;
        _tagLabel.layer.cornerRadius = 4;
        _tagLabel.font = [UIFont systemFontOfSize:8];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.text = @"普通会员";
    }
    return _tagLabel;
}
- (UILabel *)phoneNumber
{
    if (!_phoneNumber) {
        _phoneNumber = [UILabel new];
        _phoneNumber.textColor = DFColorWithHexString(@"#101010");
        _phoneNumber.font = [UIFont systemFontOfSize:14];
        _phoneNumber.textAlignment = NSTextAlignmentCenter;
        _phoneNumber.text = @"133****1920";
    }
    return _phoneNumber;
}

@end
