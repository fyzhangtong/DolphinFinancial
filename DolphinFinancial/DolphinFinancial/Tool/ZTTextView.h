//
//  ZTTextView.h
//  FanBookClub
//
//  Created by FDXDZ on 2018/3/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTTextView : UITextView

/** 占位文字 */
@property (nonatomic,copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic,strong) UIColor *placeholderColor;

@end
