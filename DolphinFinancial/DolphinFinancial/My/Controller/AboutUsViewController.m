//
//  AboutUsViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AboutUsViewController.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

@interface AboutUsViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *versionLabel;

@end

@implementation AboutUsViewController

+ (void)pushToController:(UIViewController *)controller
{
    AboutUsViewController *vc = [[AboutUsViewController alloc] init];
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"关于我们"];
    [self addLeftBackButton];
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom).mas_offset(25);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        
        make.width.height.mas_equalTo(50);
    }];
    [self.view addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imageView);
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(17);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
    }];
     
     [self.view addSubview:self.versionLabel];
     [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.mas_equalTo(self.view.mas_bottom).mas_equalTo(-17);
         make.centerX.mas_equalTo(self.view.mas_centerX);
     }];
}

#pragma mark - getter
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppIcon"]];
    }
    return _imageView;
}
- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.textColor = DFColorWithHexString(@"#101010");
        _descLabel.font = [UIFont systemFontOfSize:14.0];
        _descLabel.numberOfLines = 2;
        [_descLabel setText:@"海豚理财全新上线啦~\n我们将竭尽全力保障您的资产收益!" lineSpace:5];
        
    }
    return _descLabel;
}
- (UILabel *)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [UILabel new];
        _versionLabel.textColor = DFColorWithHexString(@"#969696");
        _versionLabel.font = [UIFont systemFontOfSize:14.0];
        NSString *app_Version = [ [[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        _versionLabel.text = [NSString stringWithFormat:@"版本信息：V%@",app_Version];
    }
    return _versionLabel;
}



@end
