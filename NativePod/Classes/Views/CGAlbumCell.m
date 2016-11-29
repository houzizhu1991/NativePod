//
//  CGAlbumCell.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/6.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGAlbumCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+Custom.h"
#import "UIView+Extension.h"

@interface CGAlbumCell()
@property (weak, nonatomic) IBOutlet UIView *firstView;

@property (weak, nonatomic) IBOutlet UIView *defaultView;
@property (weak, nonatomic) IBOutlet UIButton *showPermissionButton;  // 显示权限
@property (weak, nonatomic) IBOutlet UIImageView *albumCoverIV;  // 相册封面
@property (weak, nonatomic) IBOutlet UIButton *likeButton; // 点赞按钮
@property (weak, nonatomic) IBOutlet UIButton *giftButton; // 礼物按钮

@property (weak, nonatomic) IBOutlet UILabel *updateTipLabel;
// 谁更新了班级相册提示

@property (weak, nonatomic) IBOutlet UIButton *deleteButton; // 删除按钮

@property (weak, nonatomic) IBOutlet UILabel *albumNameCountLabel; // 相册名
@property (weak, nonatomic) IBOutlet UILabel *albumCountLabel;

@property (weak, nonatomic) IBOutlet UIView *coverView; // 相册覆盖页面
@property (weak, nonatomic) IBOutlet UILabel *coverDescLabel;

@property (weak, nonatomic) IBOutlet UIView *imageCoverView;  // 图片下面的背景颜色
@end
@implementation CGAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.showPermissionButton setButtonTitleShadow];
    [self.giftButton setButtonTitleShadow];
    [self.likeButton setButtonTitleShadow];
    self.updateTipLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.updateTipLabel.layer.shadowOffset = CGSizeMake(0, 2);
    self.updateTipLabel.layer.shadowOpacity = 1;
    self.albumCoverIV.contentMode = UIViewContentModeScaleAspectFill;
    self.albumCoverIV.clipsToBounds = YES;
    
}
- (void)setIsFirst:(BOOL)isFirst
{
    _isFirst = isFirst;
    if (_isFirst) {
        _firstView.hidden = NO;
        _defaultView.hidden = YES;
    }else{
        _firstView.hidden = YES;
        _defaultView.hidden = NO;
    }
}
/**
 *  如果是班级界面隐藏部分标签
 */
- (void)setIsFromClass:(BOOL)isFromClass
{
    _isFromClass = isFromClass;
    if(_isFromClass){
        self.showPermissionButton.hidden = YES;
        self.giftButton.hidden = YES;
        self.updateTipLabel.hidden = NO;
    }else{
        self.showPermissionButton.hidden = NO;
        self.giftButton.hidden = NO;
        self.updateTipLabel.hidden = YES;
    }
    if (self.isManager) {
        self.deleteButton.hidden = NO;
    }else{
        self.deleteButton.hidden = YES;
    }
}

- (void)setIsOther:(BOOL)isOther
{
    _isOther = isOther;
    if(_isOther){
        self.deleteButton.hidden = YES;
        self.showPermissionButton.hidden = YES;
        self.updateTipLabel.hidden = YES;
    }else{
        self.deleteButton.hidden = NO;
        self.showPermissionButton.hidden = NO;
        self.updateTipLabel.hidden = NO;
    }
}
//album_6_8_picture
- (void)setAlbumModel:(CGAlbumModel *)albumModel
{
    _albumModel = albumModel;
    
    // 设置封面
    [self.albumCoverIV sd_setImageWithURL:[NSURL URLWithString:albumModel.cover_photo_url] placeholderImage:[UIImage imageNamed:@"album_6_8_picture"]];
        // 违规相册
        if (albumModel.album_status == 0) {
            self.coverView.hidden = NO;
            self.albumNameCountLabel.text = @"********";
            self.albumCountLabel.text = @"";
        }else{
            
            self.coverView.hidden = YES;
            //设置相册名和数量
            self.albumNameCountLabel.text = [NSString stringWithFormat:@"%@",albumModel.album_name];
            self.albumCountLabel.text = [NSString stringWithFormat:@"(%zd)",albumModel.photo_count];
        }
        // 违规封面
        if(albumModel.cover_status == 0)
        {
            self.coverView.hidden = NO;
            self.coverDescLabel.text = @"该图片涉嫌违规";
            // 违规封面
            if (self.isShowCover) {
                if (IOS_8_0) {
                    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
                    effectview.frame = CGRectMake(0, 0, self.width, self.height);
                    [self.albumCoverIV addSubview:effectview];
                }else{
                    //self.coverView.alpha = 0.95;
                    UIView  *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
                    backView.backgroundColor = [UIColor blackColor];
                    [self.albumCoverIV addSubview:backView];
                }
            }else{
                for (UIView * tempView  in  self.albumCoverIV.subviews) {
                    [tempView removeFromSuperview];
                }
            }
        }else{
            
            for (UIView * tempView  in  self.albumCoverIV.subviews) {
                [tempView removeFromSuperview];
            }
        }
    // 设置赞
    [self.likeButton setTitle:[NSString stringWithFormat:@"%zd",albumModel.amaze_count] forState:UIControlStateNormal];

    if (_isFromClass) {  // 班级相册
       if([albumModel.last_upload_name isBlankString])
       {
           _updateTipLabel.text = @"";
       }else{
           _updateTipLabel.text = albumModel.last_upload_name;
       }
        
    }else if(_isOther){ // 查看他人相册
        [self.giftButton setTitle:[NSString stringWithFormat:@"%zd",albumModel.gift_count] forState:UIControlStateNormal];
    }else{ // 个人相册
        // 设置权限
        [self.showPermissionButton setTitle:albumModel.pessionDesc forState:UIControlStateNormal];
        [self.giftButton setTitle:[NSString stringWithFormat:@"%zd",albumModel.gift_count] forState:UIControlStateNormal];
    }
}


- (IBAction)deleteAlbumClick:(id)sender{
    if(self.block)
    {
        self.block(self.albumModel.album_id);
    }
}

- (void)deleteAlbum:(DealDeleteAlbumBlock)block
{
    _block = block;
}
@end
