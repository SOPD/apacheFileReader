//
//  ZXBigPictureController.h
//  ZXApacheFileReader
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXBigPictureImageView;
@interface ZXBigPictureController : UIViewController
@property(nonatomic,strong)NSString *imgUrl;
@property(nonatomic,weak)UIImageView *imgVw;
@property(nonatomic,assign)CGRect holdPlace;
@end
