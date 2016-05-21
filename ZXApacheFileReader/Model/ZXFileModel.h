//
//  ZXFileModel.h
//  ZXApacheFileReader
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 zhaoxin. All rights reserved.
//

#import <Foundation/Foundation.h>
/* 
 {"filePath":"Images/毕业照1/计算机壁纸/毕业照1/毕业照1/毕业照1/DSC01956.jpg",
 "fileType":"image",
 "fileName":"DSC01956",
 "previewPath":"Preview/000000009.jpg"}
 */
@interface ZXFileModel : NSObject
@property(nonatomic,copy)NSString *filePath;
@property(nonatomic,copy)NSString *fileType;
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,copy)NSString *previewPath;

@end
