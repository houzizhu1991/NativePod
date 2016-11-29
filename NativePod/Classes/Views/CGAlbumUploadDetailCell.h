//
//  CGAlbumUploadDetailCell.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/20.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGPhotoModel.h"
#import "CGVideoProgressView.h"
@class CGAlbumUploadDetailCell;
@protocol CGAlbumUploadDetailCellDelegate <NSObject>
/**
 *  复选框按钮选中的事件方法
 *
 *  @param cell 选中的cell
 *  @param uid  选中的Uid
 */
- (void)didCheckedButton:(CGAlbumUploadDetailCell *)cell withModel:(CGPhotoModel *)model;

@end
@interface CGAlbumUploadDetailCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIv;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;

@property (weak, nonatomic) IBOutlet UIView *coverView; // 遮盖view

@property (weak, nonatomic) IBOutlet UIImageView *uploadStatusIV;
@property (nonatomic,weak) id<CGAlbumUploadDetailCellDelegate> delegate;
@property (nonatomic,strong) CGPhotoModel *model;
@property (nonatomic, copy)  void (^uploadBlock)(CGAlbumUploadDetailCell *cell);
@property (nonatomic,strong) CGVideoProgressView *progressView;
@property (nonatomic,assign) CGFloat progress ;

@property (nonatomic,assign) BOOL isStartUploading ;// 外层是否在上传
@end
