//
//  NetWorkTool.h
//  ZXApacheFileReader
//
//  Created by mac on 16/5/7.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetWorkTool : AFHTTPSessionManager
+(instancetype)sharedToolWithBaseUrl:(NSURL *)baseUrl;
@end
