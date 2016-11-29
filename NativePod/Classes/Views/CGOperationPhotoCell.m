//
//  CGOperationPhotoCell.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/11.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGOperationPhotoCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ImageEffects.h"
@implementation CGOperationPhotoCell
- (void)awakeFromNib
{
    self.photoIV.contentMode = UIViewContentModeScaleAspectFill;
    self.photoIV.clipsToBounds = YES;
}
- (void)setModel:(CGPhotoModel *)model
{
    _model = model;
    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:model.photo_thumbnail_url] placeholderImage:[UIImage imageNamed:@"album_6_8_picture"]];
    if (_model.photo_status == 0) {
        self.coverView.hidden = NO;
    }else{
        self.coverView.hidden = YES;
    }
//    MyWeakSelf;
//    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:model.photo_thumbnail_url] placeholderImage:[UIImage imageNamed:@"album_6_8_picture"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (_model.photo_status == 0) {
//            image = [image blurImageWithRadius:10];
//            weakSelf.photoIV.image  = image;
//        }
//    }];
}

- (IBAction)checkButClick:(id)sender {
    self.checkButton.selected = ! self.checkButton.isSelected;
    if ([self.delegate respondsToSelector:@selector(didCheckedButton:withModel:)]) {
        [self.delegate didCheckedButton:self withModel:self.model];
    }
}
@end
