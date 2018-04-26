//
//  ChangeLoginPasswordViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "BaseTableView.h"
#import "TextFieldTableViewCell.h"
#import "ChangePasswordButtonTableViewCell.h"

@interface ChangePasswordViewController ()<UITableViewDelegate,UITableViewDataSource,ChangePasswordButtonTableViewCellDelegate>

@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, copy) NSString *originalPassword;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *confirmPassword;
@property (nonatomic, assign) ChangePasswordType passwordType;

@end

@implementation ChangePasswordViewController

+ (void)pushToController:(UIViewController *)controller passwordType:(ChangePasswordType)passwordType
{
    ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
    vc.passwordType = passwordType;
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}

- (void)makeView
{
    if (self.passwordType == ChangePasswordTypeLogin) {
        [self setCenterTitle:@"修改登录密码"];
    }else{
        [self setCenterTitle:@"修改交易密码"];
    }
    
    [self addLeftBackButton];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-49);
        make.left.right.mas_equalTo(self.view);
    }];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [TextFieldTableViewCell registerCellTableView:_tableView];
        [ChangePasswordButtonTableViewCell registerCellTableView:_tableView];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 0 || indexPath.section == 1) {
        height = [TextFieldTableViewCell cellHeight];
    }else{
        height = [ChangePasswordButtonTableViewCell cellHeight];
    }
    return height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    if (section == 0) {
        number = 1;
    }else if (section == 1){
        number = 2;
    }else if (section == 2){
        number = 1;
    }
    return number;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        TextFieldTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:[TextFieldTableViewCell reuseIdentifier]];
        self.originalPassword = @"";
        [cell1 reloadWithTitle:@"原登录密码" placeholder:@"请输入原登录密码" didEndEditingHandle:^(NSString *text) {
            weakSelf.originalPassword = text;
        }];
        cell = cell1;
    }else if (indexPath.section == 1){
        TextFieldTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:[TextFieldTableViewCell reuseIdentifier]];
        if (indexPath.row == 0) {
            self.password = @"";
            [cell1 reloadWithTitle:@"新登录密码" placeholder:@"6-16位，含数字、字母"  didEndEditingHandle:^(NSString *text) {
                weakSelf.password = text;
            }];
        }else if (indexPath.row == 1){
            self.confirmPassword = @"";
            [cell1 reloadWithTitle:@"确认密码" placeholder:@"6-16位，含数字、字母"  didEndEditingHandle:^(NSString *text) {
                weakSelf.confirmPassword = text;
            }];
        }
        cell = cell1;
    }else if (indexPath.section == 2){
        ChangePasswordButtonTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:[ChangePasswordButtonTableViewCell reuseIdentifier]];
        cell1.delegate = self;
        cell = cell1;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 9;

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
}

#pragma mark - ChangePasswordButtonTableViewCellDelegate
- (void)confirmChangePassword
{
    NSLog(@"确定");
    if (self.passwordType == ChangePasswordTypeLogin) {
        [self setNewPassword:DOLPHIN_API_USER_PASSWORD_MODIFY];
    }else{
        [self setNewPassword:DOLPHIN_API_USER_PAY_MODIFY];
    }
}
//设置密码
- (void)setNewPassword:(NSString *)url
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    SafeDictionarySetObject(params, self.originalPassword, @"old_password");
    SafeDictionarySetObject(params, self.password, @"new_password");
    SafeDictionarySetObject(params, self.confirmPassword, @"confirm_password");
    [GTNetWorking postWithUrl:url params:params success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code integerValue] == 200) {
            [self.tableView reloadData];
        }
        [MBProgressHUD showTextAddToView:self.view Title:msg andHideTime:2];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showTextAddToView:self.view Title:error.localizedDescription andHideTime:2];
    }];
}

@end
