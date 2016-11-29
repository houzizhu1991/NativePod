//
//  CGAlbumCell.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/6.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DealDeleteAlbumBlock)(NSInteger albumId);
#import "CGAlbumModel.h"
@interface CGAlbumCell : UICollectionViewCell
@property (nonatomic,assign) BOOL isFirst; // 用于判断是否是第一个cell
@property (nonatomic,assign) BOOL isFromClass; // 判断是班级界面
@property (nonatomic,assign)  BOOL isManager;  // 判断是否是管理员
@property (nonatomic,assign) BOOL isOther ;    // 判断是否是查看其它班级

@property (nonatomic,strong) CGAlbumModel *albumModel;
@property (nonatomic, copy) DealDeleteAlbumBlock block;
- (void)deleteAlbum:(DealDeleteAlbumBlock )block;
@property (nonatomic,assign) BOOL  isShowCover; // 是否显示遮盖
@end
