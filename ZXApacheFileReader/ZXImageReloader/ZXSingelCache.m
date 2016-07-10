//
//  ZXSingelCache.m
//  ZXImageDownLoader
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "ZXSingelCache.h"
static id instance = nil;
@implementation ZXSingelCache

+ (instancetype)sharedCache{
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    instance = [[ZXSingelCache alloc]init];
    
});
    return instance;

}
@end
