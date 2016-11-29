//
//  CGUploadCateModel.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/20.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGAlbumModel.h"
@interface CGUploadCateModel : NSObject
@property (nonatomic, assign) NSInteger fileCount ; // 上传失败文件个数
@property (nonatomic, strong) CGAlbumModel *albumModel; // 对应相册模型
@property (nonatomic, strong) NSMutableArray *nativePhotoArray; // 对应本地照片数组
@property (nonatomic, assign) NSInteger uploadStatus; // 对应上传状态

@property (nonatomic, assign) BOOL isCancle ;  // 定义一个标识是否取消上传
@property (nonatomic, assign) BOOL isWaiting ; // 判断是否是等待状态
@end
