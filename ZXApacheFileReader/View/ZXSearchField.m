//
//  ZXSearchField.m
//  ZXApacheFileReader
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import "ZXSearchField.h"

@implementation ZXSearchField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius=4;
        self.clipsToBounds=YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef ref=UIGraphicsGetCurrentContext();
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(1, 1, self.bounds.size.width-2, self.bounds.size.height-2) cornerRadius:5];

    path.lineWidth=4;
    
    //利用上下文设定绘图的宽度
    CGContextSetLineWidth(ref,4);
    
    [[UIColor grayColor] setStroke];

    [path stroke];
}


@end
