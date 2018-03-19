//
//  AssetsTotalProfitCollectionViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 累计充值，累计收益，累计体现
 */
@interface AssetsTotalProfitCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSize;
+ (NSString*)reuseIdentifier;
+ (void)registCell:(UICollectionView *) collectionView;

@end
