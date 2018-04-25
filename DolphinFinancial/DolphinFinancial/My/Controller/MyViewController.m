//
//  MyViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/16.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyViewController.h"
#import "MyInfoTableViewCell.h"
#import "MyTitleAndExplainCell.h"
#import "MyLogoutTableViewCell.h"
#import "LoginViewController.h"
#import "MemberDetailsViewController.h"
#import "ChangePasswordViewController.h"
#import "MessageCenterViewController.h"
#import "QuestionFeedbackViewController.h"
#import "AboutUsViewController.h"

#define MyInfoCell @"MyInfoCell"
#define MyInfoDetailsCell @"MyInfoDetailsCell"
#define MyLoginPasswordCell @"MyLoginPasswordCell"
#define MyPayPasswordCell @"MyPayPasswordCell"
#define MyMessageCenterCell @"MyMessageCenterCell"
#define MyQuestionFeedbackCell @"MyQuestionFeedbackCell"
#define MyAboutUsCell @"MyAboutUsCell"
#define MyLogoutCell @"MyLogoutCell"

@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource>

{
    NSArray *_loginDataSource;
    NSArray *_logoutDataSource;
}
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyViewController

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
    _loginDataSource = @[@[MyInfoCell],@[MyInfoDetailsCell],@[MyLoginPasswordCell,MyPayPasswordCell],@[MyMessageCenterCell,MyQuestionFeedbackCell],@[MyAboutUsCell],@[MyLogoutCell]];
    _logoutDataSource = @[@[MyInfoCell],@[MyInfoDetailsCell],@[MyLoginPasswordCell,MyPayPasswordCell],@[MyMessageCenterCell,MyQuestionFeedbackCell],@[MyAboutUsCell]];
    [self makeView];
    self.dataSource = _loginDataSource;
}
- (void)makeView
{
    [self setCenterTitle:@"我的"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-49);
    }];
}
#pragma mark - setter 方法
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    [self.tableView reloadData];
}

#pragma mark - getter 方法
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [MyInfoTableViewCell registerCellTableView:_tableView];
        [MyTitleAndExplainCell registerCellTableView:_tableView];
        [MyLogoutTableViewCell registerCellTableView:_tableView];
        [_tableView setBackgroundColor:DFColorWithHexString(@"#F8F8F8")];
        [_tableView setSeparatorColor:DFColorWithHexString(@"#F8F8F8")];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _tableView;
}

#pragma mark - tableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *string = self.dataSource[indexPath.section][indexPath.row];
    if ([string isEqualToString:MyInfoCell]) {
        cell =[tableView dequeueReusableCellWithIdentifier:[MyInfoTableViewCell reuseIdentifier]];
        [(MyInfoTableViewCell *)cell reloadPhone:self.phone member_level:self.member_level];
    }else if ([string isEqualToString:MyInfoDetailsCell]){
        cell =[tableView dequeueReusableCellWithIdentifier:[MyTitleAndExplainCell reuseIdentifier]];
        [((MyTitleAndExplainCell *)cell) reloadWithIcon:@"my_details" Title:@"会员详情" Explain:@"等级越高收益越高"];
    }else if ([string isEqualToString:MyLoginPasswordCell]){
        cell =[tableView dequeueReusableCellWithIdentifier:[MyTitleAndExplainCell reuseIdentifier]];
        [((MyTitleAndExplainCell *)cell) reloadWithIcon:@"my_login_password" Title:@"登录密码" Explain:@"修改"];
    }else if ([string isEqualToString:MyPayPasswordCell]){
        cell =[tableView dequeueReusableCellWithIdentifier:[MyTitleAndExplainCell reuseIdentifier]];
        [((MyTitleAndExplainCell *)cell) reloadWithIcon:@"my_pay_password" Title:@"交易密码" Explain:@"修改"];
    }else if ([string isEqualToString:MyMessageCenterCell]){
        cell =[tableView dequeueReusableCellWithIdentifier:[MyTitleAndExplainCell reuseIdentifier]];
        [((MyTitleAndExplainCell *)cell) reloadWithIcon:@"my_message" Title:@"消息中心" Explain:@"最新公告内容"];
    }else if ([string isEqualToString:MyQuestionFeedbackCell]){
        cell =[tableView dequeueReusableCellWithIdentifier:[MyTitleAndExplainCell reuseIdentifier]];
        [((MyTitleAndExplainCell *)cell) reloadWithIcon:@"my_question_feedback" Title:@"问题反馈" Explain:@"解决您的问题"];
    }else if ([string isEqualToString:MyAboutUsCell]){
        cell =[tableView dequeueReusableCellWithIdentifier:[MyTitleAndExplainCell reuseIdentifier]];
        [((MyTitleAndExplainCell *)cell) reloadWithIcon:@"my_about_us" Title:@"关于我们" Explain:@"版本信息"];
    }else if ([string isEqualToString:MyLogoutCell]){
        cell =[tableView dequeueReusableCellWithIdentifier:[MyLogoutTableViewCell reuseIdentifier]];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataSource[section];
    return array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.01;
    if (indexPath.section == 0) {
        height = [MyInfoTableViewCell cellHeight];
    }else{
        height = [MyTitleAndExplainCell cellHeight];
    }
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section == 0) {
        height = 15;
    }else if (section == 4){
        height = 20;
    }else{
        height = 10;
    }
    return height;
}
#pragma mark - tableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *string = self.dataSource[indexPath.section][indexPath.row];
    if ([string isEqualToString:MyInfoCell]) {
    }else if ([string isEqualToString:MyInfoDetailsCell]){
        [MemberDetailsViewController pushToController:self];
    }else if ([string isEqualToString:MyLoginPasswordCell]){
        [ChangePasswordViewController pushToController:self passwordType:ChangePasswordTypeLogin];
    }else if ([string isEqualToString:MyPayPasswordCell]){
        [ChangePasswordViewController pushToController:self passwordType:ChangePasswordTypePayment];
    }else if ([string isEqualToString:MyMessageCenterCell]){
        [MessageCenterViewController pushToController:self];
    }else if ([string isEqualToString:MyQuestionFeedbackCell]){
        [QuestionFeedbackViewController pushToController:self];
    }else if ([string isEqualToString:MyAboutUsCell]){
        [AboutUsViewController pushToController:self];
    }else if ([string isEqualToString:MyLogoutCell]){
        [self logout];
    }
}
- (void)logout
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confim = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [LoginViewController loginWithComplete:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:confim];
    [alertController addAction:cancel];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

+ (void)requestData:(void(^)(NSString *phone,NSString *member_level,BOOL success))complete
{
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:2];
    [GTNetWorking getWithUrl:DOLPHIN_API_USER params:nil success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if ([code integerValue] == 200) {
            complete(data[@"phone"],data[@"member_level"],YES);
        }else{
            complete(nil,nil,NO);
            [MBProgressHUD showTextAddToView:[UIApplication sharedApplication].keyWindow Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        complete(nil,nil,NO);
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD showTextAddToView:[UIApplication sharedApplication].keyWindow Title:error.localizedDescription andHideTime:2];
    }];
}

@end
