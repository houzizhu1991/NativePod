//
//  CGAlbumUploadCell.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/11.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGAlbumUploadCell.h"
#import "UIImageView+WebCache.h"
@interface CGAlbumUploadCell()
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (nonatomic, assign) BOOL iscancle ;
@end
@implementation CGAlbumUploadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.deleteButton.layer.borderWidth =1;
    self.deleteButton.layer.borderColor = RGB(150, 150, 150).CGColor;
    self.deleteButton.layer.cornerRadius = 3;
    [self.deleteButton setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
    
    self.uploadButton.layer.borderWidth =1;
    self.uploadButton.layer.borderColor = RGB(255, 153, 0).CGColor;
    self.uploadButton.layer.cornerRadius = 3;
    [self.uploadButton setTitleColor:RGB(255, 153, 0) forState:UIControlStateNormal];
}
/**
 *  删除操作
 */
- (IBAction)deleteClick:(id)sender {
    if(self.deleteAlbumBlock){
        self.deleteAlbumBlock(self);
    }
}
/**
 *  上传操作
 */
- (IBAction)uploadClick:(id)sender {
    if ([self.uploadButton.titleLabel.text isEqualToString:@"上传"]) {
        [self.uploadButton setTitle:@"取消" forState:UIControlStateNormal];
         self.albumUploadDesLabel.text = @"正在上传...";
         self.iscancle = NO;
    }else{
        self.statusImageView.image = [UIImage imageNamed:@"sight_video_chatpage_nosend_button"];
        [self.uploadButton setTitle:@"上传" forState:UIControlStateNormal];
         self.albumUploadDesLabel.text = [NSString stringWithFormat:@"%zd张照片上传失败",_cateModel.nativePhotoArray.count];
        self.iscancle = YES;
    }
    if(self.UploadAlbumBlock){
        self.UploadAlbumBlock(self,self.iscancle);
    }
}

- (void)setCateModel:(CGUploadCateModel *)cateModel
{
    _cateModel = cateModel;
     self.albumUploadDesLabel.text = [NSString stringWithFormat:@"%zd张照片上传失败",_cateModel.nativePhotoArray.count]; // 设置多少张照片描述信息
    if (_cateModel.isWaiting == YES) {
        self.statusImageView.image = [UIImage imageNamed:@"album_7_5_wating"];
        self.albumUploadDesLabel.text = @"准备上传中...";
        self.iscancle = NO;
        if(self.UploadAlbumBlock){
            self.UploadAlbumBlock(self,self.iscancle);
        }
        [self.uploadButton setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        self.iscancle = YES;
        if(self.UploadAlbumBlock){
            self.UploadAlbumBlock(self,self.iscancle);
        }
        self.statusImageView.image = [UIImage imageNamed:@"sight_video_chatpage_nosend_button"];
        [self.uploadButton setTitle:@"上传" forState:UIControlStateNormal];
    }
    [self.iocnIV sd_setImageWithURL:[NSURL URLWithString:_cateModel.albumModel.cover_photo_url] placeholderImage:[UIImage imageNamed:@"album_6_8_picture"]];  // 设置封面
    
    self.albumNameLabel.text = _cateModel.albumModel.album_name; // 设置相册名
    
   
    
    
    
}
@end
