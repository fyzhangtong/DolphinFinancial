//
//  MessageCenterTableViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseTableViewCell.h"

@class DFNotice;

/**
 消息cell
 */
@interface MessageCenterTableViewCell : BaseTableViewCell

- (void)reloadData:(DFNotice *)notice;

@end
