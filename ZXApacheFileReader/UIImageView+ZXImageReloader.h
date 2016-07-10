//
//  UIImageView+ZXImageReloader.h
//  ZXImageDownLoader
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXImageReloader.h"
#import <objc/runtime.h>
@interface UIImageView (ZXImageReloader)// <NSURLSessionDownloadDelegate>

@property (nonatomic,strong)ZXImageReloader *reloader;
-(void)ImageWithUrl:(NSString *)url;
@end
