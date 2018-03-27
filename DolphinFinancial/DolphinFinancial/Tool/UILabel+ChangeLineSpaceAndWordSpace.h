//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpaceAndWordSpace)


/**
 *  改变行间距
 */
- (void)setText:(NSString *)string lineSpace:(float)space;

/**
 *  改变字间距
 */
- (void)setText:(NSString *)string wordSpace:(float)space;

/**
 *  改变行间距和字间距
 */
- (void)setText:(NSString *)string lineSpace:(float)lineSpace wordSpace:(float)wordSpace;

@end
