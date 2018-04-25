//
//  AssetsCollectionViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 余额，奖励金，理财资产
 */
@interface AssetsMoneyCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSize;
+ (NSString*)reuseIdentifier;
+ (void)registCell:(UICollectionView *) collectionView;

- (void)reloadData:(NSString *)title money:(NSString *)money desc:(NSString *)desc;

@end
