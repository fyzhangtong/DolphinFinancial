//
//  FinacialViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/16.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinacialViewController.h"
#import "FinancialViewCell.h"
#import "MyFincialViewController.h"
#import "FinacialDetailsController.h"
#import "DFProduct.h"

@interface FinacialViewController ()<UITableViewDelegate, UITableViewDataSource>

{
    NSMutableArray<DFProduct *> *_dataSource;
    
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FinacialViewController

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
    [self setCenterTitle:@"理财"];
    [self setRightButtonImage:[UIImage imageNamed:@"message"]];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-49);
        make.left.right.mas_equalTo(self.view);
    }];
    _dataSource = [[NSMutableArray alloc] init];
    [self loadData];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [FinancialViewCell registerCellTableView:_tableView];
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
    return [FinancialViewCell cellHeight];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FinancialViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[FinancialViewCell reuseIdentifier]];
    [cell reloadData:_dataSource[indexPath.row]];
    return cell;
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
    FinacialDetailsController *fdc = [[FinacialDetailsController alloc] init];
    [self.navigationController pushViewController:fdc animated:YES];
}

#pragma mark - 网络请求
- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [GTNetWorking getWithUrl:DOLPHIN_API_PRODUCTS params:nil success:^(NSNumber *code, NSString *msg, id data) {
        if ([code integerValue] == 200) {
            _dataSource = data;
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSDictionary *dic  in (NSArray *)data) {
                DFProduct *product = [DFProduct yy_modelWithDictionary:dic];
                [array addObject:product];
            }
            [weakSelf.tableView reloadData];
        }else{
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showTextAddToView:weakSelf.view Title:error.localizedDescription andHideTime:2];
    }];
}

- (void)rightButtonClick:(UIButton *)sender

{
    [MyFincialViewController pushToController:self Complete:nil];
}
@end
