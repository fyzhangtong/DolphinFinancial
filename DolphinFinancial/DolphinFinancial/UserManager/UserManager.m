//
//  UserManager.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/28.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "UserManager.h"

#define USERMEMBERID @"USERMEMBERID"
#define USERTOKEN @"USERTOKEN"

@implementation UserManager

+ (void)setUseraToken:(NSString *)Token {
    NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
    NSData *userInfoData = [NSKeyedArchiver archivedDataWithRootObject:Token];
    [defaults setObject:userInfoData forKey:USERTOKEN];
}

+ (NSString *)userToken {
    NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
    NSData * userInfoData = [defaults objectForKey:USERTOKEN];
    NSString *userToken = [NSKeyedUnarchiver unarchiveObjectWithData:userInfoData];
    return userToken;
}

+ (void)removeUser
{
    NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:USERTOKEN];
    [defaults removeObjectForKey:USERMEMBERID];
    [defaults synchronize];
}


@end
