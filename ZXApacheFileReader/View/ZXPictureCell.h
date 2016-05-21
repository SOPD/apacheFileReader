//
//  ZXPictureCell.h
//  ZXApacheFileReader
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXFileModel.h"
@class ZXPictureCell;
typedef void(^SelectCellBlock)(NSIndexPath *,ZXPictureCell *);
typedef void(^downBlock)();
@interface ZXPictureCell : UICollectionViewCell
//图片框
@property(nonatomic,weak)UIImageView *imageVw;
//文件仓库地址
@property(nonatomic,copy)NSString *url;
//存储自身所在的位置
@property(nonatomic,strong)NSIndexPath *indexPath;
//选中cell执行的BLOCK
@property(nonatomic,copy)SelectCellBlock cellBlock;
//下载完成执行的BLOCK
@property(nonatomic,copy)downBlock downSuccess;
//模型
@property(nonatomic,strong)ZXFileModel *model;
@end
