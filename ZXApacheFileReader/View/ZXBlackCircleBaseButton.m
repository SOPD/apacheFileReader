//
//  ZXBlackCircleBaseButton.m
//  ZXApacheFileReader
//
//  Created by mac on 16/6/1.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "ZXBlackCircleBaseButton.h"

@interface ZXBlackCircleBaseButton ()

@property (nonatomic,strong)UIColor *bigRingColor;
@property (nonatomic,strong)UIColor *smallRingColor;

@end


@implementation ZXBlackCircleBaseButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  

    CGContextRef ref=UIGraphicsGetCurrentContext();
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(2, 2, self.bounds.size.width-4, self.bounds.size.height-4) cornerRadius:self.bounds.size.width];


    path.lineWidth=4;
    
    //利用上下文设定绘图的宽度
    CGContextSetLineWidth(ref,0);

    [self.bigRingColor setStroke];
    
    [path stroke];
    
    
    UIBezierPath *path2=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(7, 7, self.bounds.size.width-14, self.bounds.size.height-14) cornerRadius:self.bounds.size.width];
    path2.lineWidth=3;
    CGContextSetLineWidth(ref,0);
    
    [self.smallRingColor setStroke];
    
    [path2 stroke];
    
    

}
-(instancetype)initWithRingColor:(UIColor *)bigRingColor and:(UIColor *)smallRingColor{
    if (self=[super init]) {
        
        self.bigRingColor=bigRingColor;
        self.smallRingColor=smallRingColor;
        
        
    }

    return self;

}


@end
