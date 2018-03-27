//
//  MemberDetailsViewController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/26.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "MemberDetailsViewController.h"

#import "MemberDetailsMyLevelCollectionViewCell.h"
#import "MemberDetailsLevelRuleCollectionViewCell.h"
#import "MemberDetailsLevelOrPriceCollectionViewCell.h"
#import "MemberDetailsLevelExplainCollectionViewCell.h"

@interface MemberDetailsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

{
    NSArray *_dataSource1;
    
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MemberDetailsViewController

+ (void)pushToController:(UIViewController *)controller
{
    MemberDetailsViewController *vc = [[MemberDetailsViewController alloc] init];
    [controller.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource1 = @[@"会员等级",@"在线金额",@"余额收益奖励",@"普通会员",@"￥0.00",@"0.00%",@"一级会员",@"￥2,000.00",@"2.00%",@"二级会员",@"￥4,000.00",@"3.00%"];
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"会员详情"];
    [self addLeftBackButton];
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
        
        [MemberDetailsMyLevelCollectionViewCell registerCell:_collectionView];
        [MemberDetailsLevelRuleCollectionViewCell registerCell:_collectionView];
        [MemberDetailsLevelOrPriceCollectionViewCell registerCell:_collectionView];
        [MemberDetailsLevelExplainCollectionViewCell registerCell:_collectionView];
    }
    return _collectionView;
}


#pragma mark UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    if (indexPath.section == 0) {
        size = [MemberDetailsMyLevelCollectionViewCell cellSize];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            size = [MemberDetailsLevelRuleCollectionViewCell cellSize];
        }else{
            size = [MemberDetailsLevelOrPriceCollectionViewCell cellSize];
        }
    }else if (indexPath.section == 2){
        size = [MemberDetailsLevelExplainCollectionViewCell cellSize];
    }
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (section == 0) {
        edgeInsets = UIEdgeInsetsMake(0, 0, 10.0, 0);
    }else if(section == 1){
        edgeInsets = UIEdgeInsetsMake(0, 0, 9.0, 0);
    }else if (section == 2){
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
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 1;
    if (section == 1) {
        count = 13;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MemberDetailsMyLevelCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MemberDetailsLevelRuleCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
        }else{
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MemberDetailsLevelOrPriceCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
            NSString *text = _dataSource1[indexPath.row-1];
            UIColor *color = DFColorWithHexString(@"#101010") ;
            if (indexPath.row == 4 || indexPath.row == 7 || indexPath.row == 10) {
                color = DFTINTCOLOR;
            }
            [((MemberDetailsLevelOrPriceCollectionViewCell *)cell) reloadData:text color:color];
        }
    }else if (indexPath.section == 2){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MemberDetailsLevelExplainCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    
    }
    
    return cell;
}

@end
