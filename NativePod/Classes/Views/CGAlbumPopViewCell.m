//
//  CGAlbumPopViewCell.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/19.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGAlbumPopViewCell.h"

@implementation CGAlbumPopViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //self.contentBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (void)setHeadImageUrl:(NSString *)headImageUrl
//{
//    _headImageUrl = headImageUrl;
//    if ([self.contentBtn.titleLabel.text hasSuffix:@"您有照片上传失败"] ) {
//        self.contentBtn.imageView.image = nil;
//    }else{
//        [self.contentBtn sd_setImageWithURL:[NSURL URLWithString:headImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"v3_contact_member"]];
//    }
//}

- (IBAction)deleteClick:(id)sender {
    self.lineLabel.hidden = YES;
    if (self.block) {
        self.block(self.descContent.text);
    }
}
- (void)handleDelete:(DeleteMsgBlock)block
{
    _block = block;
}

- (void)handleContentClick:(ContentMsgBlock)block
{
    _contentBlock = block;
}
- (IBAction)contentClick:(id)sender {
    if(self.contentBlock){
        self.contentBlock(self.descContent.text);
    }
}


@end
