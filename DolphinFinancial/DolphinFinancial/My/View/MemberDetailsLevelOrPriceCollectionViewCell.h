//
//  MemberDetailsLevelOrPriceCollectionViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseCollectionViewCell.h"

/**
 等级或者价格
 */
@interface MemberDetailsLevelOrPriceCollectionViewCell : BaseCollectionViewCell

- (void)reloadData:(NSString *)text color:(UIColor *)color;

@end
