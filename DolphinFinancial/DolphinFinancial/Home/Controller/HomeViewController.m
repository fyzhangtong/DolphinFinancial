//
//  HomeViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/16.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "HomeViewController.h"

#import "FinacialDetailsController.h"
#import "MessageDetailsViewController.h"

#import "BaseTableView.h"
#import "HomeAmountTableViewCell.h"
#import "HomeNoticeTableViewCell.h"
#import "HomeFinancialTableViewCell.h"

#import "DFNotice.h"
#import "DFProduct.h"
#import "UserManager.h"

#define HomeAmountCellString @"HomeAmountCellString"
#define HomeNoticeCellString @"HomeNoticeCellString"
#define HomeFinancialCellString @"HomeFinancialCellString"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, copy) NSString *per_financial_amount;
@property (nonatomic, copy) NSString *total_borrower;
@property (nonatomic, strong) DFProduct *product;
@property (nonatomic, strong) DFNotice *notice;
@property (nonatomic, strong) NSMutableArray *dataSource;

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
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:2];
    [self loadDataWithHud:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)makeView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-49);
        make.left.right.mas_equalTo(self.view);
    }];
}


#pragma mark - 懒加载
- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [HomeAmountTableViewCell registerCellTableView:_tableView];
        [HomeNoticeTableViewCell registerCellTableView:_tableView];
        [HomeFinancialTableViewCell registerCellTableView:_tableView];
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
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadDataWithHud:NO];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;

        _tableView.mj_header = header;
    }
    return _tableView;
}


#pragma mark - tableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.01f;
    NSString *string = self.dataSource[indexPath.section][indexPath.row];
    if ([string isEqualToString:HomeAmountCellString]) {
        height = [HomeAmountTableViewCell cellHeight];
    }else if ([string isEqualToString:HomeNoticeCellString]){
        height = [HomeNoticeTableViewCell cellHeight];
    }
    else if ([string isEqualToString:HomeFinancialCellString]){
        height = [HomeFinancialTableViewCell cellHeight];
    }
    return height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)_dataSource[section]).count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1;
    NSString *string = self.dataSource[indexPath.section][indexPath.row];
    if ([string isEqualToString:HomeAmountCellString]) {
        HomeAmountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeAmountTableViewCell reuseIdentifier]];
        [cell reloadAmount:self.per_financial_amount borrowerNumber:self.total_borrower];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell1 = cell;
    }else if ([string isEqualToString:HomeNoticeCellString]){
        HomeNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeNoticeTableViewCell reuseIdentifier]];
        [cell reloadNotice:self.notice.title];
        cell1 = cell;
    }
    else if ([string isEqualToString:HomeFinancialCellString]){
        HomeFinancialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeFinancialTableViewCell reuseIdentifier]];
        [cell reloadProduct:self.product];
        cell1 = cell;
    }
    return cell1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section == 1) {
        height = 35;
    }
    return height;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DFSCREENW, 35)];
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(0, 0, DFSCREENW, 35);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = DFColorWithHexString(@"#101010");
        label.text = @"   今日推荐产品";
        label.layer.masksToBounds = YES;
        [label setBackgroundColor:[UIColor whiteColor]];
        [view addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 34, DFSCREENW, 1)];
        line.backgroundColor = DFColorWithHexString(@"#F8F8F8");
        [view addSubview:line];
        return view;
    }else{
        return [UIView new];
    }
    
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
    if ([string isEqualToString:HomeNoticeCellString]){
        [MessageDetailsViewController pushToController:self.navigationController notice:self.notice];
    }
    else if ([string isEqualToString:HomeFinancialCellString]){
        [FinacialDetailsController pushTo:self.navigationController productId:self.product.id];
    }
}


#pragma mark - 网络请求
- (void)loadDataWithHud:(BOOL)showHud
{
    if (showHud) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [GTNetWorking getWithUrl:DOLPHIN_API_INDEX params:nil showLoginIfNeed:YES success:^(NSNumber *code, NSString *msg, id data) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code integerValue] == 200) {
            [self.dataSource removeAllObjects];
            NSDictionary *platform_info = data[@"platform_info"];
            self.per_financial_amount = platform_info[@"per_financial_amount"];
            self.total_borrower = platform_info[@"total_borrower"];
            
            
            self.notice = [DFNotice yy_modelWithDictionary:data[@"notice"]];
            self.product = [DFProduct yy_modelWithDictionary:data[@"product"]];
            
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
            [array addObject:HomeAmountCellString];
            if (self.notice.title.length) {
                [array addObject:HomeNoticeCellString];
            }
            [self.dataSource addObject:array];
            if (self.product.name.length) {
                [self.dataSource addObject:@[HomeFinancialCellString]];
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showTextAddToView:self.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showTextAddToView:self.view Title:@"网络出错，请稍后再试！" andHideTime:2];
    }];
}

@end
