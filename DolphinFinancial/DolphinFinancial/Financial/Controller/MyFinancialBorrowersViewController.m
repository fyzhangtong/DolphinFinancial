//
//  MyFinancialBorrowersViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/28.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyFinancialBorrowersViewController.h"

#import "MyFinancialBorrowersHeadTableViewCell.h"
#import "MyFinancialBorrowerTableViewCell.h"

#import "Borrower.h"

@interface MyFinancialBorrowersViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Borrower *> *dataSource;

@end

@implementation MyFinancialBorrowersViewController

+ (void)pushToController:(UIViewController *)controller
{
    MyFinancialBorrowersViewController *vc = [[MyFinancialBorrowersViewController alloc] init];
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self makeView];
    self.dataSource = [[NSMutableArray alloc] init];
    [self requestData];
}

- (void)makeView
{
    [self setCenterTitle:@"借款人列表"];
    [self addLeftBackButton];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [MyFinancialBorrowersHeadTableViewCell registerCellTableView:_tableView];
        [MyFinancialBorrowerTableViewCell registerCellTableView:_tableView];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
//        [_tableView setBackgroundColor:DFColorWithHexString(@"#F8F8F8")];
        [_tableView setSeparatorColor:DFColor(204, 204, 204)];
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
        height = [MyFinancialBorrowersHeadTableViewCell cellHeight];
    }else{
        height = [MyFinancialBorrowerTableViewCell cellHeight];
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    if (self.dataSource.count) {
        count = 2;
    }
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == 0) {
        count = 1;
    }else{
        count = self.dataSource.count;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        MyFinancialBorrowersHeadTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:[MyFinancialBorrowersHeadTableViewCell reuseIdentifier]];
        [cell1 reloadData:self.dataSource.count];
        cell = cell1;
    }else{
        MyFinancialBorrowerTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:[MyFinancialBorrowerTableViewCell reuseIdentifier]];
        [cell1 reloadBorrower:self.dataSource[indexPath.row]];
        cell = cell1;
    }
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
}

- (void)requestData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [GTNetWorking getWithUrl:DOLPHIN_API_USER_PRODUCTS_BORROWERS(@(1)) params:nil success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([code integerValue] == 200) {
            [weakSelf.dataSource removeAllObjects];
            if ([data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in data) {
                    Borrower *borrower = [Borrower yy_modelWithDictionary:dic];
                    [weakSelf.dataSource addObject:borrower];
                }
            }
            
            [weakSelf.tableView reloadData];
        }else{
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showTextAddToView:weakSelf.view Title:error.localizedDescription andHideTime:2];
        Borrower *borrower = [[Borrower alloc] init];
        borrower.borrower = @"34520089";
        borrower.status = @"还款中";
        borrower.product_name = @"1月定存";
        borrower.borrow_time = @"2018";
        [weakSelf.dataSource addObject:borrower];
        [weakSelf.tableView reloadData];
    }];
}


@end
