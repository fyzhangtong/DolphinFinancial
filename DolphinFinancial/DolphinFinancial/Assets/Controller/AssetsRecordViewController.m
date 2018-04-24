//
//  AssetsRecordViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AssetsRecordViewController.h"
#import "AssetsRecordTableViewCell.h"
#import "FinacialRecord.h"

@interface AssetsRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) RecordType recordType;
@property (nonatomic, strong) NSMutableArray<FinacialRecord *> *dataSource;

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
    self.dataSource = [[NSMutableArray alloc] init];
}

- (void)makeView
{
    if (self.recordType == RecordTypeAessets) {
        [self setCenterTitle:@"资产记录"];
    }else{
        [self setCenterTitle:@"收益记录"];
    }
    
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
    [cell reloadData:SafeArrayObjectIndex(self.dataSource, indexPath.row)];
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
#pragma mark - 网络请求
- (void)reqestData
{
    __weak typeof(self) weakSelf = self;
    NSString *url;
    if (self.recordType == RecordTypeProfit) {
        //收益记录
        url = DOLPHIN_API_EARN_RECORD;
    }else{
        //资产记录
        url = DOLPHIN_API_ASSET_RECORD;
    }
    [GTNetWorking getWithUrl:url params:nil success:^(NSNumber *code, NSString *msg, id data) {
        if ([code integerValue] == 200) {
            [weakSelf.dataSource removeAllObjects];
            NSArray<NSDictionary *> *array = data;
            [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FinacialRecord *record = [FinacialRecord yy_modelWithDictionary:obj];
                [weakSelf.dataSource addObject:record];
            }];
            [weakSelf.tableView reloadData];
        }else{
            [MBProgressHUD showTextAddToView:weakSelf.view Title:msg andHideTime:2];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showTextAddToView:weakSelf.view Title:error.localizedDescription andHideTime:2];
    }];
}
@end
