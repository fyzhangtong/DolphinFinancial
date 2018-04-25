//
//  HomeViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/16.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "HomeViewController.h"

#import "FinacialDetailsController.h"
#import "DFNotice.h"
#import "DFProduct.h"
#import "UserManager.h"

@interface HomeViewController ()

/**
 理财金额和借款人数量背景
 */
@property (nonatomic, strong) UIView *amountBorrowersBackView;
/**
 理财金额
 */
@property (nonatomic, strong) UILabel *amountLabel;
/**
 理财金额描述
 */
@property (nonatomic, strong) UILabel *amountDescLabel;
/**
 分割线
 */
@property (nonatomic, strong) UIView *amountBorrowerLine;
/**
 借款人数量
 */
@property (nonatomic, strong) UILabel *borrowersLabel;
/**
 借款人数量描述
 */
@property (nonatomic, strong) UILabel *borrowersDescLabel;

/**
 公告背景
 */
@property (nonatomic, strong) UIView *noticeBackView;
/**
 喇叭
 */
@property (nonatomic, strong) UIImageView *hornImageView;
/**
 公告标题
 */
@property (nonatomic, strong) UILabel *noticeTitleLabel;
/**
 查看
 */
@property (nonatomic, strong) UILabel *noticeCheckLabel;
/**
 右箭头
 */
@property (nonatomic, strong) UIImageView *noticeRightImageView;

/**
 @"今日推荐产品"
 */
@property (nonatomic, strong) UILabel *recommendingTitleLabel;
/**
 背景
 */
@property (nonatomic, strong) UIView *recommendingBackView;
/**
 @"1月定存"
 */
@property (nonatomic, strong) UILabel *recommendingLabel1;
/**
 @"到期自动转出"
 */
@property (nonatomic, strong) UILabel *recommendingLabel2;
/**
 @"5.8%"
 */
@property (nonatomic, strong) UILabel *recommendingLabel3;
/**
 @"今日还剩100份"
 */
@property (nonatomic, strong) UILabel *recommendingLabel4;

/**
 公告背景高度限定
 */
@property (nonatomic, strong) MASConstraint *noticeBackViewConstraintH;
/**
 今日推荐高度限定
 */
@property (nonatomic, strong) MASConstraint *recommendingTitleLabelConstraintH;
/**
 推荐背景
 */
@property (nonatomic, strong) MASConstraint *recommendingBackViewConstraintH;
@end

@implementation HomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setCenterImage:[UIImage imageNamed:@"dolphin"] title:@"海豚理财" titleColor:[UIColor whiteColor]];
    [self makeView];
    [self loadData];
}

- (void)makeView
{
    [self.view addSubview:self.amountBorrowersBackView];
    [_amountBorrowersBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(91.f);
    }];
    [self.amountBorrowersBackView addSubview:self.amountLabel];
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountBorrowersBackView.mas_top).mas_offset(6);
        make.centerX.mas_equalTo(self.amountBorrowersBackView.mas_centerX).multipliedBy(0.5);
    }];
    [self.amountBorrowersBackView addSubview:self.amountDescLabel];
    [_amountDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountLabel.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.amountLabel.mas_centerX);
    }];
    [self.amountBorrowersBackView addSubview:self.borrowersLabel];
    [_borrowersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountLabel.mas_top);
        make.centerX.mas_equalTo(self.amountBorrowersBackView.mas_centerX).multipliedBy(1.5);
    }];
    [self.amountBorrowersBackView addSubview:self.borrowersDescLabel];
    [_borrowersDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.borrowersLabel.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.borrowersLabel.mas_centerX);
    }];
    [self.amountBorrowersBackView addSubview:self.amountBorrowerLine];
    [self.amountBorrowerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountBorrowersBackView.mas_top).mas_offset(3);
        make.centerX.mas_equalTo(self.amountBorrowersBackView.mas_centerX);
        make.bottom.mas_equalTo(self.amountBorrowersBackView.mas_bottom).mas_offset(-6);
        make.width.mas_equalTo(1);
    }];
    [self.view addSubview:self.noticeBackView];
    [self.noticeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountBorrowersBackView.mas_bottom);
        make.left.right.mas_equalTo(self.amountBorrowersBackView);
        self.noticeBackViewConstraintH = make.height.mas_equalTo(0);
    }];
    [self.noticeBackView addSubview:self.hornImageView];
    [self.hornImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noticeBackView.mas_centerY);
        make.left.mas_equalTo(self.noticeBackView.mas_left).mas_offset(10);
        make.width.height.mas_equalTo(24);
    }];
    [self.noticeBackView addSubview:self.noticeRightImageView];
    [self.noticeRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noticeBackView.mas_centerY);
        make.right.mas_equalTo(self.noticeBackView.mas_right).mas_offset(-8);
        make.width.height.mas_equalTo(22);
    }];
    [self.noticeBackView addSubview:self.noticeCheckLabel];
    [self.noticeCheckLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.noticeRightImageView.mas_centerY);
        make.right.mas_equalTo(self.noticeRightImageView.mas_left).mas_equalTo(-3);
        make.width.mas_equalTo(25);
    }];
    [self.noticeBackView addSubview:self.noticeTitleLabel];
    [self.noticeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.hornImageView.mas_centerY);
        make.left.mas_equalTo(self.hornImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.noticeCheckLabel.mas_left).mas_offset(-10);
    }];

    [self.view addSubview:self.recommendingTitleLabel];
    [self.recommendingTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noticeBackView.mas_bottom).mas_offset(8);
        make.left.right.mas_equalTo(self.view).mas_offset(0);
        self.recommendingTitleLabelConstraintH = make.height.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.recommendingBackView];
    [self.recommendingBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.recommendingTitleLabel.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.view);
        self.recommendingBackViewConstraintH = make.height.mas_equalTo(0);
    }];
    [self.recommendingBackView addSubview:self.recommendingLabel1];
    [self.recommendingLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.recommendingBackView.mas_top).mas_equalTo(7);
        make.left.mas_equalTo(self.recommendingBackView.mas_left).mas_equalTo(16);
    }];
    [self.recommendingBackView addSubview:self.recommendingLabel2];
    [self.recommendingLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.recommendingLabel1.mas_bottom).mas_equalTo(7);
        make.left.mas_equalTo(self.recommendingLabel1.mas_left);
    }];
    [self.recommendingBackView addSubview:self.recommendingLabel3];
    [self.recommendingLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.recommendingLabel1.mas_centerY);
        make.right.mas_equalTo(self.recommendingBackView.mas_right).mas_offset(-18);
    }];
    [self.recommendingBackView addSubview:self.recommendingLabel4];
    [self.recommendingLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.recommendingLabel2.mas_centerY);
        make.right.mas_equalTo(self.recommendingLabel3.mas_right);
    }];
}


#pragma mark - 懒加载
- (UIView *)amountBorrowersBackView
{
    if (!_amountBorrowersBackView) {
        _amountBorrowersBackView = [UIView new];
        _amountBorrowersBackView.backgroundColor = DFTINTCOLOR;
        
    }
    return _amountBorrowersBackView;
}

- (UIView *)amountLabel
{
    if (!_amountLabel) {
        _amountLabel = [UILabel new];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.font = [UIFont boldSystemFontOfSize:20];
        _amountLabel.textColor = [UIColor whiteColor];
        _amountLabel.text = @"(万元)";
        
    }
    return _amountLabel;
}

- (UILabel *)amountDescLabel
{
    if (!_amountDescLabel) {
        _amountDescLabel = [UILabel new];
        _amountDescLabel.textAlignment = NSTextAlignmentCenter;
        _amountDescLabel.font = [UIFont systemFontOfSize:12];
        _amountDescLabel.textColor = [UIColor whiteColor];
        _amountDescLabel.text = @"人均累计理财金额";
        
    }
    return _amountDescLabel;
}

- (UILabel *)borrowersLabel
{
    if (!_borrowersLabel) {
        _borrowersLabel = [UILabel new];
        _borrowersLabel.textAlignment = NSTextAlignmentCenter;
        _borrowersLabel.font = [UIFont boldSystemFontOfSize:18];
        _borrowersLabel.textColor = [UIColor whiteColor];
        _borrowersLabel.text = @"(万人)";
        
    }
    return _borrowersLabel;
}

- (UILabel *)borrowersDescLabel
{
    if (!_borrowersDescLabel) {
        _borrowersDescLabel = [UILabel new];
        _borrowersDescLabel.textAlignment = NSTextAlignmentCenter;
        _borrowersDescLabel.font = [UIFont systemFontOfSize:12];
        _borrowersDescLabel.textColor = [UIColor whiteColor];
        _borrowersDescLabel.text = @"人均累计理财金额";
        
    }
    return _borrowersDescLabel;
}

- (UIView *)amountBorrowerLine
{
    if (!_amountBorrowerLine) {
        _amountBorrowerLine = [UIView new];
        _amountBorrowerLine.backgroundColor = DFColor(177, 177, 177);
    }
    return _amountBorrowerLine;
}

- (UIView *)noticeBackView
{
    if (!_noticeBackView) {
        _noticeBackView = [UIView new];
        _noticeBackView.layer.masksToBounds = YES;
        [_noticeBackView setBackgroundColor:[UIColor whiteColor]];
    }
    return _noticeBackView;
}
- (UIImageView *)hornImageView
{
    if (!_hornImageView) {
        _hornImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horn"]];
    }
    return _hornImageView;
}
- (UIImageView *)noticeRightImageView
{
    if (!_noticeRightImageView) {
        _noticeRightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
    }
    return _noticeRightImageView;
}
- (UILabel *)noticeTitleLabel
{
    if (!_noticeTitleLabel) {
        _noticeTitleLabel = [UILabel new];
        _noticeTitleLabel.textAlignment = NSTextAlignmentLeft;
        _noticeTitleLabel.font = [UIFont systemFontOfSize:14];
        _noticeTitleLabel.textColor = DFColorWithHexString(@"#101010");
        _noticeTitleLabel.text = @"海豚理财V1.0.0正式发布公告";
    }
    return _noticeTitleLabel;
}
- (UILabel *)noticeCheckLabel
{
    if (!_noticeCheckLabel) {
        _noticeCheckLabel = [UILabel new];
        _noticeCheckLabel.textAlignment = NSTextAlignmentLeft;
        _noticeCheckLabel.font = [UIFont systemFontOfSize:12];
        _noticeCheckLabel.textColor = DFColorWithHexString(@"#b3b3b3");
        _noticeCheckLabel.text = @"查看";
    }
    return _noticeCheckLabel;
}

- (UILabel *)recommendingTitleLabel
{
    if (!_recommendingTitleLabel) {
        _recommendingTitleLabel = [UILabel new];
        _recommendingTitleLabel.textAlignment = NSTextAlignmentLeft;
        _recommendingTitleLabel.font = [UIFont systemFontOfSize:14];
        _recommendingTitleLabel.textColor = DFColorWithHexString(@"#101010");
        _recommendingTitleLabel.text = @"   今日推荐产品";
        _recommendingTitleLabel.layer.masksToBounds = YES;
        [_recommendingTitleLabel setBackgroundColor:[UIColor whiteColor]];
    }
    return _recommendingTitleLabel;
}
- (UIView *)recommendingBackView
{
    if (!_recommendingBackView) {
        _recommendingBackView  = [UIView new];
        _recommendingBackView.backgroundColor = [UIColor whiteColor];
        _recommendingBackView.userInteractionEnabled = YES;
        _recommendingBackView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recommendingBackViewTapAction:)];
        [_recommendingBackView addGestureRecognizer:tap];
    }
    return _recommendingBackView;
}

- (UILabel *)recommendingLabel1
{
    if (!_recommendingLabel1) {
        _recommendingLabel1 = [UILabel new];
        _recommendingLabel1.textAlignment = NSTextAlignmentLeft;
        _recommendingLabel1.font = [UIFont systemFontOfSize:14];
        _recommendingLabel1.textColor = DFColorWithHexString(@"#101010");
        _recommendingLabel1.text = @"1月定存";
    }
    return _recommendingLabel1;
}
- (UILabel *)recommendingLabel2
{
    if (!_recommendingLabel2) {
        _recommendingLabel2 = [UILabel new];
        _recommendingLabel2.textAlignment = NSTextAlignmentLeft;
        _recommendingLabel2.font = [UIFont systemFontOfSize:16];
        _recommendingLabel2.textColor = DFColorWithHexString(@"#1779D4");
        _recommendingLabel2.text = @"5.8%";
    }
    return _recommendingLabel2;
}

- (UILabel *)recommendingLabel3
{
    if (!_recommendingLabel3) {
        _recommendingLabel3 = [UILabel new];
        _recommendingLabel3.textAlignment = NSTextAlignmentLeft;
        _recommendingLabel3.font = [UIFont systemFontOfSize:12];
        _recommendingLabel3.textColor = DFColorWithHexString(@"#969696");
        _recommendingLabel3.text = @"到期自动转出";
    }
    return _recommendingLabel3;
}
- (UILabel *)recommendingLabel4
{
    if (!_recommendingLabel4) {
        _recommendingLabel4 = [UILabel new];
        _recommendingLabel4.textAlignment = NSTextAlignmentLeft;
        _recommendingLabel4.font = [UIFont systemFontOfSize:12];
        _recommendingLabel4.textColor = DFColorWithHexString(@"#969696");
        _recommendingLabel4.text = @"今日还剩100份";
    }
    return _recommendingLabel4;
}
#pragma mark - 网络请求
- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [GTNetWorking getWithUrl:DOLPHIN_API_INDEX params:nil success:^(NSNumber *code, NSString *msg, id data) {
        if ([code integerValue] == 200) {
            NSDictionary *platform_info = data[@"platform_info"];
            DFNotice *notice = [DFNotice yy_modelWithDictionary:data[@"notice"]];
            DFProduct *product = [DFProduct yy_modelWithDictionary:data[@"product"]];
            weakSelf.amountLabel.text = platform_info[@"per_financial_amount"];
            weakSelf.borrowersLabel.text = platform_info[@"total_borrower"];
            if (notice.content.length) {
                weakSelf.noticeTitleLabel.text = notice.content;
                weakSelf.noticeBackViewConstraintH.mas_offset(40);
            }else{
                weakSelf.noticeBackViewConstraintH.mas_offset(0);
            }
            if (product.name.length) {
                weakSelf.recommendingLabel1.text = product.name;
                weakSelf.recommendingLabel2.text = product.descriptions.firstObject;
                weakSelf.recommendingLabel3.text = product.interest_rate;
                weakSelf.recommendingLabel4.text = [NSString stringWithFormat:@"今日还剩%@份",product.residue_number];
                weakSelf.recommendingBackViewConstraintH.mas_offset(60);
                weakSelf.recommendingTitleLabelConstraintH.mas_offset(35);
            }else{
                weakSelf.recommendingBackViewConstraintH.mas_offset(0);
                weakSelf.recommendingTitleLabelConstraintH.mas_offset(0);
            }
            
        }else{
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showTextAddToView:weakSelf.view Title:error.localizedDescription andHideTime:2];
    }];
}

#pragma mark - action
- (void)recommendingBackViewTapAction:(UITapGestureRecognizer *)sender
{
    FinacialDetailsController *fdc = [[FinacialDetailsController alloc] init];
    [self.navigationController pushViewController:fdc animated:YES];
}

@end
