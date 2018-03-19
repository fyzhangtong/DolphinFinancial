//
//  AssetsYieldCurveCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AssetsYieldCurveCollectionViewCell.h"

@implementation AssetsYieldCurveCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (CGSize)cellSize
{
    return CGSizeMake(DFSCREENW, 176);
}
+ (NSString*)reuseIdentifier
{
    return NSStringFromClass([self class]);
}
+ (void)registCell:(UICollectionView *) collectionView
{
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:[self reuseIdentifier]];
}

@end
