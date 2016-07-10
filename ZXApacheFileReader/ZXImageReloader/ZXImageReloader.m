//
//  ZXImageReloader.m
//  ZXImageDownLoader
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//


//缓存全部在cache文件夹中 清理软件缓存的时候 就都清掉了
//#define ZX_LOCOL_CACHE_LIST @"/Users/mac/Desktop/ImgReloaderCache.plist"

//缩放图片最大边长
#define MAX_SIZE 700

//内存缓存
#define MAX_CACHE 20


#import "ZXImageReloader.h"
#import "ZXSingelCache.h"
@interface ZXImageReloader() <NSURLSessionDataDelegate>
//磁盘缓存列表
@property (nonatomic,strong)NSMutableDictionary *diskCache;

//等待加载
@property (nonatomic,strong)NSMutableArray *waitingList;

//下载状态记录
@property (nonatomic,assign)BOOL isDownloading;

//当前下载文件地址
@property (nonatomic,copy)NSString *currentUrl;

//内存缓存
@property (nonatomic,strong)ZXSingelCache *MemCache;

@end

@implementation ZXImageReloader


-(NSCache *)MemCache{

    if (_MemCache == nil) {
        //获取单例内存缓存
        _MemCache  = [ZXSingelCache sharedCache];
        _MemCache.totalCostLimit = MAX_CACHE;
    }
    return _MemCache;

}
-(NSMutableDictionary *)diskCache{
    if (_diskCache==nil) {
        //磁盘缓存列表  从磁盘中加载
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesDir = [paths objectAtIndex:0];
        _diskCache=[NSMutableDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/ImgReloaderCache.plist",cachesDir]];
        if (_diskCache==nil) {
            _diskCache=[NSMutableDictionary dictionary];
        }
    }
    return  _diskCache;
}
-(NSMutableArray *)waitingList{
    if (_waitingList==nil) {
        //等待下载列表
        _waitingList=[NSMutableArray array];
    }
    return  _waitingList;
}

-(instancetype)init{
    if (self=[super init]) {
        //当任务下载中不开启其他下载任务
        self.isDownloading=NO;
    }
    return self;
}
-(void)ImageWithUrl:(NSString *)urlStr{
    [self.waitingList addObject:urlStr];

//尝试从内存中加载
    UIImage *img = [self.MemCache objectForKey:urlStr];
    if (img != nil) {
        self.finish(img);
        return;
    }
    
    //尝试从磁盘中加载图片
    NSString *paht=[self.diskCache valueForKey:urlStr];
    img=[UIImage imageWithContentsOfFile:paht];
        if (img!=nil) {
            CGFloat w = img.size.width;
            CGFloat h = img.size.height;
            
            if (img.size.width >= MAX_SIZE) {
                img = [self resize:img size:CGSizeMake(MAX_SIZE,(MAX_SIZE / w) * h)];
                if (img.size.height >= MAX_SIZE) {
                    img = [self resize:img size:CGSizeMake((h / MAX_SIZE) * w,MAX_SIZE)];
                }
            }
            
    [self.MemCache setObject:img forKey:self.currentUrl];

            self.finish(img);
            //   self.path = paht;
            //若加载到图片则直接调用回调并返回
            return;
        }
          //  没有从本地加载到图片则开始从网络下载图片
        if (!self.isDownloading&&img==nil) {
            
            NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
            
            NSURL *url=[NSURL URLWithString:urlStr];
            
            NSURLSessionDownloadTask *task= [session downloadTaskWithURL:url];
            
            [task resume];
            //设置下载中状态
            self.isDownloading=YES;
            //暂存当前下载中的地址
            self.currentUrl=urlStr;
        }
    


 
    
}

//下载完成后调用
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    //NSLog(@"%@",downloadTask);
    
    //获取cache目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *cachesDir = [paths objectAtIndex:0];
    
    //使用fileManager将下载的文件拷贝出来
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    //指定名称为系统给下载文件赋值的默认名称
    NSString *name = [[location lastPathComponent] stringByDeletingPathExtension];
    
  
    //将下载的图片本地保存 统一保存为JPG
    [fileManager copyItemAtPath:location.path toPath:[NSString  stringWithFormat:@"%@/%@.jpg",cachesDir,name]error:nil];
    
    //下载完成后加入到本地缓存列表
    [self.diskCache setValue:[NSString  stringWithFormat:@"%@/%@.jpg",cachesDir,name] forKey:self.currentUrl];
    
    //将本地缓存列表写入到文件中归档
    [self.diskCache writeToFile:[NSString stringWithFormat:@"%@/ImgReloaderCache.plist",cachesDir ] atomically:YES];
    NSLog(@"%@",cachesDir);
    
    
   
    
    //设置下载中状态为NO
    self.isDownloading=NO;
    
    //判断如果当前下载完成的图片是最后一个加入到等待列表的图片
    if (self.currentUrl!=self.waitingList.lastObject) {
        //若不是则用列表中最后一个任务重新调用下载方法
        [self ImageWithUrl:self.waitingList.lastObject];
    }else{
        //若是最后一个则调用回调方法
    UIImage *img=[UIImage imageWithContentsOfFile:[NSString  stringWithFormat:@"%@/%@.jpg",cachesDir,name]];

        CGFloat w = img.size.width;
        CGFloat h = img.size.height;
        
        
        

        if (img.size.width >= MAX_SIZE) {
            img = [self resize:img size:CGSizeMake(MAX_SIZE,(MAX_SIZE / w) * h)];
            if (img.size.height >= MAX_SIZE) {
                     img = [self resize:img size:CGSizeMake((h / MAX_SIZE) * w,MAX_SIZE)];
            }
        }
        
        //加入内存缓存
        [self.MemCache setObject:img forKey:self.currentUrl];
        
        self.finish(img);
    
        //清空等待列表
        [self.waitingList removeAllObjects];
    }
   }

//单例方法
id instance;
+(instancetype)sharedReloader{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
     instance = [[self alloc]init];
        
    });

    return instance;
}

- (UIImage *)resize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


@end
