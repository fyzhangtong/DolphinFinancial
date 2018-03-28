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

@interface MyFinancialBorrowersViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == 0) {
        count = 1;
    }else{
        count = 4;
    }
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        MyFinancialBorrowersHeadTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:[MyFinancialBorrowersHeadTableViewCell reuseIdentifier]];
        cell = cell1;
    }else{
        MyFinancialBorrowerTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:[MyFinancialBorrowerTableViewCell reuseIdentifier]];
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


@end
