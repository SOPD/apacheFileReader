//
//  ZXPictureCell.m
//  ZXApacheFileReader
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "ZXPictureCell.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking/AFImageDownloader.h>
#import "UIImage+changeSize.h"
#import "UIImageView+ZXImageReloader.h"
@interface ZXPictureCell()

@property (nonatomic,strong)UILabel *lbl;

@end

@implementation ZXPictureCell


-(void)setModel:(ZXFileModel *)model{
    _model=model;
    
    
//    NSString *filePath= model.previewPath;
    NSString *filePath = model.previewPath;
    NSString *baseUrl=self.url;
    NSString *path=[NSString stringWithFormat:@"http://%@/%@",baseUrl,filePath];
    NSURL *URL=[NSURL URLWithString:[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    //设置同时最大下载数为15
//    
//    [SDWebImageManager sharedManager].imageDownloader.maxConcurrentDownloads=20;
//    [[SDWebImageManager sharedManager]downloadImageWithURL:URL options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//    
//        
//    }  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//       
//        self.imageVw.image=image;
//        
//        
//    }];
 //   [self.imageVw sd_setImageWithURL:URL];
    [self.imageVw ImageWithUrl:[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    self.lbl.text=model.fileName;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor=[UIColor blackColor];
        UILabel *lbl=[UILabel new];
          [self.contentView addSubview:lbl];
        self.lbl=lbl;
        self.lbl.textColor=[UIColor whiteColor];
        self.lbl.frame=self.bounds;
        self.lbl.textAlignment=NSTextAlignmentCenter;
        //添加图片框
        UIImageView *imgVw=[UIImageView new];
        [self.contentView addSubview:imgVw];
        self.imageVw=imgVw;
        self.imageVw.frame=self.bounds;
        [self.imageVw setBackgroundColor:[UIColor clearColor]];
        self.imageVw.contentMode=UIViewContentModeScaleAspectFill;
        
        self.imageVw.clipsToBounds=YES;
        
        self.imageVw.frame=self.bounds;
      
    
        
        //添加长按事件
        UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

-(void)longPress:(ZXPictureCell *)sender{

    //长按执行回调
    self.cellBlock(self.indexPath,self);
}

//- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    // 返回新的改变大小后的图片
//    return scaledImage;
//}
@end
