//
//  AssetsRecordViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AssetsRecordViewController.h"
#import "AssetsRecordTableViewCell.h"

@interface AssetsRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) RecordType recordType;

@end

@implementation AssetsRecordViewController

+ (void)pushToController:(UIViewController *)controller recordType:(RecordType)recordType
{
    AssetsRecordViewController *arvc = [[AssetsRecordViewController alloc] init];
    arvc.recordType = recordType;
    [controller.navigationController pushViewController:arvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"资产记录"];
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
        [AssetsRecordTableViewCell registerCellTableView:_tableView];
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
    return [AssetsRecordTableViewCell cellHeight];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssetsRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AssetsRecordTableViewCell reuseIdentifier]];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DFSCREENW, 24)];
        lable.text = @"      提示：仅展示近30天内的收益记录";
        lable.font = [UIFont systemFontOfSize:9];
        lable.textColor = DFColorWithHexString(@"#E51C23 100%");
        lable.backgroundColor = DFColorWithHexString(@"#F8F8F8");
        return lable;
    }else{
        return [UIView new];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (self.recordType == RecordTypeProfit) {
        height = 24;
    }
    return height;
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
