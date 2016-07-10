//
//  ZXImageReloader.h
//  ZXImageDownLoader
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^finish)(UIImage *img);
@interface ZXImageReloader : NSObject
//下载完毕的回调BLOCK
@property (nonatomic,copy)finish finish;
//读取图片
-(void)ImageWithUrl:(NSString *)url;

@property (nonatomic,strong)NSString *path;
//提供单例
+(instancetype)sharedReloader;
@end
