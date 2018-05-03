//
//  WithdrawalsViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "WithdrawalsViewController.h"
#import "SetPasswordController.h"

#import "WithdrawaisAccountNumberTableViewCell.h"
#import "WithdrawaisPaymentDateTableViewCell.h"
#import "BaseTableView.h"
#import "FinancialTransferAmountTableViewCell.h"
#import "WithdrawalsConfirmTableViewCell.h"
#import "WithdrawaisMemberLevelTableViewCell.h"
#import "DNPayAlertView.h"

#import "BalanceWithDrawResult.h"

@interface WithdrawalsViewController ()<UITableViewDelegate, UITableViewDataSource,WithdrawalsConfirmTableViewCellDelegate,FinancialTransferAmountTableViewCellDelegate,WithdrawaisAccountNumberTableViewCellDelegat>

@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *accountNumber;
@property (nonatomic, strong) BalanceWithDrawResult *result;

@end

@implementation WithdrawalsViewController

+ (void)pushToController:(UIViewController *)controller
{
    WithdrawalsViewController *bvc = [[WithdrawalsViewController alloc] init];
    [controller.navigationController pushViewController:bvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
    [self requestData];
}
- (void)makeView
{
    [self setCenterTitle:@"提现"];
    [self addLeftBackButton];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-49);
        make.left.right.mas_equalTo(self.view);
    }];
}
#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [WithdrawaisAccountNumberTableViewCell registerCellTableView:_tableView];
        [WithdrawaisPaymentDateTableViewCell registerCellTableView:_tableView];
        [FinancialTransferAmountTableViewCell registerCellTableView:_tableView];
        [WithdrawalsConfirmTableViewCell registerCellTableView:_tableView];
        [WithdrawaisMemberLevelTableViewCell registerCellTableView:_tableView];
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
    if (indexPath.section == 0) {
        height = [WithdrawaisAccountNumberTableViewCell cellHeight];
    }else if(indexPath.section == 1){
        height = [WithdrawaisPaymentDateTableViewCell cellHeight];
    }else if (indexPath.section == 2){
        height = 123;
    }else if (indexPath.section == 3){
        height = [WithdrawaisMemberLevelTableViewCell cellHeight];
    }else if (indexPath.section == 4){
        height = [WithdrawalsConfirmTableViewCell cellHeight];
    }
    return height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[WithdrawaisAccountNumberTableViewCell reuseIdentifier]];
        [(WithdrawaisAccountNumberTableViewCell*)cell reloadTitle:@"收款账号" placeholder:@"请输入收款账号"];
        ((WithdrawaisAccountNumberTableViewCell *)cell).delegate = self;
    }else if(indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:[WithdrawaisPaymentDateTableViewCell reuseIdentifier]];
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:[FinancialTransferAmountTableViewCell reuseIdentifier]];
        ((FinancialTransferAmountTableViewCell *)cell).delegate = self;
        [(FinancialTransferAmountTableViewCell *)cell reloadBlance:self.result.balance fee:self.result.fee placeholder:@"请输入提现金额" title:@"提现金额"];
    }else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:[WithdrawaisMemberLevelTableViewCell reuseIdentifier]];
        [(WithdrawaisMemberLevelTableViewCell *)cell reloadMemberLevel:self.result.member_level earn:self.result.interest_rate];
    }else if (indexPath.section == 4){
        
        cell = [tableView dequeueReusableCellWithIdentifier:[WithdrawalsConfirmTableViewCell reuseIdentifier]];
        ((WithdrawalsConfirmTableViewCell *)cell).delegate = self;
        [(WithdrawalsConfirmTableViewCell *)cell reloadButtonTitle:@"确认提现" desc:@"提现发起后将提交到后台审核"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DFSCREENW, 24)];
        lable.text = @"      提示：当前只支持银行卡提现";
        lable.font = [UIFont systemFontOfSize:9];
        lable.textColor = DFColorWithHexString(@"#E51C23");
        lable.backgroundColor = DFColorWithHexString(@"#F8F8F8");
        return lable;
    }else{
        return [UIView new];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section == 0) {
        height = 24;
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
    return 9;
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
#pragma mark - FinancialTransferAmountTableViewCellDelegate

- (void)textDidEndEdit:(UITextField *)textField
{
    self.amount = textField.text;
    [self requestData];
}
#pragma mark - WithdrawaisAccountNumberTableViewCellDelegat
- (void)accountNumberTextDidEndEdit:(UITextField *)textField
{
    self.accountNumber = textField.text;
}
#pragma mark - WithdrawalsConfirmTableViewCellDelegate
- (void)confirmWithdrawals
{
    
    [self.view endEditing:YES];
    if ([self.amount floatValue] <= 0) {
        [MBProgressHUD showTextAddToView:self.view Title:@"请先输入提现金额" andHideTime:2];
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    SafeDictionarySetObject(params, self.amount, @"withdraw_amount");
    SafeDictionarySetObject(params, self.accountNumber, @"remittance_account");
    
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GTNetWorking postWithUrl:DOLPHIN_API_BALANCE_WITHDRAW_CONFIRM params:params success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([code integerValue] == 200) {
            BOOL need_init = [data[@"need_init"] boolValue];
            if (need_init) {
                [SetPasswordController setWithPasswrodState:SetPasswordStateSetNewPassword passwordType:PasswordTypePay Complete:^(BOOL success) {
                    if (success) {
                        [weakSelf payCheck];
                    }
                }];
            }else{
                [weakSelf payCheck];
            }
        }else{
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showTextAddToView:weakSelf.view Title:error.localizedDescription andHideTime:2];
    }];
}
- (void)payCheck
{
    [DNPayAlertViewManager showPayAlertWithTitle:@"请输入交易密码" detail:@"提现金额" amount:[self.amount floatValue] action:@"withdraw" complete:^(BOOL paysuccess) {
        if (paysuccess) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)requestData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    SafeDictionarySetObject(params, self.amount, @"withdraw_amount");
    SafeDictionarySetObject(params, self.accountNumber, @"remittance_account");
//    SafeDictionarySetObject(params, @"", @"is_back");
    [GTNetWorking postWithUrl:DOLPHIN_API_BALANCE_WITHDRAW params:params success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code integerValue] == 200) {
            self.result = [BalanceWithDrawResult yy_modelWithJSON:data];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showTextAddToView:self.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showTextAddToView:self.view Title:error.localizedDescription andHideTime:2];
    }];
}
@end
