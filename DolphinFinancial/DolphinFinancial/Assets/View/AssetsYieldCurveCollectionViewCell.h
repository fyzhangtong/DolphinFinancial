//
//  AssetsYieldCurveCollectionViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AssetEarn;

/**
 收益曲线
 */
@interface AssetsYieldCurveCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSize;
+ (NSString*)reuseIdentifier;
+ (void)registCell:(UICollectionView *) collectionView;

- (void)reloadTrend:(NSArray<AssetEarn *> *)trend;

@end
