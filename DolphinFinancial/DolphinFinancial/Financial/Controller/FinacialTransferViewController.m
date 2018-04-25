//
//  FinacialTransferViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/10.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinacialTransferViewController.h"

#import "BaseTableView.h"

#import "FinancialTranferProductNameTableViewCell.h"
#import "FinancialTransferAmountTableViewCell.h"
#import "FinancialTransferInfoTableViewCell.h"
#import "FinancialTransferButtonTableViewCell.h"
#import "SetPasswordController.h"
#import "DNPayAlertView.h"

#import "FinancialTransferModel.h"

@interface FinacialTransferViewController ()<UITableViewDelegate,UITableViewDataSource,FinancialTransferButtonTableViewCellDelegate,FinancialTransferAmountTableViewCellDelegate>

@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, copy) NSNumber *product_id;
@property (nonatomic, strong) FinancialTransferModel *transfer;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, copy) NSString *auto_continue;

@end

@implementation FinacialTransferViewController

+ (void)pushToController:(UIViewController *)controller productId:(NSNumber *)productId
{
    FinacialTransferViewController *vc = [[FinacialTransferViewController alloc] init];
    vc.product_id = productId;
    [controller.navigationController pushViewController:vc animated:YES];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
    [self requestData:self.product_id transferAmount:@"0" autoContinue:@"NO" isBack:@""];
}

- (void)makeView
{
    [self setCenterTitle:@"转入"];
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
        [FinancialTranferProductNameTableViewCell registerCellTableView:_tableView];
        [FinancialTransferAmountTableViewCell registerCellTableView:_tableView];
        [FinancialTransferInfoTableViewCell registerCellTableView:_tableView];
        [FinancialTransferButtonTableViewCell registerCellTableView:_tableView];
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
        height = [FinancialTranferProductNameTableViewCell cellHeight];
    }else if(indexPath.section == 1){
        height = [FinancialTransferAmountTableViewCell cellHeight];
    }else if (indexPath.section == 2){
        height = [FinancialTransferInfoTableViewCell cellHeight];
    }else if (indexPath.section == 3){
        height = [FinancialTransferButtonTableViewCell cellHeight];
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
        cell = [tableView dequeueReusableCellWithIdentifier:[FinancialTranferProductNameTableViewCell reuseIdentifier]];
        [(FinancialTranferProductNameTableViewCell *)cell reloadName:self.transfer.product_name rate:self.transfer.interest_rate];
    }else if(indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:[FinancialTransferAmountTableViewCell reuseIdentifier]];
        ((FinancialTransferAmountTableViewCell *)cell).delegate = self;
        [(FinancialTransferAmountTableViewCell *)cell reloadBlance:self.transfer.balance_amount fee:@"2.00%"];
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:[FinancialTransferInfoTableViewCell reuseIdentifier]];
        [(FinancialTransferInfoTableViewCell *)cell reloadinterestRate:self.transfer.interest_rate targetIncome:self.transfer.target_income incomeDescription:self.transfer.income_description];
    }else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:[FinancialTransferButtonTableViewCell reuseIdentifier]];
        ((FinancialTransferButtonTableViewCell *)cell).delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
#pragma mark - FinancialTransferButtonTableViewCellDelegate
/**
 自动续存按钮点击事件
 
 @param sender 按钮
 */
- (void)autoTransferButtonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.auto_continue = sender.selected ? @"true" : @"false";
}
/**
 确认转入按钮点击事件
 
 @param sender 按钮
 */
- (void)transferButtonAction:(UIButton *)sender
{
    if ([self.amount floatValue] <= 0) {
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    SafeDictionarySetObject(params, self.product_id, @"product_id");
    SafeDictionarySetObject(params, self.amount, @"transfer_amount");
    SafeDictionarySetObject(params, self.auto_continue, @"auto_continue");
    
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GTNetWorking postWithUrl:DOLPHIN_API_PRODUCT_TRANSFER_CONFIRM params:params success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([code integerValue] == 200) {
            BOOL need_init = data[@"need_init"];
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
    DNPayAlertView *payAlert = [[DNPayAlertView alloc]init];
    payAlert.titleStr = @"请输入交易密码";
    payAlert.detail = @"转入金额";
    payAlert.amount= [self.amount floatValue];
    [payAlert show];
    payAlert.completeHandle = ^(NSString *inputPwd) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        SafeDictionarySetObject(params, inputPwd, @"pay_password");
        SafeDictionarySetObject(params, @"product", @"action");
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak typeof(self) weakSelf = self;
        [GTNetWorking postWithUrl:DOLPHIN_API_PAYCHECK params:params success:^(NSNumber *code, NSString *msg, id data) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            if ([code integerValue] == 200) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        } fail:^(NSError *error) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [MBProgressHUD showTextAddToView:weakSelf.view Title:error.localizedDescription andHideTime:2];
        }];
    };
}

/**
 理财产品金额转入页数据接口

 @param productId 产品ID
 @param transferAmount 转入金额
 @param autoContinue 是否自动续投
 @param isBack 是否返回进入
 */
- (void)requestData:(NSNumber *)productId transferAmount:(NSString *)transferAmount autoContinue:(NSString *)autoContinue isBack:(NSString *)isBack
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    SafeDictionarySetObject(params, transferAmount, @"transfer_amount");
    SafeDictionarySetObject(params, productId, @"product_id");
    SafeDictionarySetObject(params, autoContinue, @"auto_continue");
    
    [GTNetWorking postWithUrl:DOLPHIN_API_PRODUCT_TRANSFER_INIT params:params success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([code integerValue] == 200) {
            weakSelf.transfer = [FinancialTransferModel yy_modelWithDictionary:data];
            [weakSelf.tableView reloadData];
        }else{
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showTextAddToView:weakSelf.view Title:error.localizedDescription andHideTime:2];
    }];
}

@end
