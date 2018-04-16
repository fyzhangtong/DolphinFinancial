//
//  AssetsTotalCollectionViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 总资产，昨日收益
 */
@interface AssetsTotalCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSize;
+ (NSString*)reuseIdentifier;
+ (void)registCell:(UICollectionView *) collectionView;

- (void)reloadTotalAsset:(NSString *)totalAsset yesterdayEarn:(NSString *)yesterdayEarn;

@end
