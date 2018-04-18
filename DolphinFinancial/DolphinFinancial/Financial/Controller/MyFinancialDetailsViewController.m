//
//  MyFinancialDetailsViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/27.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyFinancialDetailsViewController.h"
#import "MyFinancialBorrowersViewController.h"

#import "MyFinancialDetailsTotalTableViewCell.h"
#import "MyFinancialDetailsExplainTableViewCell.h"

#define MyFinancialDetailsFirstTotal @"MyFinancialDetailsFirstTotal"
#define MyFinancialDetailsSecondTotal @"MyFinancialDetailsSecondTotal"
#define MyFinancialDetailsTotalProfit @"MyFinancialDetailsTotalProfit"
#define MyFinancialDetailsYestdayProfit @"MyFinancialDetailsYestdayProfit"
#define MyFinancialDetailsBorrowers @"MyFinancialDetailsBorrowers"
#define MyFinancialDetailsBuyDate @"MyFinancialDetailsBuyDate"
#define MyFinancialDetailsExpirationDate @"MyFinancialDetailsExpirationDate"
#define MYFinancialDetailsStatus @"MYFinancialDetailsStatus"
#define MYFinancialDetailsAutoContinue @"MYFinancialDetailsAutoContinue"
#define MYFinancialDetailsContinueTime @"MYFinancialDetailsContinueTime"

#import "UserFinancial.h"
#import "UIImage+ImageWithColor.h"

@interface MyFinancialDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserFinancial *financial;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *transferButton;

@end

@implementation MyFinancialDetailsViewController

+ (void)pushToController:(UIViewController *)controller
{
    MyFinancialDetailsViewController *vc = [[MyFinancialDetailsViewController alloc] init];
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
    [self requestData];
}
- (void)makeView
{
    [self setCenterTitle:@"我的理财产品"];
    [self addLeftBackButton];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    //底部试图
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(DFTABBARBOTTOMHEIGHT+55);//一行14字号的高度+上下边距为5+线
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(_bottomView.mas_top);
    }];
    
    [self.bottomView addSubview:self.transferButton];
    [self.transferButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView.mas_top).mas_offset(8);
        make.left.mas_equalTo(self.bottomView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.bottomView.mas_right).mas_offset(-10);
        make.height.mas_equalTo(40);
    }];
    
}
#pragma mark - getter 方法
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [MyFinancialDetailsTotalTableViewCell registerCellTableView:_tableView];
        [MyFinancialDetailsExplainTableViewCell registerCellTableView:_tableView];
        [_tableView setBackgroundColor:DFColorWithHexString(@"#F8F8F8")];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [UIView new];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
    }
    return _bottomView;
}
- (UIButton *)transferButton
{
    
    if (!_transferButton) {
        _transferButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_transferButton setTitle:@"转出" forState:UIControlStateNormal];
        _transferButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_transferButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_transferButton setTitleColor:DFTINTCOLOR forState:UIControlStateNormal];
        _transferButton.layer.borderWidth = 1;
        _transferButton.layer.cornerRadius = 4;
        _transferButton.layer.masksToBounds = YES;
        _transferButton.layer.borderColor = DFTINTCOLOR.CGColor;
        [_transferButton addTarget:self action:@selector(transferButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _transferButton;
}
#pragma mark - tableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *string = self.dataSource[indexPath.section][indexPath.row];
    if ([string isEqualToString:MyFinancialDetailsFirstTotal]) {
        cell =[tableView dequeueReusableCellWithIdentifier:[MyFinancialDetailsTotalTableViewCell reuseIdentifier]];
        [(MyFinancialDetailsTotalTableViewCell *)cell reloadName:self.financial.product_name total:self.financial.total_amount];
    }else
    {
        MyFinancialDetailsExplainTableViewCell *cell1 =[tableView dequeueReusableCellWithIdentifier:[MyFinancialDetailsExplainTableViewCell reuseIdentifier]];
        if ([string isEqualToString:MyFinancialDetailsSecondTotal]){
            [cell1 reloadData:@"购买金额" explain:self.financial.total_amount];
        }else if ([string isEqualToString:MyFinancialDetailsTotalProfit]){
            [cell1 reloadData:@"累计收益" explain:self.financial.total_income];
        }else if ([string isEqualToString:MyFinancialDetailsYestdayProfit]){
            [cell1 reloadData:@"昨日收益" explain:self.financial.yesterday_income];
        }else if ([string isEqualToString:MyFinancialDetailsBorrowers]){
            [cell1 reloadData:@"借款人列表" explain:self.financial.borrower_info];
            [cell1 showRightArrow:YES];
        }else if ([string isEqualToString:MyFinancialDetailsBuyDate]){
            [cell1 reloadData:@"购买时间" explain:self.financial.buy_time];
        }else if ([string isEqualToString:MyFinancialDetailsExpirationDate]){
            [cell1 reloadData:@"到期时间" explain:self.financial.expiration_time];
        }else if ([string isEqualToString:MYFinancialDetailsAutoContinue]){
            [cell1 reloadData:@"到期自动续投" explain:self.financial.auto_continue];
        }else if ([string isEqualToString:MYFinancialDetailsStatus]){
            [cell1 reloadData:@"状态" explain:self.financial.status];
        }else if ([string isEqualToString:MYFinancialDetailsContinueTime]){
            [cell1 reloadData:@"当前续投" explain:self.financial.continue_time];
        }
        cell = cell1;
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
    if (indexPath.section == 0 && indexPath.row == 0) {

        height = [MyFinancialDetailsTotalTableViewCell cellHeight];
    }else{
        height = [MyFinancialDetailsExplainTableViewCell cellHeight];
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
    return 10;
}
#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *string = self.dataSource[indexPath.section][indexPath.row];
    if ([string isEqualToString:MyFinancialDetailsBorrowers]) {
        [MyFinancialBorrowersViewController pushToController:self];
    }
}

- (void)requestData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [GTNetWorking getWithUrl:DOLPHIN_API_USER_PRODUCT(self.financial.userFinancialId) params:nil success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([code integerValue] == 200) {
            UserFinancial *financail = [UserFinancial yy_modelWithJSON:data];
            weakSelf.financial = financail;
            if ([financail.status isEqualToString:@"首投"] ) {
                weakSelf.dataSource = @[@[MyFinancialDetailsFirstTotal,MyFinancialDetailsSecondTotal],@[MyFinancialDetailsTotalProfit,MyFinancialDetailsYestdayProfit],@[MYFinancialDetailsAutoContinue,MYFinancialDetailsStatus],@[MyFinancialDetailsBorrowers],@[MyFinancialDetailsBuyDate,MyFinancialDetailsExpirationDate]];
            }else{
                weakSelf.dataSource = @[@[MyFinancialDetailsFirstTotal,MyFinancialDetailsSecondTotal],@[MyFinancialDetailsTotalProfit,MyFinancialDetailsYestdayProfit],@[MYFinancialDetailsAutoContinue,MYFinancialDetailsStatus,MYFinancialDetailsContinueTime],@[MyFinancialDetailsBorrowers],@[MyFinancialDetailsBuyDate,MyFinancialDetailsExpirationDate]];
            }
            [weakSelf.tableView reloadData];
        }else{
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showTextAddToView:weakSelf.view Title:error.localizedDescription andHideTime:2];
        UserFinancial *fina = [[UserFinancial alloc] init];
        fina.total_amount = @"30298";
        fina.total_income = @"768";
        fina.yesterday_income = @"78";
        fina.borrower_info = @"共8人借款人";
        fina.buy_time = @"2018";
        fina.expiration_time = @"2019";
        fina.status = @"续投";
        fina.continue_time = @"第三次";
        fina.auto_continue = @"是";
        weakSelf.financial = fina;
        if ([fina.status isEqualToString:@"首投"] ) {
            weakSelf.dataSource = @[@[MyFinancialDetailsFirstTotal,MyFinancialDetailsSecondTotal],@[MyFinancialDetailsTotalProfit,MyFinancialDetailsYestdayProfit],@[MYFinancialDetailsAutoContinue,MYFinancialDetailsStatus],@[MyFinancialDetailsBorrowers],@[MyFinancialDetailsBuyDate,MyFinancialDetailsExpirationDate]];
        }else{
            weakSelf.dataSource = @[@[MyFinancialDetailsFirstTotal,MyFinancialDetailsSecondTotal],@[MyFinancialDetailsTotalProfit,MyFinancialDetailsYestdayProfit],@[MYFinancialDetailsAutoContinue,MYFinancialDetailsStatus,MYFinancialDetailsContinueTime],@[MyFinancialDetailsBorrowers],@[MyFinancialDetailsBuyDate,MyFinancialDetailsExpirationDate]];
        }
        [weakSelf.tableView reloadData];
    }];
    
}

- (void)transferButtonClick:(UIButton *)sender
{
    
}


@end
