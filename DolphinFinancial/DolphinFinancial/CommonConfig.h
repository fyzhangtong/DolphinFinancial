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

//设置颜色 16进制
#define DFColorWithHex(col) \
({\
unsigned char r, g, b;\
b = col & 0xFF;\
g = (col >> 8) & 0xFF;\
r = (col >> 16) & 0xFF;\
UIColor *color = [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];\
(color);\
})\
//设置颜色 字符串
#define DFColorWithHexString(str) \
({\
const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];\
long x = strtol(cStr+1, NULL, 16);\
DFColorWithHex(x);\
})

//屏幕
#define DFSCREENW [UIScreen mainScreen].bounds.size.width
#define DFSCREENH [UIScreen mainScreen].bounds.size.height

//主题颜色
#define DFTINTCOLOR DFColorWithHexString(@"#1779D4")


//safeArray
#define SafeArrayObjectIndex(array, index) (array.count > index ? array[index] : nil)
#define SafeArrayAddObject(array, object) (object ? [array addObject:object] : nil)
//safeDictionary
#define SafeDictionarySetObject(dictionary, object, key) ((object && key) ? [dictionary setObject:object forKey:key] : nil)

/**
 获取实际大小
 
 @param value 设计大小
 @param design 设计比例
 @return 实际大小
 */
#define RV_WIDTH(value,design) ((value)/(design) * DFSCREENW)
/**
 按iPhone6 375.0f成比例
 
 @param value 设计大小
 @return 实际大小
 */
#define RV(value) RV_WIDTH((value),(375.f))

#define SafeAreaTopHeight (DFSCREENH== 812.0 ? 88 : 64)
#define DFNAVIGATIONBARHEIGHT (DFSCREENH== 812.0 ? 88 : 64)
#define DFTABBARHEIGHT (DFSCREENH== 812.0 ? 83 : 49)
#define DFTABBARBOTTOMHEIGHT (DFSCREENH == 812.0 ? 44 : 0)





#endif /* CommonConfig_h */
