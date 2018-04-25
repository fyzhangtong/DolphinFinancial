//
//  DFNotice.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/4/2.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFNotice : NSObject

/**
 公告ID
 */
@property (nonatomic, copy) NSNumber *id;
/**
 公告标题
 */
@property (nonatomic, copy) NSString *title;
/**
 公告内容
 */
@property (nonatomic, copy) NSString *content;
/**
 公告发布时间
 */
@property (nonatomic, copy) NSString *publish_time;


@end

