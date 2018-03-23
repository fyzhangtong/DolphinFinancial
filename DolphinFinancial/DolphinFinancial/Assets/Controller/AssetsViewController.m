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
}

- (void)makeView
{
    [self setCenterTitle:@"资产"];
    [self setRightButtonImage:[UIImage imageNamed:@"assetsRecords"]];
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
        if (indexPath.row == 1 || indexPath.row == 2) {
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
        count = 5;
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
        }else{
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AssetsMoneyCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
        }
    }else if (indexPath.section == 1){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AssetsTotalProfitCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    }else if (indexPath.section == 2){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AssetsProfitRecordsCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    }else if (indexPath.section == 3){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AssetsYieldCurveCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
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

@end
