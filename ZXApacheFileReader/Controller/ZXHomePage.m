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


@interface ZXHomePage ()<UITextFieldDelegate>

@property (nonatomic,strong)NSMutableArray *shouldShowList;

@property(nonatomic,strong)ZXBigPictureController *bigVc;

@property(nonatomic,strong)UIImage *img;

@property(nonatomic,strong)SDWebImageManager *manager;

@property(nonatomic,assign)int count;

@property(nonatomic,assign)int downCount;
@property(nonatomic,strong)videoPlayerController *videoVC;

@property (nonatomic,strong)ZXSearchField *searchField;


@end

@implementation ZXHomePage

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
    if (self.pictureUrlList.count>count) {
        for (int i=0; i<count; i++) {
            [arr addObject:self.pictureUrlList[i]];
        }
    }else{
    
        for (int i=0; i<self.pictureUrlList.count; i++) {
            [arr addObject:self.pictureUrlList[i]];
            
        }
    
    }
  
    self.shouldShowList=arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn=[UIButton new];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.frame=CGRectMake(10, 20,40, 30);
    [btn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    
    //添加返回上一层按钮
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.count=30;
    //设置数据源
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;

    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    //添加搜索框
    ZXSearchField *searchField=[[ZXSearchField alloc]init];
    searchField.frame=CGRectMake(btn.frame.origin.x+btn.frame.size.width+10, btn.frame.origin.y, 150, 30);
    [searchField setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4]];
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
        self.count=self.count;
        [self.searchField resignFirstResponder];
    }
//       NSLog(@"editing");

}




-(void)searchWihtType:(NSString *)type Name:(NSString *)name{

    [self.shouldShowList removeAllObjects];
    NSMutableArray *tempList=[NSMutableArray array];
    for (ZXFileModel *model in self.pictureUrlList) {
        if ([model.fileType containsString:type]&&[model.fileName containsString:name]) {
            
            [tempList addObject:model];
        }
        
    }
    self.shouldShowList=tempList;

}

-(void)textFieldDidEndEditing:(UITextField *)textField{
   


}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.shouldShowList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *ID=@"picture_Cell";
 
    [collectionView registerClass:[ZXPictureCell class] forCellWithReuseIdentifier:ID];
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
   ZXFileModel *model=self.shouldShowList[indexPath.row];
    NSLog(@"%@",model.filePath);
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
        NSString *url=[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        

        
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
        NSURL *url=[NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
      
        self.videoVC=[videoPlayerController new];
        self.videoVC.videoUrl=url;
        [self.view addSubview:self.videoVC.mpC.view];
//        AVPlayerViewController *pVC = [AVPlayerViewController new];
//        
//        //3. 创建player --> 设置时需要传入网址
//        pVC.player = [AVPlayer playerWithURL:url];
//        
//        //4. 开始播放
//        [pVC.player play];
//    
//        //5. 模态弹出
//        //[self presentViewController:pVC animated:YES completion:nil];
//        
//        //5. 如果想要自定义播放器的大小,应该自定义 --> 设置frame / 添加到视图中
//
//        pVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 400);
//        pVC.view.center=self.view.center;
//        
//        // CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI_2);
//        
//        // pVC.view.transform=rotation;
//        
//        [self.view addSubview:pVC.view];
        
        
        
        
    }
 

  }
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f,%f",scrollView.contentOffset.y,((self.count/3-4)*[UIScreen mainScreen].bounds.size.height/4));
    CGFloat slide=((self.count/3-4)*[UIScreen mainScreen].bounds.size.height/4);
    if (scrollView.contentOffset.y>slide) {
        
        NSLog(@"shuaxin");
     
        self.count=self.count+6;
    }

}

-(void)WebViewBack:(UIButton *)sender{
    [sender.superview removeFromSuperview];

}

-(void)back{


    [self dismissViewControllerAnimated:YES completion:nil];

}

/**
 mov m4v mp4  avi
 */
-(BOOL)fileIsVideo:(NSString *)fileName{
    BOOL isVideo=NO;
    NSArray *videoTypeList=@[@"mov",@"m4v",@"mp4",@"avi",@"AVI",@"MP4",@"M4V",@"MOV"];
    for (NSString *type in videoTypeList) {
        if ([fileName containsString:type]) {
            isVideo=YES;
            
        }
    }
    return isVideo;

}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    NSLog(@"%@",NSStringFromCGSize(size));
 
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
@end
