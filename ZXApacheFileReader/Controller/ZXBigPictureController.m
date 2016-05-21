//
//  ZXBigPictureController.m
//  ZXApacheFileReader
//

//i:iiiiiiiiii;;:  :s58G&&&&AHGh1sisi,;S1,;iGA&&&&&&A&&&&&&&&AAAAAAAAAH&h;SGS&H398i;X&XHX5115&A95113H3                    i9999
//i,:::::::::::,,   .18G&&&&&8hrrii;:s3h;113&&&&&&&&&&&&&&&&&&&&AAAAAAAAXh;iis8AX&811XHHHX3hs59GX851hh;,:::               13333
//i;iiiiiii;;;;;:,. .sG&AAAGSssh51s5G&95GGXAAAAAAAAAAAAAHAAAAAAHHHHHHHHHBBGhh119ABBBX38GAHBH8h1h3&H&3hh59GG89S1i;:,      .h9999
//i;ii;;;i;;;;:::,,. ,8&HA9h11SGS19AA&GAA&AAAAAAAAA&AHHHHHHHHHHHHHHHBHHHHBBHAHH&&BBBBB&9hSG&HA9h1h8HB&9hh9889S51srii;,.    s999
//i:i;;:::::;;:::::,.,9HA3h119A815&AAAAAAAHHHHHHHHA8GHHHHBHHHHHHHHHHBBBBBBBBBBBMBBBBBBBBGhSX99GGShh9HBB&9159988951sri;,    1989
//;:;;;:,..,:;;::::::;S&95h19AA318AAAAAHHHHHHHHHHA8SSXBHBBBBBBBBBBBBBBBBBBBBMBBBMBBBBBBBBX5GB&35S5hh8BBHAXS9&GG&HAG95hsi,  :;59
//;,:;irirsr151i;:ish3G8h51SAA&Sh&HAHHHHHHBHHHBB&3SSS3&BBBBBBBBBBBBBBBBBMBBBMMBBMMMBBBBBBMXSAMB&9hhh5&BBX8X8&BHXG&BBHX9Shs;. :S
//:.,,,i5999933SssS8X&&55S1XAA&5SAHHHHHHHHHBBBA&8SSS339AMBBBBMBMMBBBBBBA&BMMBMBMMMMMMMMMMMMX8BMMM&3hh3BMBXS38GHMHXXHBBBHX951rs3
//:,,   199933S553Sh9&8hGS5AAHASSAHHHHHBBAABBB&XG893SSS3XBMBXXBMHBMMMMMB89&HBMH&BMMMBBMMMMMMX&MMMMBG5h&MBMAS553HMBH&HBBBBBAGS5S
//,.,.  :sshS3Shs:;S&&59AS3HHHHSSHHBBBBBAGXBBA888G&HAX83S8AMH9GBHGAMMMMMH99&MMMHGGHMBX&BMMMMMHMMMM##&59BMMMH3hhSABBBHBBBBBBBHGS
//;r:.;rr1S3S1r13&A85&H99HHBB85ABBBBBB8S3HMGS98G&B#@MBAG8XBH89A&98AMMMMB##MHB#&33XBBG8AMMMMMMMMM###&3BMMMMB8hhSAMBBMMBBBBBBBH
//i33S3999993399&AA39HHX3HHBBASXBBMBBB833GB&&&HMB838&HHB&89XX9388998B#MMBX&B&8&AX99GX83GBMMM##MMM#M#XHMMMMMMG5h5&MBMMBBBBBBBB
//::h999933399999GAAASGHHA9ABBBB&9BBMMBB833GMA8XMMBS189338X933993399338XBB9&#M&hSGGA&939339&MMM#MMMMMMMBMMMMMMMX5h5&MBMMBBBBBHB
//351h399S53SS398AAHXS&HHHGGBBBBM&&BBBMMG9AM8S9MMH##BM833333333333993333GHGMBB@BMB33&BG33339B#M#MMMMMMMMMMMMMMMMX5h5&MMMBBBBBA8
//:.  :s1S5s,.:h8HHA9SAHHHHGHMBBMBHMM&&M&8HHhs3H#HMBBM83333333333333333338XMBB#HMH313BX33SS8HM####MMMMMMMMMMMMMMMX5h5&MMMMMBBBA
//, ..   :r;,,,i8HA553AHHHBA&BBBBBMBB&3&H9399h5X#BA&&X933333333333333333333XH&&BMGS599333hsGMMM##MMMMMMMMMMMMMMMMMG5h5AMMMMMBBB
//siii;;:,.:s1si3H3;53AHHHBBHBMMMMMHS893XG333339999333333333333GX31S33333333399889993333311&#MBBMMMMMMMMMMMMMMMMMMMX5hSAMMMMMMB
//3SS1rrr;,r33SSGA3SSSAHBBBBBBBGS9&B8h933933333333333333333333G#B9S5333333333333333333335sSMA9S53HMMMMMMMMMMMMMMMMMMX5hSHMMMMMB
//3S3SS555s53333GG955SHBBBBBBB8r15S&#&333333333333333333333339A#&3833333333333333333333311&MG8831XMMMMMMMMMMMMMMMMMMM&Sh3BMMMMB
//S533333333SSSSS9S553HBBBBBBAhSAAG9AB&833333333333333333333339X933333333333333333333335s3BAXBHShHMMMMMMMMMMMMMMMMMMMMASh3BMMMB
//55S3333SSSS55h5Sh559BBBBBBM&19X88XG&89333333333333333333333333333333333333333333333331hGBA9835X#MMMMMMMMMMMMMMMMMMMMMH3h3BMMM
//5h55SSSS55hh115hhS58BBBBBBBB85S3GBA535S3333333333333333333333333333333333333333333335138BA9SS&M#MMMMMMMMMMMMMMMMMMMMMMB8h9HM#
//5hhhhh111111sh5153hXBBBBBBMMMAGS5&H95Sh33333333333333333999999999999SS3333333333333S1SXHH83XB#M##MMMMMMMMMMMMMMMMMMMMH&HG55h3
//Sh555h11ssss15hh8S5&BBBBBBBMM#MA95GHBG5h33333333333333398X&AAHHHHHHHGS393333333333315AHG38H###MM#MMMMMMMMMMMMMMMMMMMMMA8XGSh:
//Sh5hsiiis1srh5h3GhSABBMBMMMMMMMMMX33G&95h33333333333338HHMMMMMMMMMMMMMBG3333333333h58G39A##MM##M##MMMMMMMMMMMMMMMMMMMMMB839S5
//Sh1:    .:,:5h5&9h3HBBMMMMMMMMMMM#MX9333ShS933333333338BMMMBBH&XXXGGG&B83333333335S833&M##MMM##M##MMMMMMMMMMMMMMMMMMMMMMM&S5h
//rii;:.     rhhGA5h9BBBMMMMMMM#MMMM##MHAHBGh5333333333338GGGG8999999998833333339Sh9MBBB#######M##M##MMMMMMMMMMMMMMMMMMMMMMMH91
//,,,,:,.;5h3B8hh8BBMMMMMMMM##MMM########AShS933333333333339GXX8333333333339355X###############M##MMMMMMMMMMMMMMMMMMMMMMMMB8
//. .:ih55AHShhXBBMMMMMMMM##MMM##M######MG55S3333333333339988933333333393559B##############M##M##MMMMMMMMMMMMMMMMMMMMMMMMM
//:.,.     i5h8B&5hSHBMMMMMMMMMM#MMM##########M9SSSS3333333333333333333333335hSH###################M##MMMMMMMMMMMMMMMMMMMMMMMMM
//;:;:::;::155AB9hh8BMMMMMMMMMMM#MMMM#########M93988933333333333333333333S55S3X##################M##M##MMMMMMMMMMMMMMMMMMMMMMMM
//i;iiirrir5h8BA5h5AMMMMMMMMMMMM##MMM##########9S338X&XG933333333333333SS39993&#########################MMMMMMMMMMMMMMMMMMMMMMM
//rirsrriis55&MXhh9BMMMMMMM#MMMM###MM##########GS33338&HHAX893333333398GG89333H##########################MMMMMMMMMMMMMMMMMMMMMM
//;:rrriiih5SHB9h5XMMMMMMMM#MMMMM###M##########X53333339GABBH&G8998X&XG9333333M########################M#MMMMMMMMMMMMMMMMMMMMMM
//, ;iiiir519BH515HMMMMMMMMMMMMMM##MMMM########X5SSS333399G&AAA&&AHH&G89333359M#################MMMMM##MMMMMMMMMMMMMMMMMMMMMMMB
//                                                          NO CRASH
//  Created by mac on 16/5/9.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "ZXBigPictureController.h"
#import <UIImageView+WebCache.h>
#import "ZXBigPictureImageView.h"
@interface ZXBigPictureController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIScrollView *scrollerVw;
@property (nonatomic,assign)CGFloat transForm;
@property(nonatomic,assign)CGFloat changeValue;
@end

@implementation ZXBigPictureController
-(void)setChangeValue:(CGFloat)changeValue{
 //限定缩放率系数范围
    if (changeValue>4.0) {
        changeValue=4.0;
    }if (changeValue<-4.0) {
        changeValue=-4.0;
    }if (changeValue<4.0&&changeValue>-4.0) {
    _changeValue=changeValue;
    }   if (!changeValue) {
        _changeValue=0;
    }


}


-(void)setTransForm:(CGFloat)transForm{
    //限定图片缩放范围
    if (transForm>5.0) {
        transForm=5.0;
    }if (transForm<0.2) {
        transForm=0.2;
    }
    _transForm=transForm;
}



-(void)setImgVw:(ZXBigPictureImageView *)imgVw{
    _imgVw=imgVw;
    NSString *path=[self.imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *RL=[NSURL URLWithString:path];
     [imgVw sd_setImageWithURL:RL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      
      if (imgVw.image!=nil) {
          CGFloat h=([UIScreen mainScreen].bounds.size.width/imgVw.image.size.width)*imgVw.image.size.height;
          CGFloat w=[UIScreen mainScreen].bounds.size.width;
          CGFloat y=([UIScreen mainScreen].bounds.size.height-h)/2;
          imgVw.frame=CGRectMake(0,y,w,h);
      }
      
  }];
  
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transForm=1;
    self.scrollerVw=[[UIScrollView alloc]init];
    [self.view addSubview:self.scrollerVw];

    self.scrollerVw.frame=[UIScreen mainScreen].bounds;
    self.scrollerVw.backgroundColor=[UIColor blackColor];
    
    ZXBigPictureImageView *imgVw=[[ZXBigPictureImageView alloc]init];
   
    self.imgVw=imgVw;
    
    [self.scrollerVw addSubview:imgVw];
    
    self.scrollerVw.contentSize=CGSizeMake(0, 0);
    
 
    
    UIButton *btn=[UIButton new];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.frame=CGRectMake(10, 20,40, 40);
    [btn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    
    //添加返回上一层按钮
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgVw.userInteractionEnabled=YES;
    
    UIRotationGestureRecognizer *rota=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(imgRotation:)];
    [self.imgVw addGestureRecognizer:rota];
    
    //添加长按事件
    UILongPressGestureRecognizer *longest=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    
    [self.imgVw addGestureRecognizer:longest];
    //添加缩放事件
    UIPinchGestureRecognizer *gest=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTouch:)];
    [self.imgVw addGestureRecognizer:gest];
    
    gest.delegate=self;

}





-(void)imgRotation:(UIRotationGestureRecognizer *)sender{
    NSLog(@"%f,%f",sender.rotation,sender.velocity);



}


-(void)longPress:(UILongPressGestureRecognizer *)sender{

    NSLog(@"%@",sender);



}
-(void)doubleTouch:(UIPinchGestureRecognizer *)sender{
    self.changeValue=sender.velocity;

    self.transForm=self.transForm+0.03*self.changeValue;
    
    if (sender.numberOfTouches==2) {
        if (self.imgVw.frame.size.height<[UIScreen mainScreen].bounds.size.height*6) {

            
            self.imgVw.transform=CGAffineTransformMakeScale(self.transForm, self.transForm);
        }    }
    


    
    self.scrollerVw.contentSize=self.imgVw.frame.size;
    
    if (self.imgVw.frame.size.height>self.view.bounds.size.height) {
        self.scrollerVw.contentInset=UIEdgeInsetsMake(-self.imgVw.frame.origin.y, 0, self.imgVw.frame.origin.y, 0);
    }
    if (self.imgVw.frame.size.width>self.view.bounds.size.width) {
        self.scrollerVw.contentInset=UIEdgeInsetsMake(0, -self.imgVw.frame.origin.x, 0, self.imgVw.frame.origin.x);
    }
    if ((self.imgVw.frame.size.height>self.view.bounds.size.height)&&(self.imgVw.frame.size.width>self.view.bounds.size.width)) {
        
        self.scrollerVw.contentInset=UIEdgeInsetsMake(-self.imgVw.frame.origin.y, -self.imgVw.frame.origin.x, self.imgVw.frame.origin.y, self.imgVw.frame.origin.x);
    }
    if ((self.imgVw.frame.size.height<self.view.bounds.size.height)&&(self.imgVw.frame.size.width<self.view.bounds.size.width)) {
        self.scrollerVw.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
      
        self.view.backgroundColor=[UIColor clearColor];
        self.scrollerVw.backgroundColor=[UIColor clearColor];
        
    }
    dispatch_queue_t queue3=dispatch_queue_create("zx", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue3, ^{
        if ((self.imgVw.frame.size.width<self.imgVw.image.size.width)&&(long)sender.state==3) {
            [self back];
        }
    });
   
}


-(void)back{
[[SDWebImageManager sharedManager] cancelAll];
    if (self.imgVw.image) {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.backgroundColor=[UIColor clearColor];
            self.scrollerVw.backgroundColor=[UIColor clearColor];
            
            CGFloat h=self.imgVw.frame.size.height;
            CGFloat w=self.imgVw.frame.size.width;
            CGFloat tx=self.holdPlace.origin.x;
            
            CGFloat ty=self.holdPlace.origin.y;
            
            CGFloat th=self.holdPlace.size.height;
            
            CGFloat tw=self.holdPlace.size.width;
            CGRect fr;
            
            
            CGFloat fh=th;
            CGFloat fw=th/h*w;
            CGFloat fx=tx-((fw-tw)/2);
            CGFloat fy=ty;
            fr=CGRectMake(fx, fy, fw, fh);
            
            self.imgVw.frame=fr;
        }];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.view removeFromSuperview];
        
    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
