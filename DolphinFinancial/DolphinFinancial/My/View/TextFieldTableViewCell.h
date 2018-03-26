//
//  TextFieldTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TextFieldTableViewCell : BaseTableViewCell

-(void)reloadWithTitle:(NSString *)title placeholder:(NSString *)placeholder didEndEditingHandle:(void(^)(NSString *text))handle;

@end
