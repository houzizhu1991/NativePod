//
//  CGPhotoCell.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/8.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGPhotoModel.h"
#import "CGVideoProgressView.h"
@class CGPhotoCell;
typedef void (^uploaldBlock)(CGPhotoCell *cell);
@interface CGPhotoCell : UICollectionViewCell
@property (nonatomic,strong) CGPhotoModel *photoModel;

@property (nonatomic, copy) uploaldBlock block;

- (void)handleUploadBlock:(uploaldBlock )block;
/**
 *  显示图片状态
 */
@property (weak, nonatomic) IBOutlet UIImageView *showImageStatusIV;
@property (nonatomic,strong) CGVideoProgressView *progressView;
/**
 *  蒙版view
 */
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,assign) BOOL  isShowCover; // 是否显示遮盖
@end
