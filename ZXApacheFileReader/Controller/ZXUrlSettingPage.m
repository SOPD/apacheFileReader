//
//  ZXUrlSettingPage.m
//  ZXApacheFileReader
//
//  Created by mac on 16/5/7.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "ZXUrlSettingPage.h"
#import "NetWorkTool.h"
#import "ZXHomePage.h"
#import "ZXPictureCell.h"
#import <YYModel/YYModel.h>
#import "ZXFileModel.h"
#import <SDWebImage/SDWebImageManager.h>

/**
 *  初始页面  设置要连接的地址
 */

@interface ZXUrlSettingPage ()
@property(nonatomic,strong)UILabel *ReadMe;
@property(nonatomic,strong)UISwitch *isKeep;
@property(nonatomic,strong)UITextField *urlField;
@property(nonatomic,strong)UIButton *ConnectButton;
@property(nonatomic,strong)NetWorkTool *tool;
@property(nonatomic,strong)NSArray *list;
@property(nonatomic,strong)ZXHomePage *home;
@end

@implementation ZXUrlSettingPage
//list懒加载

-(NSArray *)list{
    if (_list==nil) {
        _list=[NSArray array];
    }
    return _list;
}

-(NetWorkTool *)tool{
    if (_tool==nil) {
        _tool=[NetWorkTool sharedToolWithBaseUrl:nil];
    }


    return _tool;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setSubViews];
    
    //为按钮添加点击事件
    [self.ConnectButton addTarget:self action:@selector(didConnectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    

    //读取保存的记录
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *KeepedUrl=[defaults objectForKey:@"keepUrl"];
    if ([KeepedUrl isEqualToString:@"yes"]) {
        self.isKeep.on = YES;
    }
    self.urlField.text=[defaults objectForKey:@"fileUrl"];
    
    [self didConnectButtonClick];
  
    
}
/**
 *  点击连接按钮
 */
-(void)didConnectButtonClick{
    
     NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];

    //连接地址栏中的地址
    NSString *str=[NSString stringWithFormat:@"files.json"];
    NSString *urlStr=[NSString stringWithFormat:@"http://%@/%@",self.urlField.text,str];

    

    //发送网络请求
    [self.tool GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
      //  NSLog(@"%@",self.tool.baseURL);
        NSLog(@"下载中");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //记录网络返回的数据
    self.list=responseObject;
        NSLog(@"下载完成");
                
        //如果下载到了数据则创建具体请求列表并创建图片浏览器
        if (self.list) {
            NSMutableArray *mArr=[NSMutableArray array];
            mArr= (NSMutableArray *)[NSArray yy_modelArrayWithClass:[ZXFileModel class] json:self.list];
            
            NSString *baseUrl=self.urlField.text;
                      UICollectionViewFlowLayout *flowLayout=[UICollectionViewFlowLayout new];
            
            ZXHomePage *homePage=[[ZXHomePage alloc]initWithCollectionViewLayout:flowLayout];
            
            
            //设置item布局
            flowLayout.minimumLineSpacing=1;
            flowLayout.minimumInteritemSpacing=1;
            CGFloat imgW=[UIScreen mainScreen].bounds.size.width/3-1;
            CGFloat imgH=[UIScreen mainScreen].bounds.size.height/4-1;
            flowLayout.itemSize=CGSizeMake(imgW, imgH);
            
            homePage.pictureUrlList=mArr;
            
            homePage.baseUrl=baseUrl;
            
            self.home=homePage;
            
            
            
            
            
            //定义长按调用的BLOCK
            homePage.HomeBlock=^(NSIndexPath *index,ZXPictureCell *cell){
                
          //      添加选项
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"保存这张图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                //保存选项
                UIAlertAction *action=[UIAlertAction actionWithTitle:@"保存" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //拼接完整地址
                    NSString *baseUrl=cell.url;
                    NSString *path=cell.model.filePath;
                    NSString *url=[NSString stringWithFormat:@"http://%@/%@",baseUrl,path];
                    
                    //下载图片
                    [self downLoadImage:url];
           
                }];
                
                
                //取消选项
                UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alert addAction:action];
                [alert addAction:action2];
                
              
          //      显示AlertView
            [self.home presentViewController:alert animated:YES completion:nil];

            };
            
            //显示homePage
            [self presentViewController:homePage animated:YES completion:^{
                
                
            }];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败");
    }];
    
         //记录地址
    if (self.isKeep.isOn) {
        [defaults setValue:self.urlField.text forKey:@"fileUrl"];

        [defaults setValue:@"yes" forKey:@"keepUrl"];
    }else{
        [defaults setValue:@"" forKey:@"fileUrl"];
        
        [defaults setValue:@"no" forKey:@"keepUrl"];
    }
    


}

-(void)downLoadImage:(NSString *)imgUrl{
    NSLog(@"%@",imgUrl);

    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:[imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        
    }  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
        
    }];




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
/**
 *  设置子控件
 */
-(void)setSubViews{
    
    //创建控件
    self.ReadMe=[UILabel new];
    
    self.isKeep=[UISwitch new];
    
    self.urlField=[UITextField new];
    
    self.ConnectButton=[UIButton new];
    
    //添加控件
    [self.view addSubview:self.ReadMe];
    [self.view addSubview:self.isKeep];
    [self.view addSubview:self.urlField];
    [self.view addSubview:self.ConnectButton];
    
    //设置控件内容
    self.ReadMe.text=@"保存";
    [self.ReadMe sizeToFit];
    
    self.urlField.placeholder=@"在此输入您的文件仓库地址";
    
    self.urlField.keyboardType=UIKeyboardTypeDefault;
    
    [self.ConnectButton setTitle:@"连接" forState:UIControlStateNormal];
    
    [self.ConnectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    
    
    self.urlField.bounds=CGRectMake(0, 0, screenW-30, 20);
    self.urlField.center=CGPointMake(screenW/2, screenH/4+30);
    
    
    self.isKeep.center=CGPointMake(screenW/4, screenH/2);
    self.ConnectButton.bounds=CGRectMake(0, 0, 120, self.isKeep.frame.size.height);
    self.ConnectButton.center=CGPointMake(screenW/4*3, self.isKeep.center.y);
    
    
    self.ReadMe.center=CGPointMake(screenW/4,screenH/2-30);
    
}

@end
