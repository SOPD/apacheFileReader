//
//  UIImageView+ZXImageReloader.m
//  ZXImageDownLoader
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "UIImageView+ZXImageReloader.h"
ZXImageReloader *_reloader;
@implementation UIImageView (ZXImageReloader)



-(void)setReloader:(ZXImageReloader *)reloader{

   objc_setAssociatedObject(self, (__bridge const void *)(_reloader), reloader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(ZXImageReloader *)reloader{

return  objc_getAssociatedObject(self, (__bridge const void *)(_reloader));

}

-(void)ImageWithUrl:(NSString *)url{
    
    if (self.reloader==nil) {
    self.reloader=[ZXImageReloader new];
    }
    __weak UIImageView *vw=self;
    self.reloader.finish=^(UIImage  *img){
       vw.image=img;
    };
    [self.reloader ImageWithUrl:url];





}


@end
