//
//  CGAlbumUploadDetailCell.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/20.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGAlbumUploadDetailCell.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation CGAlbumUploadDetailCell

- (void)awakeFromNib
{
    self.iconIv.contentMode = UIViewContentModeScaleAspectFill;
    self.iconIv.clipsToBounds = YES;
    self.coverView.hidden = YES;
    self.progressView = [[CGVideoProgressView alloc]init];
    self.progressView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    CGFloat marginLR = 3;  // 距离左右2边距离
    
    CGFloat itemWH = (kScreenWidth - 5*marginLR) / 4;
    self.progressView.frame = CGRectMake(0, 0, itemWH, itemWH);
    
    [self.contentView addSubview:self.progressView];
    self.progressView.hidden = YES;
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatus:) name:@"PhotoFailCellNSNotification" object:nil];
}

- (IBAction)checkButtonClick:(id)sender {
    self.checkButton.selected = ! self.checkButton.isSelected;
    if ([self.delegate respondsToSelector:@selector(didCheckedButton:withModel:)]) {
        [self.delegate didCheckedButton:self withModel:self.model];
    }
}
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.progressView.hidden = NO;
    self.coverView.hidden = YES;
    self.progressView.progress = progress;
}

- (void)setModel:(CGPhotoModel *)model
{
    _model = model;
    __weak typeof(self) weakSelf = self;
    self.checkButton.hidden = NO;
    self.progressView.hidden = YES;
    if (self.checkButton.selected) {
        self.coverView.hidden = NO;
        self.uploadStatusIV.image = [UIImage imageNamed:@"album_7_5_wating"];
    }else{
        self.coverView.hidden = YES;
    }
   
    if ([self.model.passet isKindOfClass:[PHAsset class]]) {
        [[PHImageManager defaultManager]requestImageForAsset:self.model.passet
                                                  targetSize:[UIScreen mainScreen].bounds.size
                                                 contentMode:PHImageContentModeDefault
                                                     options:nil
                                               resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                   [weakSelf.iconIv setImage:result];
                                               }];

    }else{
    
            NSURL *asseturl = [NSURL URLWithString:model.localIndenty];
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library assetForURL:asseturl resultBlock:^(ALAsset *asset)
             {
                 self.model.passet = asset;
                 ALAssetRepresentation *tRepresentation = asset.defaultRepresentation;
                 UIImage *tImage = [UIImage imageWithCGImage:tRepresentation.fullScreenImage];
                 [self.iconIv setImage:tImage];
             }
                    failureBlock:^(NSError *error)
             {
                 
             }];
    }
}

- (void)setIsStartUploading:(BOOL)isStartUploading
{
    _isStartUploading = isStartUploading;
    if (self.isStartUploading) {
        self.coverView.hidden = NO;
        self.uploadStatusIV.image = [UIImage imageNamed:@"album_7_4_uploading"];
    }
}
@end
