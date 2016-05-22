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
#import <MediaPlayer/MediaPlayer.h>

@interface ZXHomePage ()

@property (nonatomic,strong)NSMutableArray *shouldShowList;

@property(nonatomic,strong)ZXBigPictureController *bigVc;

@property(nonatomic,strong)UIImage *img;

@property(nonatomic,strong)SDWebImageManager *manager;

@property(nonatomic,assign)int count;

@property(nonatomic,assign)int downCount;


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
    btn.frame=CGRectMake(10, 20,40, 40);
    [btn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    
    //添加返回上一层按钮
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.count=12;
    //设置数据源
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;

    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    __unsafe_unretained UICollectionView *collenVw = self.collectionView;
    
   collenVw.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
   
       if (self.downCount==0) {
               self.count=self.count+12;
       }
     
       
       

       [collenVw.mj_footer endRefreshing];
       
    }];

  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
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
   ZXFileModel *model=self.pictureUrlList[indexPath.row];
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
    }if ([model.fileType isEqualToString:@"file"]) {
        
 
        NSString *filePath= model.filePath;
        NSString *path=[NSString stringWithFormat:@"http://%@/%@",self.baseUrl,filePath];
       UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        NSString *url=[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        

        
        NSURL *URL=[NSURL URLWithString:url];
        
        
//        MPMoviePlayerViewController *movieVc=[[MPMoviePlayerViewController alloc]initWithContentURL:URL];
//        //弹出播放器
//        [self presentMoviePlayerViewControllerAnimated:movieVc];
        
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
        
    }
 

  }

-(void)WebViewBack:(UIButton *)sender{
    [sender.superview removeFromSuperview];

}

-(void)back{


    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
