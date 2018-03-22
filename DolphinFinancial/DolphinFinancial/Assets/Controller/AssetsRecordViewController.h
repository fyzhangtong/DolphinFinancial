//
//  AssetsRecordViewController.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/22.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    RecordTypeAessets = 0,      //资产记录
    RecordTypeProfit = 1        //收益记录
}RecordType;

@interface AssetsRecordViewController : BaseViewController

+ (void)pushToController:(UIViewController *)controller recordType:(RecordType)recordType;

@end
