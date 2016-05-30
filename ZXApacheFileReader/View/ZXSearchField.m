//
//  ZXSearchField.m
//  ZXApacheFileReader
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "ZXSearchField.h"

@implementation ZXSearchField



- (void)drawRect:(CGRect)rect {
  CGContextRef ref=UIGraphicsGetCurrentContext();
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width,0)];
    [path moveToPoint:CGPointMake(self.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path moveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path moveToPoint:CGPointMake(0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, 0)];
    path.lineWidth=4;
    
    //利用上下文设定绘图的宽度
    CGContextSetLineWidth(ref,4);
    
    [[UIColor grayColor] setStroke];

    [path stroke];
}


@end
