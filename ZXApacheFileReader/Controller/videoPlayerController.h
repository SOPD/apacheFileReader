//
//  videoPlayerController.h
//  ZXApacheFileReader
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
@interface videoPlayerController : UIViewController
@property (nonatomic,strong)NSURL *videoUrl;
@property (nonatomic, strong) MPMoviePlayerController *mpC;
@end
