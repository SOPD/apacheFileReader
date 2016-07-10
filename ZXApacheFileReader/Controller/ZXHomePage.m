//
//  ZXHomePage.m
//  ZXApacheFileReader
//
//  Created by mac on 16/5/7.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "ZXHomePage.h"
#import "ZXPictureCell.h"
#import "ZXBigPictureController.h"
#import <SDWebImage/SDWebImageManager.h>
#import <MJRefresh/MJRefresh.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
#import <AVFoundation/AVFoundation.h>
#import "videoPlayerController.h"
#import <AVKit/AVKit.h>
#import "ZXSearchField.h"
#import "ZXBlackCircleBaseButton.h"
#import "UIImageView+ZXImageReloader.h"
#import "NetWorkTool.h"
#define ZX_COLOR(r,g,b,a)   [UIColor colorWithRed:r green:g blue:b alpha:a]

@interface ZXHomePage ()<UITextFieldDelegate,NSURLSessionDataDelegate>

@property (nonatomic,strong)NSMutableArray *shouldShowList;

@property(nonatomic,strong)ZXBigPictureController *bigVc;

@property(nonatomic,strong)UIImage *img;

@property(nonatomic,strong)SDWebImageManager *manager;

@property(nonatomic,assign)int count;

@property(nonatomic,assign)int downCount;

@property(nonatomic,strong)videoPlayerController *videoVC;

@property (nonatomic,strong)ZXSearchField *searchField;

@property (nonatomic,strong)NSMutableArray *showList;


@end

@implementation ZXHomePage

-(void)setShowList:(NSMutableArray *)showList{
    _showList=showList;
   [self.collectionView reloadData];

}

-(void)setShouldShowList:(NSMutableArray *)shouldShowList{
    _shouldShowList=shouldShowList;
    [self.collectionView reloadData];

}
-(SDWebImageManager *)manager{

    if (_manager==nil) {
        _manager=[SDWebImageManager sharedManager];
    }

    return _manager;
}



-(void)setCount:(int)count{
    _count=count;
    NSMutableArray *arr=[NSMutableArray array];
    if (self.shouldShowList.count>count) {
        for (int i=0; i<count; i++) {
            [arr addObject:self.shouldShowList[i]];
        }
    }else{
    
        for (int i=0; i<self.shouldShowList.count; i++) {
            [arr addObject:self.shouldShowList[i]];
            
        }
    
    }
  //  NSLog(@"%@",arr);
  
    self.showList=arr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlokc];
//    NSLog(@"%@,%@",self.view,self.collectionView);
    [self.collectionView registerClass:[ZXPictureCell class] forCellWithReuseIdentifier:@"picture_Cell"];
    self.shouldShowList= [NSMutableArray arrayWithArray:self.pictureUrlList ];
 
    
    UIButton *btn=[UIButton new];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.frame=CGRectMake(10, 20,40, 30);
    [btn setBackgroundColor:ZX_COLOR(0, 0, 0, 0.4)];
    
    //添加返回上一层按钮
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.count=15;
 //   NSLog(@"%@",self.showList);
    //设置数据源
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;

    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    //添加搜索框
    ZXSearchField *searchField=[[ZXSearchField alloc]init];
    searchField.frame=CGRectMake(btn.frame.origin.x+btn.frame.size.width+10, btn.frame.origin.y, 150, 30);
    [searchField setBackgroundColor:ZX_COLOR(0, 0, 0, 0.4)];
    searchField.textColor=[UIColor whiteColor];
    [self.view addSubview:searchField];
    [[ZXSearchField appearance]setTintColor:[UIColor whiteColor]];
    self.searchField=searchField;
    searchField.clearButtonMode=  UITextFieldViewModeAlways;
    
    [searchField addTarget:self action:@selector(searchFieldEditing) forControlEvents:UIControlEventEditingChanged];
    searchField.delegate=self;
    
    //添加搜索按钮
    UIButton *searchBtn=[UIButton new];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.frame=CGRectMake(searchField.frame.origin.x+searchField.frame.size.width+10, searchField.frame.origin.y,50, 30);
    [searchBtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    [self.view addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(searchBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
//    //添加底部控制栏按钮
//    ZXBlackCircleBaseButton *homeBtn= [[ZXBlackCircleBaseButton alloc]initWithRingColor:ZX_COLOR(218, 218, 218, 0.4) and:ZX_COLOR(14, 14, 14, 0.4)];
//    homeBtn.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height-70, 55, 55);
//    homeBtn.layer.cornerRadius=homeBtn.bounds.size.width/2;
//    homeBtn.layer.masksToBounds=YES;
//   homeBtn.backgroundColor=ZX_COLOR(0, 0, 0, 0.4);
//    [self.view addSubview:homeBtn];

}


//点选搜索按钮  搜索搜索框中的关键字
-(void)searchBtnDidClick{

    [self searchWihtType:@"i" Name:self.searchField.text];

    [self.searchField resignFirstResponder];
 
//

}
//搜索框被编辑时调用
//当搜索框为空的时候显示原始列表
-(void)searchFieldEditing{

    if ([self.searchField.text isEqual:@""]) {
        self.shouldShowList=[NSMutableArray arrayWithArray:self.pictureUrlList];
        self.count=self.count;
        [self.searchField resignFirstResponder];
    }
//       NSLog(@"editing");

}



#pragma mark searchList---
-(void)searchWihtType:(NSString *)type Name:(NSString *)name{

    //从pictureList中读取检索的目录 保存到shouldShowList中
    [self.shouldShowList removeAllObjects];
    NSMutableArray *tempList=[NSMutableArray array];
    for (ZXFileModel *model in self.pictureUrlList) {
        if ([model.fileType containsString:type]&&[model.fileName containsString:name]) {
            
            [tempList addObject:model];
        }
        
    }
    
    self.shouldShowList=tempList;
    self.count=15;

}



#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.showList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *ID=@"picture_Cell";

    ZXPictureCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.indexPath=indexPath;
    

    cell.imageVw.image=nil;
    
    NSString *url=self.baseUrl;
    
    cell.url=url;
    cell.model=self.shouldShowList[indexPath.row];
  
    cell.cellBlock=^(NSIndexPath * index,ZXPictureCell *cell){
        self.HomeBlock(index,cell);
    
    };
   
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"picture_Cell";
    ZXPictureCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
   ZXFileModel *model=self.showList[indexPath.row];
//    NSLog(@"%@",model.filePath);
    if ([model.fileType isEqualToString:@"image"]) {
        ZXBigPictureController *bigVw=[[ZXBigPictureController alloc]init];
        bigVw.holdPlace=[self.view convertRect:cell.frame fromView:self.collectionView];
        self.bigVc=bigVw;
        
        NSString *filePath= model.filePath;
        NSString *path=[NSString stringWithFormat:@"http://%@/%@",self.baseUrl,filePath];
        
        bigVw.imgUrl=path;
        
        [self.view addSubview:bigVw.view];
        bigVw.view.frame=[UIScreen mainScreen].bounds;
    }if ([model.fileType isEqualToString:@"file"]&&![self fileIsVideo:model.filePath]) {
        //使用WEBVIEW打开文档
 
        NSString *filePath= model.filePath;
        NSString *path=[NSString stringWithFormat:@"http://%@/%@",self.baseUrl,filePath];
       UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        NSString *url=[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        

        
        NSURL *URL=[NSURL URLWithString:url];
        
        NSURLRequest *request=[NSURLRequest requestWithURL:URL];
      
        [self.view addSubview:webView];
        
        
        UIButton *btn=[UIButton new];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        
        btn.frame=CGRectMake(10, 20,40, 40);
        [btn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
        //添加返回上一层按钮
        [webView addSubview:btn];
        [btn addTarget:self action:@selector(WebViewBack:) forControlEvents:UIControlEventTouchUpInside];
        [webView loadRequest:request];
        
    }if ([self fileIsVideo:model.filePath]) {
       //使用视频播放器打开视频
        NSString *filePath= model.filePath;
        NSString *path=[NSString stringWithFormat:@"http://%@/%@",self.baseUrl,filePath];
        NSURL *url=[NSURL URLWithString:[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
      
        self.videoVC=[videoPlayerController new];
        self.videoVC.videoUrl=url;
        [self.view addSubview:self.videoVC.mpC.view];
        
        
        
        
    }
 

  }


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchField resignFirstResponder];
//    NSLog(@"%f,%f",scrollView.contentOffset.y,((self.count/3-4)*[UIScreen mainScreen].bounds.size.height/4));
    CGFloat slide=((self.count/3-4)*[UIScreen mainScreen].bounds.size.height/4);
    if (scrollView.contentOffset.y>slide) {
        
        NSLog(@"shuaxin");
     
        self.count=self.count+6;
    }

}


-(void)WebViewBack:(UIButton *)sender{
    [sender.superview removeFromSuperview];
    
}


/**
 *  关闭Home
 */
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 判断文件是否为视频
 支持格式
 mov m4v mp4  avi
 */
-(BOOL)fileIsVideo:(NSString *)fileName{
    //设为非视频
    BOOL isVideo=NO;
    
    //视频类型列表
    NSArray *videoTypeList=@[@"mov",@"m4v",@"mp4",@"avi",@"AVI",@"MP4",@"M4V",@"MOV"];
    
    //遍历视频列表 判断每个文件是否是视频
    for (NSString *type in videoTypeList) {
        if ([fileName containsString:type]) {
            isVideo=YES;
            
        }
    }
    return isVideo;

}

/**
 *  屏幕旋转(暂时取消)
 *
 *  @param size        屏幕尺寸
 *  @param coordinator
 */
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
//    NSLog(@"%@",NSStringFromCGSize(size));
 
    UICollectionViewFlowLayout *flowLayout=[UICollectionViewFlowLayout new];
    //设置item布局
    flowLayout.minimumLineSpacing=1;
    flowLayout.minimumInteritemSpacing=1;
    CGFloat imgW=size.width/3-1;
    CGFloat imgH=size.height/4-1;
    flowLayout.itemSize=CGSizeMake(imgW, imgH);
    [self.collectionView setCollectionViewLayout:flowLayout animated:YES ];
    for (UIView *view in self.collectionView.subviews) {
        [view removeFromSuperview];
        }
    [self.collectionView reloadData];
  
}

/**
 *  设定CELL长按调用的Block
 */
-(void)setBlokc{

           //弱引用防止循环引用
          __weak ZXHomePage *weakSelf=self;
    
  self.HomeBlock=^(NSIndexPath *index,ZXPictureCell *cell){
      
      //判断如果该cell所指的链接是图片
        if ([cell.model.fileType isEqualToString:@"image"]) {
            
            //添加保存图片选项
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"保存这张图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
     
      
            //保存图片
            UIAlertAction *action=[UIAlertAction actionWithTitle:@"保存" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //拼接完整地址
                NSString *baseUrl=cell.url;
                NSString *path=cell.model.filePath;
                NSString *url=[NSString stringWithFormat:@"http://%@/%@",baseUrl,path];
                
                //下载图片
                [weakSelf downLoadImage:url];
                
            }];
            
            
            //取消选项
            UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            //添加两个选项
            [alert addAction:action];
            [alert addAction:action2];
            
            
            //      显示AlertView
            [weakSelf presentViewController:alert animated:YES completion:nil];
            
        };
        
    };
}

/**
 *  下载图片
 *
 *  @param imgUrl 图片地址
 */
-(void)downLoadImage:(NSString *)imgUrl{
    NSLog(@"%@",imgUrl);
    
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:[imgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    }  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        //下载完成后保存到手机相册
        UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
        
    }];
    
    
    
    
}


-(void)downLoadMusic:(NSString *)musUrl{
    NSLog(@"%@",musUrl);
    
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url=[NSURL URLWithString:musUrl];
    
    NSURLSessionDownloadTask *task= [session downloadTaskWithURL:url];
    
    [task resume];
    

    
    
    
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *cachesDir = [paths objectAtIndex:0];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSString *name = [[location lastPathComponent] stringByDeletingPathExtension];
    
        [fileManager copyItemAtPath:location.path toPath:[NSString  stringWithFormat:@"%@/%@.mp3",cachesDir,name]error:nil];

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    if (error != NULL)
    {
        // Show error message...
        
    }
    else  // No errors
    {
        
    }
}
@end
