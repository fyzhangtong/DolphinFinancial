//
//  ChangePasswordButtonTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol ChangePasswordButtonTableViewCellDelegate<NSObject>

@required
- (void)confirmChangePassword;

@end

@interface ChangePasswordButtonTableViewCell : BaseTableViewCell

@property (nonatomic, weak) id<ChangePasswordButtonTableViewCellDelegate> delegate;

@end
