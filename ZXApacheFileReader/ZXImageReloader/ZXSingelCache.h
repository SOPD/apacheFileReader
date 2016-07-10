//
//  ZXSingelCache.h
//  ZXImageDownLoader
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXSingelCache : NSCache
+ (instancetype)sharedCache;
@end
