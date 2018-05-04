//
//  GTNetWorking.m
//  GeeTimerApp
//
//  Created by Mac on 16/10/17.
//  Copyright © 2016年 wwj. All rights reserved.
//

#import "GTNetWorking.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "LoginViewController.h"
#import "UserManager.h"

@implementation GTNetWorking

+ (GTNetWorking *)sharedGTNetWorking
{
    static GTNetWorking *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[GTNetWorking alloc] init];
    });
    return handler;
}

+(void)getWithUrl:(NSString *)url
           params:(NSDictionary *)params
  showLoginIfNeed:(BOOL)showLoginIfNeed
          success:(GTResponseSuccess)success
             fail:(GTResponseFail)fail{
    [self baseRequestType:1 url:url params:params header:nil showLoginIfNeed:showLoginIfNeed success:success fail:fail];
}

+(void)postWithUrl:(NSString *)url
            params:(NSDictionary *)params
            header:(NSDictionary<NSString*,NSString*> *)header
   showLoginIfNeed:(BOOL)showLoginIfNeed
           success:(GTResponseSuccess)success
              fail:(GTResponseFail)fail{
    
    [self baseRequestType:2 url:url params:params header:header showLoginIfNeed:showLoginIfNeed success:success fail:fail];
}

+(void)baseRequestType:(NSUInteger)type
                   url:(NSString *)url
                params:(NSDictionary *)params
                header:(NSDictionary<NSString*,NSString*> *)header
       showLoginIfNeed:(BOOL)showLoginIfNeed
               success:(GTResponseSuccess)success
                  fail:(GTResponseFail)fail{
    if (url==nil) {
        return ;
    }
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    [header enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    void (^progressBlock)(NSProgress * _Nonnull downloadProgress) = ^(NSProgress * _Nonnull downloadProgress) {
        
    };
    void(^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);
    void (^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
    failureBlock = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error*****\n%@",error);
        NSLog(@"error.userInfo*****\n%@",error.userInfo);
        if (error.code == 1001) {
            [UserManager removeUser];
            if (showLoginIfNeed) {
                [LoginViewController loginWithComplete:^(BOOL landSuccess) {
                    if (landSuccess) {
                        [GTNetWorking baseRequestType:type url:url params:params header:header showLoginIfNeed:NO success:success fail:fail];
                    }else{
                        if (fail) {
                            NSError *error = [NSError errorWithDomain:@"登录失败" code:1001 userInfo:@{ NSLocalizedDescriptionKey : @"登录失败" }];
                            fail(error);
                        }
                    }
                }];
            }else{
                if (fail) {
                    fail(error);
                }
            }
        }else{
            if (fail) {
                fail(error);
            }
        }
        
    };
    successBlock = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject********** \n%@",responseObject);
        NSDictionary *dic = responseObject;
        NSNumber *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        id data = dic[@"data"];
        if ([code integerValue] == 1001) {
            [UserManager removeUser];
            if (showLoginIfNeed) {
                [LoginViewController loginWithComplete:^(BOOL landSuccess) {
                    if (landSuccess) {
                        [GTNetWorking baseRequestType:type url:url params:params header:header showLoginIfNeed:NO success:success fail:fail];
                    }else{
                        if (fail) {
                            NSError *error = [NSError errorWithDomain:@"登录失败" code:1001 userInfo:@{ NSLocalizedDescriptionKey : @"登录失败" }];
                            fail(error);
                        }
                    }
                }];
            }else{
                if (success) {
                    success(code,msg,data);
                }
            }
        }else{
            if (success) {
                success(code,msg,data);
            }
        }
    };
    NSLog(@"\nurl:%@\nparams:%@",urlStr,params);
    
    if (type==1) {
        [manager GET:urlStr parameters:params progress:progressBlock success:successBlock failure:failureBlock];
    }else{
        [manager POST:urlStr parameters:params progress:progressBlock success:successBlock failure:failureBlock];
    }
}

#pragma makr - 开始监听网络连接

+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                [GTNetWorking sharedGTNetWorking].networkStats=StatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [GTNetWorking sharedGTNetWorking].networkStats=StatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                [GTNetWorking sharedGTNetWorking].networkStats=StatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                
                [GTNetWorking sharedGTNetWorking].networkStats=StatusReachableViaWiFi;
                break;
        }
    }];
    [mgr startMonitoring];
}


+(NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
+(AFHTTPSessionManager *)getAFManager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    //设置https连接暂无证书校验模式：
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    if ([UserManager userToken].length) {
        [manager.requestSerializer setValue:[UserManager userToken] forHTTPHeaderField:@"token"];
    }
    /*
    NSString *appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *versionCode = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSNumber *buildCode = [NSNumber numberWithInteger:[versionCode integerValue]];
    NSString *cookieValue = [NSString stringWithFormat:@"token=%@;os=%@;appVersion=%@;versionCode=%@", [UserManager userToken], @"1",appVersion,buildCode];
    [manager.requestSerializer setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    */
    return manager;
}


@end
