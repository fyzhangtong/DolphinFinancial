//
//  WithdrawaisPaymentDateTableViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "WithdrawaisPaymentDateTableViewCell.h"

@implementation WithdrawaisPaymentDateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeView];
    }
    return self;
}

+ (NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}
+ (CGFloat)cellHeight
{
    return 95;
}

+ (void)registerCellTableView:(UITableView *)tableView{
    [tableView registerClass:[self class] forCellReuseIdentifier:[self reuseIdentifier]];
}

- (void)makeView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
}

@end
