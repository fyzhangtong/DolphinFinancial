//
//  AssetsProfitRecordsCollectionViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 收益记录
 */
@interface AssetsProfitRecordsCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSize;
+ (NSString*)reuseIdentifier;
+ (void)registCell:(UICollectionView *) collectionView;

@end
