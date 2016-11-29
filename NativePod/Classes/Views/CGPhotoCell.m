//
//  CGPhotoCell.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/8.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGPhotoCell.h"
#import <Photos/Photos.h>
#import "UIImageView+WebCache.h"
#import  <AssetsLibrary/AssetsLibrary.h>
#import "UIView+Extension.h"
#import "CGAlbumSQLManager.h"
@interface CGPhotoCell()

/**
 *  显示照片
 */
@property (weak, nonatomic) IBOutlet UIImageView *showPhotoIV;

@property (nonatomic,assign) CGFloat itemW ;
@end
@implementation CGPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.progressView = [[CGVideoProgressView alloc]init];
    CGFloat marginLR = 5;  // 距离左右2边距离
    
    CGFloat itemWH = (kScreenWidth - 6*marginLR) / 3;
    self.itemW = itemWH;
    self.progressView.frame = CGRectMake(0, 0, itemWH, itemWH);
    self.progressView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    [self.contentView addSubview:self.progressView];
    self.progressView.hidden = YES;
    self.showPhotoIV.contentMode = UIViewContentModeScaleAspectFill;
    self.showPhotoIV.clipsToBounds = YES;
    self.coverView.alpha = 0.5;

}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.progressView.hidden = NO;
    self.coverView.hidden = YES;
    self.progressView.progress = progress;
}

- (void)setPhotoModel:(CGPhotoModel *)photoModel
{
    
    _photoModel = photoModel;
    if (photoModel.album_photo_id > 0 && self.photoModel.photo_thumbnail_url != nil) {
        self.coverView.hidden = YES;
        self.progressView.hidden = YES;
        if (self.photoModel.photo_status == 0) {
            self.coverView.hidden = NO;
            self.showImageStatusIV.image = [UIImage imageNamed:@"album_7_7_error"];
            if (self.isShowCover) {
               
                if (IOS_8_0) {
                    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
                    effectview.frame = CGRectMake(0, 0, self.itemW, self.itemW);
                    [self.showPhotoIV addSubview:effectview];
                }else{
                    self.coverView.alpha = 0.95;
                }
            }else{
                for (UIView * tempView  in  self.showPhotoIV.subviews) {
                    [tempView removeFromSuperview];
                }
            }
        }else{
            for (UIView * tempView  in  self.showPhotoIV.subviews) {
                [tempView removeFromSuperview];
            }
        }
        [self.showPhotoIV sd_setImageWithURL:[NSURL URLWithString:photoModel.photo_thumbnail_url] placeholderImage:[UIImage imageNamed:@"album_6_8_picture"]];
        
    }else {
        __weak typeof(self) weakSelf = self;
        if(photoModel.isSecondUpload){
            if ([CGAlbumSQLManager shareInstance].isUploading) {
                self.coverView.hidden = YES;
                self.showImageStatusIV.image = [UIImage imageNamed:@"album_7_4_uploading"];
            }else{
                self.coverView.hidden = NO;
                self.showImageStatusIV.image = [UIImage imageNamed:@"sight_video_chatpage_nosend_button"];
            }
            
            self.showImageStatusIV.contentMode = UIViewContentModeCenter;
            if ([self.photoModel.passet isKindOfClass:[PHAsset class]]) {
                [[PHImageManager defaultManager]requestImageForAsset:self.photoModel.passet
                                                          targetSize:[UIScreen mainScreen].bounds.size
                                                         contentMode:PHImageContentModeDefault
                                                             options:nil
                                                       resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                           
                                                           [weakSelf.showPhotoIV setImage:result];
                                                       }];

            }else{
                NSURL *asseturl = [NSURL URLWithString:photoModel.localIndenty];
                ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                
                [library assetForURL:asseturl resultBlock:^(ALAsset *asset)
                 {
                     ALAssetRepresentation *tRepresentation = asset.defaultRepresentation;
                     UIImage *tImage = [UIImage imageWithCGImage:tRepresentation.fullScreenImage];
                     [weakSelf.showPhotoIV setImage:tImage];
                 }
                 failureBlock:^(NSError *error)
                 {
                     
                 }];
            }
            
        }else{
            if (self.photoModel.album_photo_id == 0 && self.photoModel.progress == 0) { // 显示等待上传图标
                self.showImageStatusIV.image = [UIImage imageNamed:@"album_7_5_wating"];
                self.progressView.hidden = YES;
                self.coverView.hidden = NO;
            }else if(self.photoModel.progress > 0){
                self.coverView.hidden = YES;
            }
//            else if(self.photoModel.status == 1){ // 显示正在上传图标
//                self.showImageStatusIV.image = [UIImage imageNamed:@"album_7_4_uploading"];
//            }else if(self.photoModel.status == 2){ // 上传失败
//                self.showImageStatusIV.image = [UIImage imageNamed:@"album_7_5_wating"];
//            }
            if (photoModel.album_photo_id > 0) {
                self.coverView.hidden = YES;
            }
            
            if ([self.photoModel.passet isKindOfClass:[PHAsset class]]) {
                
                [[PHImageManager defaultManager]requestImageForAsset:self.photoModel.passet
                                                          targetSize:[UIScreen mainScreen].bounds.size
                                                         contentMode:PHImageContentModeDefault
                                                             options:nil
                                                       resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                           
                                                           [weakSelf.showPhotoIV setImage:result];
                                                           if (weakSelf.block)
                                                           {
                                                               weakSelf.block(self);
                                                           }
                                                       }];
            }else{
                ALAsset *tAsset = (ALAsset *)self.photoModel.passet ;
                ALAssetRepresentation *tRepresentation = tAsset.defaultRepresentation;
                UIImage *tImage = [UIImage imageWithCGImage:tRepresentation.fullScreenImage];
                [self.showPhotoIV setImage:tImage];
                if (self.block)
                {
                    self.block(self);
                }
            }
        }
    }
    
}


- (void)handleUploadBlock:(uploaldBlock)block
{
    self.block = block;
}
@end
