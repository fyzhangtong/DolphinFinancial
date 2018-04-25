//
//  AssetsViewController.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/16.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseViewController.h"

#import "FinancailAsset.h"
#import "AssetEarn.h"

@interface AssetsViewController : BaseViewController

@property (nonatomic, strong) FinancailAsset *asset;
@property (nonatomic, strong) NSMutableArray<AssetEarn *> *earns;
+ (void)requestData:(void(^)(FinancailAsset *asset,NSMutableArray<AssetEarn *> *earns,BOOL success))complete;

@end
