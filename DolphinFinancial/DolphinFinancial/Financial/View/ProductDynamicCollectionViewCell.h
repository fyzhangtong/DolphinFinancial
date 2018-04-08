//
//  ProductDynamicCollectionViewCell.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFProductDynamics;
/**
 产品动态
 */
@interface ProductDynamicCollectionViewCell : UICollectionViewCell


+ (CGSize)cellSize;
+ (NSString*)reuseIdentifier;
+ (void)registCell:(UICollectionView *) collectionView;

- (void)reloadProduct:(DFProductDynamics *)dynamic;

@end
