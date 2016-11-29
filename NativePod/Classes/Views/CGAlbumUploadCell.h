//
//  CGAlbumUploadCell.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/11.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGUploadCateModel.h"

@interface CGAlbumUploadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iocnIV;  // 头像

@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel; // 相册名

@property (weak, nonatomic) IBOutlet UILabel *albumUploadDesLabel; // 上传失败描述

@property (weak, nonatomic) IBOutlet UIView *coverView; // 覆盖背景
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView; // 显示状态view

@property (nonatomic,strong) CGUploadCateModel *cateModel;

@property (nonatomic,strong) void(^deleteAlbumBlock)(CGAlbumUploadCell *cell);  // 删除相册block
@property (nonatomic,strong) void(^UploadAlbumBlock)(CGAlbumUploadCell *cell,BOOL iscancleUpload);  // 上传单个相册block


@end
