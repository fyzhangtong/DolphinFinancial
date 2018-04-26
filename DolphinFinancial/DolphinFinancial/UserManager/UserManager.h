//
//  UserManager.h
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/28.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

+ (NSString *)userToken;
+ (void)removeUser;
+ (void)setUseraToken:(NSString *)Token;

@end
