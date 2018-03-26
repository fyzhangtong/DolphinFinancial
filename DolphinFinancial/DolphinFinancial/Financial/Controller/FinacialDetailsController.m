//
//  FinacialDetailsController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "FinacialDetailsController.h"

#import "TargetAnnualRateOfReturnCell.h"
#import "FinacialExplainCollectionViewCell.h"
#import "ProductDynamicCollectionViewCell.h"
#import "FinacialCollectionReusableView.h"
#import "UIImage+ImageWithColor.h"

@interface FinacialDetailsController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *bottomBGView;
@property (nonatomic, strong) UIButton *moveIntoButton;

@end

@implementation FinacialDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
}

- (void)makeView
{
    [self setCenterTitle:@"一月定存"];
    self.ownNavigationBarLine.hidden = YES;
    [self addLeftBackButton];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomBGView];
    
    //底部试图
    [_bottomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(DFTABBARBOTTOMHEIGHT+45);//一行14字号的高度+上下边距为5+线
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomBGView.mas_top);
    }];
    
    [self.view addSubview:self.moveIntoButton];
    [self.moveIntoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomBGView.mas_top).mas_offset(8);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.height.mas_equalTo(30);
    }];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, DFNAVIGATIONBARHEIGHT, DFSCREENW, DFSCREENH - DFNAVIGATIONBARHEIGHT) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = DFColorWithHexString(@"#F8F8F8");
        _collectionView.alwaysBounceVertical = YES;
        
        [TargetAnnualRateOfReturnCell registCell:_collectionView];
        [FinacialExplainCollectionViewCell registCell:_collectionView];
        [ProductDynamicCollectionViewCell registCell:_collectionView];
        [FinacialCollectionReusableView registSectionHeader:_collectionView];
    }
    return _collectionView;
}
- (UIView *)bottomBGView
{
    if (!_bottomBGView) {
        _bottomBGView = [UIView new];
        [_bottomBGView setBackgroundColor:[UIColor whiteColor]];
    }
    return _bottomBGView;
}
- (UIButton *)moveIntoButton
{

    if (!_moveIntoButton) {
        _moveIntoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moveIntoButton setTitle:@"转入" forState:UIControlStateNormal];
        _moveIntoButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_moveIntoButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_moveIntoButton setTitleColor:DFTINTCOLOR forState:UIControlStateNormal];
        _moveIntoButton.layer.borderWidth = 1;
        _moveIntoButton.layer.cornerRadius = 4;
        _moveIntoButton.layer.masksToBounds = YES;
        _moveIntoButton.enabled = NO;
        _moveIntoButton.layer.borderColor = DFTINTCOLOR.CGColor;
        [_moveIntoButton addTarget:self action:@selector(moveInoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _moveIntoButton;
}


#pragma mark UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    if (indexPath.section == 0) {
        size = [TargetAnnualRateOfReturnCell cellSize];
    }else if (indexPath.section == 1){
        size = [FinacialExplainCollectionViewCell cellSize];
    }else if (indexPath.section == 2){
        size = [ProductDynamicCollectionViewCell cellSize];
    }
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (section == 0) {
        edgeInsets = UIEdgeInsetsMake(0, 0, 7, 0);
    }else{
        edgeInsets = UIEdgeInsetsMake(0, 0, 9.0, 0);
    }
    return edgeInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    CGFloat space = 1;
    if (section == 1) {
        space = 0;
    }
    return space;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat space = 1;
//    if (section == 1) {
//        space = 0;
//    }
    return space;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"**%ld,%ld",indexPath.section,indexPath.row);
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == 0) {
        count = 1;
    }else if (section == 1){
        count = 3;
    }else if (section == 2){
        count = 2;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TargetAnnualRateOfReturnCell reuseIdentifier] forIndexPath:indexPath];
    }else if (indexPath.section == 1){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FinacialExplainCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    }else if (indexPath.section == 2){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ProductDynamicCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    }
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FinacialCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[FinacialCollectionReusableView reuseIdentifier] forIndexPath:indexPath];
    if (indexPath.section == 1) {
        [headerView reloadTitle:@"产品描述" explain:@""];
    }else if (indexPath.section == 2){
        [headerView reloadTitle:@"产品动态" explain:@"共29,183,726位借款人"];
    }
    return headerView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeZero;
    if (section == 1 || section == 2) {
        size = [FinacialCollectionReusableView viewSize];
    }
    return size;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 4;
}

#pragma mark - action

- (void)moveInoButtonClick:(UIButton *)sender
{
    
}


@end