//
//  BaseViewController.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/16.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD+DFStyle.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIButton *leftBarButton;      //Button 左侧
@property (nonatomic, strong) UIView *ownNavigationBar;     //自定义导航栏（不包括状态栏）
@property (nonatomic, strong) UIView *ownNavigationBarLine; //自定义导航线

#pragma mark - 右滑返回手势
//当前控制器是否支持右滑返回
- (BOOL)gestureRecognizerShouldBegin;
//推出的控制器是否支持右滑返回手势
- (BOOL)nextControllergestureRecognizerShouldBegin;

#pragma mark - View
/**
 * 设置导航栏颜色及导航栏内容透明度
 * @param color - 导航栏颜色
 * @param alpha - 导航栏内容透明度
 */
- (void)setNavigationColor:(UIColor *)color alpha:(CGFloat)alpha;

#pragma mark - 中间view
/**
 导航栏图片
 
 @param image 图片
 */
- (void)setCenterImage:(UIImage *)image;
/**
 导航栏标题
 
 @param title 标题 默认字体为白色
 */
- (void)setCenterTitle:(NSString *)title;
/**
 导航栏标题及标题颜色
 @param title 标题
 @param color 标题颜色
 */
- (void)setCenterTitle:(NSString *)title titleColor:(UIColor *)color;
/**
 导航栏标题图片，标题颜色
 
 @param image 图片
 @param title 标题
 @param color 标题颜色
 */
- (void)setCenterImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)color;

#pragma mark- 左侧View
/*
 *创建黑色返回按钮
 */
- (void)addLeftBackButton;

/**
 左侧图片
 
 @param image 图片
 */
- (void)setLeftButtonImage:(UIImage *)image;
/**
 左侧按钮图片和高亮图片
 
 @param image 图片
 @param hightlightImage 高亮图片
 */
- (void)setLeftButtonImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage;
/**
 左侧按钮标题 默认字体颜色为白色
 
 @param title 标题
 */
- (void)setLeftButtonTitle:(NSString *)title;
/**
 左侧按钮标题和标题颜色
 
 @param title 标题
 @param color 标题颜色
 */
- (void)setLeftButtonTitle:(NSString *)title titleColor:(UIColor *)color;

/**
 左侧按钮图片高亮图片标题颜色和标题
 
 @param image 图片
 @param hightlightImage 高亮图片
 @param title 标题
 @param color 标题颜色
 */
- (void)setLeftButtonImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage title:(NSString *)title titleColor: (UIColor *)color;
#pragma mark 右侧View

/**
 是否隐藏右侧按钮
 
 @param hide hide
 */
- (void)rightButtonHide:(BOOL)hide;
/**
 右侧按钮图片
 
 @param image 图片
 */
- (void)setRightButtonImage:(UIImage *)image;
/**
 右侧按钮图片和高亮图片
 
 @param image 右侧图片
 @param hightlightImage 高亮图片
 */
- (void)setRightButtonImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage;
/**
 右侧按钮 默认字体颜色为白色
 
 @param title 标题
 */
- (void)setRightButtonTitle:(NSString *)title;
/**
 右侧按钮
 
 @param title 标题
 @param color 标题颜色
 */
- (void)setRightButtonTitle:(NSString *)title titleColor:(UIColor *)color;
/**
 右侧按钮
 
 @param image 图片
 @param hightlightImage 高亮图片
 @param title 标题
 @param color 标题颜色
 */
- (void)setRightButtonImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage title:(NSString *)title titleColor:(UIColor *)color;


#pragma mark - Action
- (void)centerButtonClick:(UIButton *)sender;
/*
 *左侧按钮点击事件
 */
- (void)leftButtonClick:(UIButton *)sender;
/**
 *右侧按钮点击事件
 */
- (void)rightButtonClick:(UIButton *)sender;

#pragma mark - 网路出错 & 没有数据
- (void)showNetWorkErrorOrNoDataViewWithBackImage:(NSString *)backImage ActionImage:(NSString *)actionImage actionBlock:(void(^)(void))actionBlock;

- (void)dismissNetworkErrorOrNoDataView;

@end
