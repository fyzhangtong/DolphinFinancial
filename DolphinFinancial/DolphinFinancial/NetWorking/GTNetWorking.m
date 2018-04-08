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
          success:(GTResponseSuccess)success
             fail:(GTResponseFail)fail{
    
    return [self baseRequestType:1 url:url params:params showLoginIfNeed:YES success:success fail:fail];
}
+(void)getWithUrl:(NSString *)url
           params:(NSDictionary *)params
  showLoginIfNeed:(BOOL)showLoginIfNeed
          success:(GTResponseSuccess)success
             fail:(GTResponseFail)fail{
    [self baseRequestType:1 url:url params:params showLoginIfNeed:showLoginIfNeed success:success fail:fail];
}

+(void)postWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(GTResponseSuccess)success
              fail:(GTResponseFail)fail{
    
    [self baseRequestType:2 url:url params:params showLoginIfNeed:YES success:success fail:fail];
}

+(void)baseRequestType:(NSUInteger)type
                   url:(NSString *)url
                params:(NSDictionary *)params
       showLoginIfNeed:(BOOL)showLoginIfNeed
               success:(GTResponseSuccess)success
                  fail:(GTResponseFail)fail{
    if (url==nil) {
        return ;
    }
//    NSMutableDictionary*dic =[NSMutableDictionary dictionary];
//    [dic addEntriesFromDictionary:params];
//    NSString *token = [UserManager userToken];
//    if (token.length>0) {
//        [dic setObject:token forKey:@"token"];
//    }
//    NSLog(@"url:%@;params:%@",url,dic);
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    
    AFHTTPSessionManager *manager=[self getAFManager];
    
    void (^progressBlock)(NSProgress * _Nonnull downloadProgress) = ^(NSProgress * _Nonnull downloadProgress) {
        
    };
    void(^failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);
    void (^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
    failureBlock = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    };
    successBlock = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        id data = dic[@"data"];
        success(code,msg,data);
    };
    
    if (type==1) {
        [manager GET:urlStr parameters:params progress:progressBlock success:successBlock failure:failureBlock];
    }else{
        [manager POST:urlStr parameters:params progress:progressBlock success:successBlock failure:failureBlock];
    }
}

+(void)uploadWithImage:(UIImage *)image
                   url:(NSString *)url
              filename:(NSString *)filename
                  name:(NSString *)name
                params:(NSDictionary *)params
              progress:(GTUploadProgress)progress
               success:(GTResponseSuccess)success
                  fail:(GTResponseFail)fail
               showHUD:(BOOL)showHUD{
    
    if (url==nil) {
        return ;
    }
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    AFHTTPSessionManager *manager=[self getAFManager];
    
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dic = responseObject;
            NSNumber *code = dic[@"code"];
            NSString *msg = dic[@"msg"];
            id data = dic[@"data"];
            success(code,msg,data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)downloadWithUrl:(NSString *)url
             saveToPath:(NSString *)saveToPath
               progress:(GTDownloadProgress)progressBlock
                success:(GTResponseSuccess)success
                failure:(GTResponseFail)fail
                showHUD:(BOOL)showHUD{
    if (url==nil) {
        return ;
    }
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self getAFManager];
    
    [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            return [NSURL fileURLWithPath:saveToPath];
            
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error == nil) {
            if (success) {
                success(@(200),@"成功",filePath);//返回完整路径
            }
        } else {
            if (fail) {
                fail(error);
            }
        }
    }];
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
