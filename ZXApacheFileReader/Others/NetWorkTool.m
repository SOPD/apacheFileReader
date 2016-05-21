//
//  NetWorkTool.m
//  ZXApacheFileReader
//
//  Created by mac on 16/5/7.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "NetWorkTool.h"

@implementation NetWorkTool
static id instance;
+(instancetype)sharedToolWithBaseUrl:(NSURL *)baseUrl{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *confg=[NSURLSessionConfiguration defaultSessionConfiguration];
        [confg setTimeoutIntervalForRequest:15.0];
        [confg setTimeoutIntervalForResource:15.0];
        instance=[[NetWorkTool alloc]initWithBaseURL:baseUrl sessionConfiguration:confg];
    
    });

    return instance;

}
@end
