//
//  videoPlayerController.m
//  ZXApacheFileReader
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "videoPlayerController.h"

@interface videoPlayerController ()

@property (nonatomic,strong)UIButton *closeBtn;

@property (nonatomic,strong)UIButton *changeFrameBtn;

@property (nonatomic,strong)UIButton *stopBtn;

@property (nonatomic,assign)BOOL isPlaying;

@end
@implementation videoPlayerController
-(void)setVideoUrl:(NSURL *)videoUrl{

    _videoUrl=videoUrl;
    [self moviePlayerControllerWithUrl:videoUrl];

}

-(void)viewDidLoad{


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinishNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];

}
- (void)moviePlayerPlaybackDidFinishNotification:(NSNotification *)notification
{
    /**
     MPMovieFinishReasonPlaybackEnded,  播放结束
     MPMovieFinishReasonPlaybackError,  播放错误
     MPMovieFinishReasonUserExited      退出播放
     */
    
    //1. 获取通知结束的状态
    NSInteger movieFinishKey = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    
    //2. 根据状态不同来自行填写逻辑代码
    switch (movieFinishKey) {
        case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"播放结束");
            [self.mpC.view removeFromSuperview];
            
            // 进行视频切换 需要两步
            
            //1. 要想换视频, 就需要更换地址
           // self.mpC.contentURL = [[NSBundle mainBundle] URLForResource:@"Alizee_La_Isla_Bonita.mp4" withExtension:nil];
            
            //
         [self.mpC play];
            
            break;
            
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"播放错误");
            break;
            
        case MPMovieFinishReasonUserExited:
            NSLog(@"退出播放");
            
            // 如果是不带view的播放器, 那么播放完毕(退出/错误/结束)都应该退出
            [self.mpC.view removeFromSuperview];
            break;
            
        default:
            break;
    }
    
}
- (void)moviePlayerControllerWithUrl:(NSURL *)url
{
    // 不带View的播放器的控制器 --> 需要强引用, 设置frame, 添加到view上, 开始播放
    //1. 获取URL地址
   
    
    //2. 创建不带View的播放器
    self.mpC = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    
    //3. 设置view.frame
    self.mpC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/16*9);
    self.mpC.view.backgroundColor=[UIColor clearColor];
    
    //4. 添加到view上
    [self.view addSubview:self.mpC.view];
    
    //5. 准备播放 --> 规范写法, 要写上. 调用play方法时, 会自动调用此方法
    [self.mpC prepareToPlay];
    
    //6. 开始播放
    [self.mpC play];
    self.isPlaying=YES;
    
    //7. 控制模式
    self.mpC.controlStyle =  MPMovieControlStyleNone;

    
    //添加关闭按钮
    UIButton *btn=[[UIButton alloc]init
                   ];
    self.closeBtn=btn;
    btn.frame=CGRectMake(0, 0, 10, 10);
    btn.backgroundColor=[UIColor redColor];
    [self.mpC.view addSubview:btn];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"naturalSize%@",NSStringFromCGSize(self.mpC.naturalSize));
    UIButton *changebtn=[[UIButton alloc]init
                   ];
    
    //添加横竖屏转换按钮
    self.changeFrameBtn=changebtn;
   changebtn.frame=CGRectMake(self.mpC.view.frame.size.width-20, self.mpC.view.frame.size.height-20,20, 20);
    
    changebtn.backgroundColor=[UIColor redColor];
    [self.mpC.view addSubview:changebtn];
    [changebtn addTarget:self action:@selector(changeFrame) forControlEvents:UIControlEventTouchUpInside ];

    UIButton *stop=[UIButton new];
    self.stopBtn=stop;
    
    stop.frame=CGRectMake(0, self.mpC.view.frame.size.height-30,30, 30);
    
    stop.backgroundColor=[UIColor redColor];
    [self.mpC.view addSubview:stop];
    [stop addTarget:self action:@selector(stopPlay) forControlEvents:UIControlEventTouchUpInside ];

    
    
}

-(void)stopPlay{
    if (self.isPlaying) {
            [self.mpC pause];
          self.isPlaying=NO;
    }else{
        [self.mpC play];
        self.isPlaying=YES;
    
    }

    
}
-(void)back{


    [self.mpC.view removeFromSuperview];


}
-(void)changeFrame{
 
    if (self.changeFrameBtn.frame.origin.x==self.mpC.view.frame.size.width-20) {
        self.mpC.view.transform=CGAffineTransformMakeRotation(M_PI_2);
        self.mpC.view.frame=[UIScreen mainScreen].bounds;
        
        self.changeFrameBtn.frame=CGRectMake(self.mpC.view.frame.size.height-20, self.mpC.view.frame.size.width-20,20, 20);
        self.closeBtn.frame=CGRectMake(0, 0, 10, 10);
        
        self.stopBtn.frame=CGRectMake(0, self.mpC.view.bounds.size.height-30, 30, 30);

    }else{
     
        self.mpC.view.transform=CGAffineTransformMakeRotation(0);
    
       self.mpC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/16*9);
    
      self.changeFrameBtn.frame=CGRectMake(self.mpC.view.frame.size.width-20, self.mpC.view.frame.size.height-20,20, 20);
    
            self.stopBtn.frame=CGRectMake(0, self.mpC.view.bounds.size.height-30, 30, 30);
    }


}
@end
