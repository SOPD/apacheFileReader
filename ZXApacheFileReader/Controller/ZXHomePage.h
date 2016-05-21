//
//  ZXHomePage.h
//  ZXApacheFileReader
//
//  Created by mac on 16/5/7.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXPictureCell;
typedef void(^SelectCellBlock)(NSIndexPath *,ZXPictureCell *);
@interface ZXHomePage : UICollectionViewController
@property(nonatomic,strong)NSArray *pictureUrlList;
@property(nonatomic,copy)SelectCellBlock HomeBlock;
@property(nonatomic,copy)NSString *baseUrl;
@end
