//
//  FinacialCollectionReusableView.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinacialCollectionReusableView : UICollectionReusableView

+ (CGSize)viewSize;
+ (NSString*)reuseIdentifier;
+ (void)registSectionHeader:(UICollectionView *) collectionView;

- (void)reloadTitle:(NSString *)title explain:(NSString *)explain;

@end
