//
//  CommonConfig.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/15.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#ifndef CommonConfig_h
#define CommonConfig_h

// 颜色
#define DFColor(r,g,b) DFColorWithAlpha(r,g,b,1)
#define DFColorWithAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//屏幕
#define DFSCREENW [UIScreen mainScreen].bounds.size.width
#define DFSCREENH [UIScreen mainScreen].bounds.size.height

/**
 获取实际大小
 
 @param value 设计大小
 @param design 设计比例
 @return 实际大小
 */
#define RV_WIDTH(value,design) ((value)/(design) * GTSCREENW)
/**
 按iPhone6 375.0f成比例
 
 @param value 设计大小
 @return 实际大小
 */
#define RV(value) RV_WIDTH((value),(375.f))


#endif /* CommonConfig_h */
