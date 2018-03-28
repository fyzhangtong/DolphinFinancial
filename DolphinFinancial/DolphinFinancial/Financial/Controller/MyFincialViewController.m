//
//  MyFincialViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/21.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MyFincialViewController.h"
#import "MyFinacialTableViewCell.h"
#import "MyFinancialDetailsViewController.h"

@interface MyFincialViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) void(^complete)(BOOL success);
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyFincialViewController

+ (void)pushToController:(UIViewController *)controller Complete:(void(^)(BOOL success))complete
{
    MyFincialViewController *landVC = [[MyFincialViewController alloc] init];
    landVC.complete = complete;
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller.navigationController pushViewController:landVC animated:YES];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}
- (void)makeView
{
    [self setCenterTitle:@"我的理财产品"];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [MyFinacialTableViewCell registerCellTableView:_tableView];
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
    return [MyFinacialTableViewCell cellHeight];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyFinacialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyFinacialTableViewCell reuseIdentifier]];
    
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
    [MyFinancialDetailsViewController pushToController:self];
}


@end
