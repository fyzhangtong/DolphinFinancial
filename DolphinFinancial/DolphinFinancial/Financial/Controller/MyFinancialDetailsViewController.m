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

@interface MyFinancialDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

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
    self.dataSource = @[@[MyFinancialDetailsFirstTotal,MyFinancialDetailsSecondTotal],@[MyFinancialDetailsTotalProfit,MyFinancialDetailsYestdayProfit],@[MyFinancialDetailsBorrowers],@[MyFinancialDetailsBuyDate,MyFinancialDetailsExpirationDate]];
    [self.tableView reloadData];
}
- (void)makeView
{
    [self setCenterTitle:@"我的"];
    [self addLeftBackButton];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-49);
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

#pragma mark - tableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSString *string = self.dataSource[indexPath.section][indexPath.row];
    if ([string isEqualToString:MyFinancialDetailsFirstTotal]) {
        cell =[tableView dequeueReusableCellWithIdentifier:[MyFinancialDetailsTotalTableViewCell reuseIdentifier]];
    }else
    {
        MyFinancialDetailsExplainTableViewCell *cell1 =[tableView dequeueReusableCellWithIdentifier:[MyFinancialDetailsExplainTableViewCell reuseIdentifier]];
        if ([string isEqualToString:MyFinancialDetailsSecondTotal]){
            [cell1 reloadData:@"购买金额" explain:@"¥3028.00"];
        }else if ([string isEqualToString:MyFinancialDetailsTotalProfit]){
            [cell1 reloadData:@"累计收益" explain:@"¥28.00"];
        }else if ([string isEqualToString:MyFinancialDetailsYestdayProfit]){
            [cell1 reloadData:@"昨日收益" explain:@"¥1.23"];
        }else if ([string isEqualToString:MyFinancialDetailsBorrowers]){
            [cell1 reloadData:@"借款人列表" explain:@"共4位借款人"];
            [cell1 showRightArrow:YES];
        }else if ([string isEqualToString:MyFinancialDetailsBuyDate]){
            [cell1 reloadData:@"购买时间" explain:@"2018-03-11 11:00:00"];
        }else if ([string isEqualToString:MyFinancialDetailsExpirationDate]){
            [cell1 reloadData:@"到期时间" explain:@"2018-03-11 11:00:00"];
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


@end
