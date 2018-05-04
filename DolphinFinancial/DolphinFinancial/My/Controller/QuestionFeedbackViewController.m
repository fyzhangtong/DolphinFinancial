//
//  QuestionFeedbackViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "QuestionFeedbackViewController.h"
#import "ZTTextView.h"
#import "UIImage+ImageWithColor.h"

@interface QuestionFeedbackViewController ()<UITextViewDelegate>

@property (nonatomic, strong) ZTTextView *textView;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation QuestionFeedbackViewController

+ (void)pushToController:(UIViewController *)controller
{
    QuestionFeedbackViewController *vc = [[QuestionFeedbackViewController alloc] init];
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"问题反馈"];
    [self addLeftBackButton];
    self.view.backgroundColor = DFColorWithHexString(@"#F8F8F8");
    
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(165);
    }];
    
    [self.view addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.height.mas_equalTo(40);
    }];
    
}
#pragma mark - getter
- (ZTTextView *)textView
{
    if (!_textView) {
        _textView = [[ZTTextView alloc] init];;
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDone;
        
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.placeholderColor = DFColorWithHexString(@"#888888");
        _textView.placeholder = @"请写下您的宝贵意见或建议";
    }
    return _textView;
}
- (UIButton *)submitButton
{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_submitButton setBackgroundImage:[UIImage createImageWithColor:DFTINTCOLOR] forState:UIControlStateNormal];
        [_submitButton setTitleColor:DFColorWithHexString(@"#FFFFFF") forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 4;
        _submitButton.layer.masksToBounds = YES;
        [_submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _submitButton;
}
- (void)submitButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (self.textView.text.length == 0) {
        [MBProgressHUD showTextAddToView:self.view Title:@"请先输入内容" andHideTime:2];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
    SafeDictionarySetObject(params, self.textView.text, @"content");
    [GTNetWorking postWithUrl:DOLPHIN_API_FEEDBACK params:params header:nil showLoginIfNeed:NO success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:2];
        if ([code integerValue] == 200) {
            self.textView.text = nil;
        }
        [MBProgressHUD showTextAddToView:self.view Title:msg andHideTime:2];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:2];
        [MBProgressHUD showTextAddToView:self.view Title:error.localizedDescription andHideTime:2];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
