//
//  AssetsViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/16.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AssetsViewController.h"
#import "AssetsMoneyCollectionViewCell.h"
#import "AssetsTotalCollectionViewCell.h"
#import "AssetsTotalProfitCollectionViewCell.h"
#import "AssetsProfitRecordsCollectionViewCell.h"
#import "AssetsYieldCurveCollectionViewCell.h"
#import "AssetsRecordViewController.h"
#import "BalanceViewController.h"

@interface AssetsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation AssetsViewController

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
    [self makeView];
    self.earns = [[NSMutableArray alloc] init];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self requestData];
}

- (void)makeView
{
    [self setCenterTitle:@"资产"];
    [self setRightButtonImage:[UIImage imageNamed:@"icon_record"]];
    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, DFNAVIGATIONBARHEIGHT, DFSCREENW, DFSCREENH - DFTABBARHEIGHT - DFNAVIGATIONBARHEIGHT) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = DFColorWithHexString(@"#F8F8F8");
        _collectionView.alwaysBounceVertical = YES;
        
        [AssetsMoneyCollectionViewCell registCell:_collectionView];
        [AssetsTotalCollectionViewCell registCell:_collectionView];
        [AssetsTotalProfitCollectionViewCell registCell:_collectionView];
        [AssetsYieldCurveCollectionViewCell registCell:_collectionView];
        [AssetsProfitRecordsCollectionViewCell registCell:_collectionView];
    }
    return _collectionView;
}


#pragma mark UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            size = [AssetsTotalCollectionViewCell cellSize];
        }else{
            size = [AssetsMoneyCollectionViewCell cellSize];
        }
    }else if (indexPath.section == 1){
        size = [AssetsTotalProfitCollectionViewCell cellSize];
    }else if (indexPath.section == 2){
        size = [AssetsProfitRecordsCollectionViewCell cellSize];
    }else if (indexPath.section == 3){
        size = [AssetsYieldCurveCollectionViewCell cellSize];
    }
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (section == 0) {
        edgeInsets = UIEdgeInsetsMake(0, 0, 13.0, 0);
    }else{
        edgeInsets = UIEdgeInsetsMake(0, 0, 9.0, 0);
    }
    return edgeInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat space = 1;

    return space;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [BalanceViewController pushToController:self];
        }
    }
    if (indexPath.section == 2) {
        [AssetsRecordViewController pushToController:self recordType:RecordTypeProfit];
    };
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == 0) {
        count = 3;
    }else if (section == 1){
        count = 4;
    }else if (section == 2){
        count = 1;
    }else if (section == 3){
        count = 1;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AssetsTotalCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
            [(AssetsTotalCollectionViewCell *)cell reloadTotalAsset:self.asset.total_asset yesterdayEarn:self.asset.yesterday_total_earn];
        }else{
            AssetsMoneyCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:[AssetsMoneyCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
            if (indexPath.row == 1) {
                [cell1 reloadData:@"余额" money:self.asset.balance_amount desc:@"点击查看"];
            }else if (indexPath.row == 2){
                [cell1 reloadData:@"理财资产" money:self.asset.total_finance_amount desc:@"请到理财栏查看详情"];
            }
            cell = cell1;
        }
    }else if (indexPath.section == 1){
        AssetsTotalProfitCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:[AssetsTotalProfitCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell1 reloadTitle:@"累计充值" desc:self.asset.total_recharge];
        }else if (indexPath.row == 1){
            [cell1 reloadTitle:@"累计收益" desc:self.asset.total_earn];
        }else if (indexPath.row == 2){
            [cell1 reloadTitle:@"累计提现" desc:self.asset.total_withdraw];
        }else if (indexPath.row == 3){
            [cell1 reloadTitle:@"累计奖励" desc:self.asset.bounty];
        }
        cell = cell1;
        
    }else if (indexPath.section == 2){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AssetsProfitRecordsCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    }else if (indexPath.section == 3){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AssetsYieldCurveCollectionViewCell reuseIdentifier] forIndexPath:indexPath];

        [(AssetsYieldCurveCollectionViewCell *)cell reloadTrend:self.earns];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 4;
}

#pragma mark - action
- (void)rightButtonClick:(UIButton *)sender
{
    [AssetsRecordViewController pushToController:self recordType:RecordTypeAessets];
}

- (void)requestData
{
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:2];
    [GTNetWorking getWithUrl:DOLPHIN_API_ASSET params:nil showLoginIfNeed:NO success:^(NSNumber *code, NSString *msg, id data) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        if ([code integerValue] == 200) {
            self.asset = [FinancailAsset yy_modelWithDictionary:data[@"asset"]];
            [self.earns removeAllObjects];
            NSArray<NSDictionary *> *trend = data[@"trend"];
            [trend enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                AssetEarn *earn = [AssetEarn yy_modelWithDictionary:obj];
                [self.earns addObject:earn];
            }];
            [self.collectionView reloadData];
        }else{
            [MBProgressHUD showTextAddToView:[UIApplication sharedApplication].keyWindow Title:msg andHideTime:2];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD showTextAddToView:[UIApplication sharedApplication].keyWindow Title:@"网络出错，请稍后再试！" andHideTime:2];
    }];
}

@end
