//
//  RechargeViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/23.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "RechargeViewController.h"

#import "WithdrawaisAccountNumberTableViewCell.h"
#import "FinancialTransferAmountTableViewCell.h"
#import "WithdrawalsConfirmTableViewCell.h"
#import "WithdrawaisMemberLevelTableViewCell.h"
#import "DNPayAlertView.h"

#import "BaseTableView.h"

@interface RechargeViewController ()<UITableViewDelegate, UITableViewDataSource,WithdrawalsConfirmTableViewCellDelegate,FinancialTransferAmountTableViewCellDelegate>

@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, copy) NSString *amount;

@end

@implementation RechargeViewController

+ (void)pushToController:(UIViewController *)controller
{
    RechargeViewController *bvc = [[RechargeViewController alloc] init];
    [controller.navigationController pushViewController:bvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}
- (void)makeView
{
    [self setCenterTitle:@"充值"];
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
    }else if (indexPath.section == 1){
        height = 123;
    }else if (indexPath.section == 2){
        height = [WithdrawaisMemberLevelTableViewCell cellHeight];
    }else if (indexPath.section == 3){
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
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:[WithdrawaisAccountNumberTableViewCell reuseIdentifier]];
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:[FinancialTransferAmountTableViewCell reuseIdentifier]];
        ((FinancialTransferAmountTableViewCell *)cell).delegate = self;
        [(FinancialTransferAmountTableViewCell *)cell reloadBlance:@"1000" fee:@"2.00%"];
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:[WithdrawaisMemberLevelTableViewCell reuseIdentifier]];
        [(WithdrawaisMemberLevelTableViewCell *)cell reloadMemberLevel:@"普通会员" earn:@"2.00%"];
    }else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:[WithdrawalsConfirmTableViewCell reuseIdentifier]];
        ((WithdrawalsConfirmTableViewCell *)cell).delegate = self;
        [(WithdrawalsConfirmTableViewCell *)cell reloadButtonTitle:@"确认充值"];
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
}
#pragma mark - WithdrawalsConfirmTableViewCellDelegate
- (void)confirmWithdrawals
{
    
    DNPayAlertView *payAlert = [[DNPayAlertView alloc]init];
    payAlert.titleStr = @"请输入交易密码";
    payAlert.detail = @"提现";
    payAlert.amount= 10;
    [payAlert show];
    payAlert.completeHandle = ^(NSString *inputPwd) {
        NSLog(@"密码是%@",inputPwd);
    };
}

@end
