//
//  GTNetWorking.h
//  GeeTimerApp
//
//  Created by Mac on 16/10/17.
//  Copyright © 2016年 wwj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    
    StatusUnknown           = -1,  //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
    
}NetworkStatus;

typedef void( ^ GTResponseSuccess)(NSNumber *code,NSString *msg,id data);
typedef void( ^ GTResponseFail)(NSError *error);

typedef void( ^ GTUploadProgress)(int64_t bytesProgress,
                                  int64_t totalBytesProgress);

typedef void( ^ GTDownloadProgress)(int64_t bytesProgress,
                                    int64_t totalBytesProgress);



@interface GTNetWorking : NSObject

/**
 *  获取网络
 */
@property (nonatomic,assign)NetworkStatus networkStats;

/**
 *  单例
 *
 *
 */
+ (GTNetWorking *)sharedGTNetWorking;

/**
 *  开启网络监测
 */
+ (void)startMonitoring;

/**
 *  get请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 */
//   @param showHUD 是否显示HUD

+(void)getWithUrl:(NSString *)url
           params:(NSDictionary *)params
          success:(GTResponseSuccess)success
             fail:(GTResponseFail)fail;
/**
 *  get请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param showLoginIfNeed 如果未登录是否提示
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 */
//   @param showHUD 是否显示HUD

+(void)getWithUrl:(NSString *)url
           params:(NSDictionary *)params
  showLoginIfNeed:(BOOL)showLoginIfNeed
          success:(GTResponseSuccess)success
             fail:(GTResponseFail)fail;
/**
 *  post请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 */
//  showHUD 是否显示HUD

+(void)postWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(GTResponseSuccess)success
              fail:(GTResponseFail)fail;
/**
 *  post请求方法,block回调
 *
 *  @param url     请求连接，根路径
 *  @param params  参数
 *  @param header  请求头
 *  @param success 请求成功返回数据
 *  @param fail    请求失败
 */
+(void)postWithUrl:(NSString *)url
            params:(NSDictionary *)params
            header:(NSDictionary<NSString*,NSString*> *)header
           success:(GTResponseSuccess)success
              fail:(GTResponseFail)fail;
@end
