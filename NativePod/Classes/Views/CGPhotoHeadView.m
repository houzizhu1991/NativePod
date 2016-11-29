//
//  CGPhotoHeadView.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/8.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGPhotoHeadView.h"
#import "CGAlbumSQLManager.h"
#import "UIView+Extension.h"
#import "UIImage+ImageEffects.h"
@interface CGPhotoHeadView()
/**
 *  相册描述
 */
@property (weak, nonatomic) IBOutlet UILabel *albumDesLabel;
/**
 *  上传失败文件
 */
@property (weak, nonatomic) IBOutlet UIButton *uploadFailBtn;

/**
 *  权限显示
 */
@property (weak, nonatomic) IBOutlet UIButton *perssionBtn;
/**
 *  礼物显示
 */
@property (weak, nonatomic) IBOutlet UIButton *giftBtn;
/**
 *  赞按钮显示
 */
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
/**
 *  相册封面图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *albumCoverIV;
/**
 *  添加照片按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *legaLabel;

@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *coverViewTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConst;
@end
@implementation CGPhotoHeadView

- (void)awakeFromNib
{
    self.coverImageIV.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageIV.clipsToBounds = YES;
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadFailNotification" object:nil userInfo:@{@"failCount":@([CGAlbumSQLManager shareInstance].uploadFailCount)}];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUploadCount) name:@"uploadFailNotification" object:nil];
    self.uploadFailBtn.hidden = YES;
}
- (void)setIsShowAddBtn:(BOOL)isShowAddBtn
{
    _isShowAddBtn = isShowAddBtn;
    if (_isShowAddBtn) {
        self.addPhotoButton.hidden = NO;
    }else{
        self.addPhotoButton.hidden = YES;
        self.topViewConst.constant = 15;
        [self layoutIfNeeded];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)changeUploadCount
{
    NSInteger count = [CGAlbumSQLManager shareInstance].uploadFailCount;
    if (count > 0) {
        self.uploadFailBtn.hidden = NO;
        [self.uploadFailBtn setTitle:[NSString stringWithFormat:@"%zd",count] forState:UIControlStateNormal];
        self.uploadFailBtn.titleLabel.text = [NSString stringWithFormat:@"%zd",count];
        self.uploadFailBtn.enabled = NO;
        [self.uploadFailBtn layoutIfNeeded];
    }else{
        self.uploadFailBtn.hidden = YES;
        self.uploadFailBtn.enabled = YES;
    }
    
}
- (void)setIsShowUploadBtn:(BOOL)isShowUploadBtn
{
    _isShowUploadBtn = isShowUploadBtn;
    if(_isShowUploadBtn){
        self.uploadFailBtn.hidden = NO;
        [self.uploadFailBtn setTitle:[NSString stringWithFormat:@"%zd",self.uploadBtnFailCount] forState:UIControlStateNormal];
    }else{
        self.uploadFailBtn.hidden = YES;
    }
}

- (void)setModel:(CGAlbumModel *)model
{
    _model = model;
    if (_model.type == 1 || _model.isOther) {
        self.perssionBtn.hidden = YES;
        self.giftBtn.hidden = YES;
    }else{
        self.perssionBtn.hidden = NO;
        self.giftBtn.hidden  = NO;
        [self.perssionBtn setTitle:_model.pessionDesc forState:UIControlStateNormal];
    }
    if (model.album_status == 0) {
        self.isLegaLable.hidden = NO;
        self.isLegaLable.text = model.audit_remark;
    }else{
        self.isLegaLable.hidden = YES;
    }
   
    if (_model.cover_status == 0 && _model.album_name != nil) {  // 违规封面
        self.coverView.hidden = NO;
        if (IOS_8_0) {
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
            effectview.frame = CGRectMake(0, 0, kScreenWidth, self.coverView.height);
            [self.coverImageIV addSubview:effectview];
        }else{
            self.coverView.alpha = 0.95;
        }
        //self.coverViewTitle.text = model.album_name;
      
    }else{
        // 设置封面
        [self.coverImageIV sd_setImageWithURL:[NSURL URLWithString:model.cover_photo_url] placeholderImage:[UIImage imageNamed:@"album_6_8_picture"]];
        self.coverView.hidden = YES;
    }

    self.isLegaLable.text = _model.audit_remark;

    self.albumDesLabel.text = model.album_remark;
    self.titleLable.text  = model.album_name;
        [self.giftBtn setTitle:[NSString stringWithFormat:@"%zd",_model.gift_count] forState:UIControlStateNormal];
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd",_model.amaze_count] forState:UIControlStateNormal];
}



/**
 *  添加照片点击事件
 */
- (IBAction)addPhotoClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(didAddPhotoClick:)]){
        [self.delegate didAddPhotoClick:self];
    }
}

/**
 *  上传失败点击事件
 */
- (IBAction)uploadFailClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(didUploadFailClick:)]){
        [self.delegate didUploadFailClick:self];
    }
}
@end
