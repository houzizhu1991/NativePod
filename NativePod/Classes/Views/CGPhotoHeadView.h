//
//  CGPhotoHeadView.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/8.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGAlbumModel.h"
@class CGPhotoHeadView;
@protocol CGPhotoHeadViewDelegate <NSObject>
/**
 *  添加按钮点击
 */
- (void)didAddPhotoClick:(CGPhotoHeadView *)headView;
/**
 *  点击上传失败按钮
 */
- (void)didUploadFailClick:(CGPhotoHeadView *)headView;
@end
@interface CGPhotoHeadView : UICollectionReusableView

@property (nonatomic,weak) id<CGPhotoHeadViewDelegate> delegate;

@property (nonatomic,strong) CGAlbumModel * model;

@property (nonatomic, assign) BOOL isShowAddBtn ;  // 判断是否显示添加按钮

@property (nonatomic, assign) BOOL isShowUploadBtn ;  // 判断是否显示上传按钮
@property (nonatomic, assign) NSInteger uploadBtnFailCount ; // 显示上传失败按钮的数量

@property (weak, nonatomic) IBOutlet UIImageView *coverImageIV;

@property (weak, nonatomic) IBOutlet UILabel *isLegaLable; // 是否违规提示

@property (nonatomic,assign) BOOL isShowCover ;

@end
