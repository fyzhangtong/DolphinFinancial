//
//  BaseViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/16.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface BaseViewController ()

@property (nonatomic, strong) UIView *navigationView;       //自定义导航view

@property (nonatomic, strong) UIButton *centerButton;       //中间按钮
@property (nonatomic, strong) UIButton *rightBarButton;     //Button 右侧
@property (nonatomic, strong) UIImageView *rightGifView;
@property (nonatomic, strong) UIView *networkErrorOrNoDataView;
@property (nonatomic, strong) UIButton *leftInformationButton;
@property (nonatomic, copy) void(^networkErrorOrNoDataViewButtonActionBlock)(void);

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - 右滑返回手势
- (BOOL)gestureRecognizerShouldBegin
{
    return YES;
}

- (BOOL)nextControllergestureRecognizerShouldBegin
{
    return YES;
}
#pragma mark - 设置状态栏颜色
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {

    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark - getter
- (UIView *)navigationView
{
    if (!_navigationView) {
        _navigationView = [[UIView alloc] init];
        _navigationView.backgroundColor = DFTINTCOLOR;
        [self.view addSubview:_navigationView];
        [_navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.mas_equalTo(self.view);
            make.height.mas_equalTo(DFNAVIGATIONBARHEIGHT);
        }];
    }
    return _navigationView;
}
- (UIView *)ownNavigationBar
{
    if (!_ownNavigationBar) {
        _ownNavigationBar = [[UIView alloc] init];
        _ownNavigationBar.backgroundColor = [UIColor clearColor];
        [self.navigationView addSubview:_ownNavigationBar];
        [self.navigationView addSubview:self.ownNavigationBarLine];
        [_ownNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(self.navigationView);
            make.height.mas_equalTo(44);
        }];
        [self.ownNavigationBarLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(self.navigationView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _ownNavigationBar;
}
- (UIView *)ownNavigationBarLine
{
    if (!_ownNavigationBarLine) {
        _ownNavigationBarLine = [[UIView alloc] init];
        _ownNavigationBarLine.backgroundColor = DFColorWithAlpha(0xcc, 0xcc, 0xcc, 1);
    }
    return _ownNavigationBarLine;
}

- (UIButton *)centerButton
{
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([self.navigationView.backgroundColor isEqual:[UIColor whiteColor]]) {
            [_centerButton setTitleColor:DFColorWithHexString(@"#333333") forState:UIControlStateNormal];
        }else{
            [_centerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }

        _centerButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [_centerButton addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.ownNavigationBar addSubview:_centerButton];
        [_centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_ownNavigationBar.mas_centerX);
            make.centerY.mas_equalTo(_ownNavigationBar.mas_centerY);
            make.width.mas_lessThanOrEqualTo(_ownNavigationBar.mas_width).multipliedBy(0.66);
        }];
    }
    return _centerButton;
}
- (UIButton *)leftBarButton
{
    if (!_leftBarButton) {
        _leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBarButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_leftBarButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBarButton setTitleColor:DFColorWithAlpha(0x00, 0x00, 0x00, 0.6) forState:UIControlStateHighlighted];
        [self.ownNavigationBar addSubview:_leftBarButton];
        [_leftBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.ownNavigationBar);
            make.left.mas_equalTo(self.ownNavigationBar.mas_left).offset(15);
        }];
    }
    return _leftBarButton;
}

- (UIButton *)rightBarButton
{
    if (!_rightBarButton) {
        _rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBarButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_rightBarButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.navigationView.backgroundColor isEqual:[UIColor whiteColor]]) {
            [_rightBarButton setTitleColor:DFColorWithHexString(@"#333333") forState:UIControlStateNormal];
        }else{
            [_rightBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [self.ownNavigationBar addSubview:_rightBarButton];
        [_rightBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.ownNavigationBar);
            make.right.mas_equalTo(self.ownNavigationBar.mas_right).mas_offset(-15);
            //            make.width.and.height.mas_equalTo(21);
        }];
    }
    return _rightBarButton;
}

#pragma mark -  view
/**
 * @param color - 导航栏颜色
 * @param alpha - 导航栏内容透明度
 */
- (void)setNavigationColor:(UIColor *)color alpha:(CGFloat)alpha
{
    if (alpha < 0)
        alpha = 0;
    else if (alpha > 1.0)
        alpha = 1.0;

    //Navigation
    if (self.navigationView) {
        self.navigationView.backgroundColor = color;
        self.navigationView.alpha = alpha;
    }
    //Line

    if ([self.navigationView.backgroundColor isEqual:[UIColor whiteColor]]) {
        if (self.ownNavigationBarLine) {
            self.ownNavigationBarLine.alpha = alpha;
        }
    }else{
        if (self.ownNavigationBarLine) {
            self.ownNavigationBarLine.alpha = 0.0;
        }
    }
}
- (void)setCenterImage:(UIImage *)image;
{
    [self setCenterImage:image title:nil titleColor:nil];
}
- (void)setCenterTitle:(NSString *)title{
    [self setCenterImage:nil title:title titleColor:nil];
}
- (void)setCenterTitle:(NSString *)title titleColor:(UIColor *)color
{
    [self setCenterImage:nil title:title titleColor:color];
}
- (void)setCenterImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)color
{
    if (image) {
        [self.centerButton setImage:image forState:UIControlStateNormal];
        [self.centerButton setImage:image forState:UIControlStateHighlighted];
    }
    if (title) {
        [self.centerButton setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [self.centerButton setTitleColor:color forState:UIControlStateNormal];
    }
}

/*
 *创建黑色返回按钮
 */
- (void)addLeftBackButton
{
    if ([self.navigationView.backgroundColor isEqual:[UIColor whiteColor]]) {
        [self setLeftButtonImage:[UIImage imageNamed:@"back_black"]];
    }else{
        [self setLeftButtonImage:[UIImage imageNamed:@"back_wite"]];
    }

}

- (void)setLeftButtonImage:(UIImage *)image
{
    [self setLeftButtonImage:image hightlightImage:nil title:nil titleColor:nil];
}
- (void)setLeftButtonImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage
{
    [self setLeftButtonImage:image hightlightImage:hightlightImage title:nil titleColor:nil];
}
- (void)setLeftButtonTitle:(NSString *)title
{
    [self setLeftButtonImage:nil hightlightImage:nil title:title titleColor:nil];
}
- (void)setLeftButtonTitle:(NSString *)title titleColor:(UIColor *)color
{
    [self setLeftButtonImage:nil hightlightImage:nil title:title titleColor:color];
}

- (void)setLeftButtonNormalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage
{
    if (normalImage) {
        [self.leftBarButton setImage:normalImage forState:UIControlStateNormal];
    }
    if (selectImage) {
        [self.leftBarButton setImage:selectImage forState:UIControlStateSelected];
    }
}
- (void)setLeftButtonImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage title:(NSString *)title titleColor: (UIColor *)color
{
    if (image) {
        [self.leftBarButton setImage:image forState:UIControlStateNormal];
        if (hightlightImage) {
            [self.leftBarButton setImage:hightlightImage forState:UIControlStateHighlighted];
        }

    }
    if (title) {
        [self.leftBarButton setTitle:title forState:UIControlStateNormal];
        if (color) {
            [self.leftBarButton setTitleColor:color forState:UIControlStateNormal];
        }
    }
}

- (void)rightButtonHide:(BOOL)hide
{
    self.rightBarButton.hidden = hide;
}

- (void)setRightButtonImage:(UIImage *)image
{
    [self setRightButtonImage:image hightlightImage:nil title:nil titleColor:nil];
}
- (void)setRightButtonImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage
{
    [self setRightButtonImage:image hightlightImage:hightlightImage title:nil titleColor:nil];
}
- (void)setRightButtonTitle:(NSString *)title
{
    [self setRightButtonImage:nil hightlightImage:nil title:title titleColor:nil];
}
- (void)setRightButtonTitle:(NSString *)title titleColor:(UIColor *)color
{
    [self setRightButtonImage:nil hightlightImage:nil title:title titleColor:color];
}
- (void)setRightButtonImage:(UIImage *)image hightlightImage:(UIImage *)hightlightImage title:(NSString *)title titleColor:(UIColor *)color
{
    if (image) {
        [self.rightBarButton setImage:image forState:UIControlStateNormal];
        if (hightlightImage) {
            [self.rightBarButton setImage:hightlightImage forState:UIControlStateHighlighted];
        }
    }
    if (title) {
        [self.rightBarButton setTitle:title forState:UIControlStateNormal];
        if (color) {
            [self.rightBarButton setTitleColor:color forState:UIControlStateNormal];
        }
    }
}
- (void)setRightGif
{
    [self.rightGifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.ownNavigationBar);
        if (_rightBarButton) {
            make.right.mas_equalTo(_rightBarButton.mas_left).mas_offset(-15);
        }else{
            make.right.mas_equalTo(self.ownNavigationBar.mas_right).mas_offset(-15);
        }
        make.width.and.height.mas_equalTo(21);
    }];
}
#pragma mark - Action
- (void)centerButtonClick:(UIButton *)sender
{
    NSLog(@"中间按钮");
}
/**
 *左侧按钮点击事件
 */
- (void)leftButtonClick:(UIButton *)sender
{
    NSLog(@"左侧按钮");
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/**
 *右侧按钮点击事件
 */
- (void)rightButtonClick:(UIButton *)sender
{
    NSLog(@"右侧按钮");

}
- (void)playOrPause:(NSNotification *)noti
{

}

#pragma mark - 网路出错 & 没有数据
- (void)showNetWorkErrorOrNoDataViewWithBackImage:(NSString *)backImage ActionImage:(NSString *)actionImage actionBlock:(void(^)(void))actionBlock
{
    if (self.networkErrorOrNoDataView) {
        [self.networkErrorOrNoDataView removeFromSuperview];
        self.networkErrorOrNoDataView = nil;
    }
    self.networkErrorOrNoDataView = [[UIView alloc] init];
    self.networkErrorOrNoDataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.networkErrorOrNoDataView];
    [self.networkErrorOrNoDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(DFNAVIGATIONBARHEIGHT);
        make.left.and.right.and.bottom.mas_equalTo(self.view);
    }];
    UIImageView *backImageView = [UIImageView new];
    if (!backImage) {
        backImage = @"networ_fault_img";
    }
    backImageView.image = [UIImage imageNamed:backImage];
    //    backImageView.contentMode = UIViewContentModeScaleToFill;
    [self.networkErrorOrNoDataView addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.networkErrorOrNoDataView.mas_centerX);
        make.centerY.mas_equalTo(self.networkErrorOrNoDataView.mas_centerY).mas_offset(-100);
    }];
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (!actionImage) {
        actionImage = @"refresh_button";
    }
    [actionButton setImage:[UIImage imageNamed:actionImage] forState:UIControlStateNormal];
    [actionButton addTarget:self action:@selector(networkErrorOrNoDataViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.networkErrorOrNoDataView addSubview:actionButton];
    [actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backImageView.mas_centerX);
        make.top.mas_equalTo(backImageView.mas_bottom).mas_offset(20);
    }];
    self.networkErrorOrNoDataViewButtonActionBlock = actionBlock;
}
- (void)networkErrorOrNoDataViewButtonAction:(UIButton *)sender
{
    [self dismissNetworkErrorOrNoDataView];
    if (self.networkErrorOrNoDataViewButtonActionBlock) {
        self.networkErrorOrNoDataViewButtonActionBlock();
    }
}
- (void)dismissNetworkErrorOrNoDataView
{
    if (self.networkErrorOrNoDataView) {
        [self.networkErrorOrNoDataView removeFromSuperview];
        self.networkErrorOrNoDataView = nil;
    }
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)dealloc
{
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
