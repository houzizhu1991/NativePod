//
//  CGOperationPhotoCell.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/11.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGPhotoModel.h"
@class CGOperationPhotoCell;
@protocol CGOperationPhotoCellDelegate <NSObject>
/**
 *  复选框按钮选中的事件方法
 *
 *  @param cell 选中的cell
 *  @param uid  选中的Uid
 */
- (void)didCheckedButton:(CGOperationPhotoCell *)cell withModel:(CGPhotoModel *)model;

@end
@interface CGOperationPhotoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *checkButton;

@property (weak, nonatomic) IBOutlet UIImageView *photoIV;
@property (nonatomic,strong) CGPhotoModel *model;
@property (nonatomic,weak) id<CGOperationPhotoCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@end
