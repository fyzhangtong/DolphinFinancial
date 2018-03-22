//
//  TargetAnnualRateOfReturnCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 目标年化收益率cell
 */
@interface TargetAnnualRateOfReturnCell : UICollectionViewCell


+ (CGSize)cellSize;
+ (NSString*)reuseIdentifier;
+ (void)registCell:(UICollectionView *) collectionView;

@end
