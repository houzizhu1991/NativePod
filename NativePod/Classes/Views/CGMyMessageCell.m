//
//  CGMyMessageCell.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/21.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGMyMessageCell.h"
#import "UIImageView+WebCache.h"

@implementation CGMyMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.detailIV.contentMode = UIViewContentModeScaleAspectFill;
    self.detailIV.clipsToBounds = YES;
}

- (void)setModel:(CGMyMessageModel *)model
{
    _model = model;
    if ([model.gift_url isBlankString]) {
        self.giftView.hidden = YES;
        self.descLabel.hidden = NO;
        self.giftButton.hidden = YES;
        self.descLabel.text = _model.context;
    }else{
        self.giftView.hidden = NO;
        self.descLabel.hidden = YES;
        self.giftButton.hidden = NO;
        [self.giftIV sd_setImageWithURL:[NSURL URLWithString:_model.gift_url]];
        self.giftDesc.text = _model.context;
    }
    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:_model.head_url] placeholderImage:[UIImage imageNamed:@"v3_contact_member"]];
    [self.detailIV sd_setImageWithURL:[NSURL URLWithString:self.model.photo_url] placeholderImage:[UIImage imageNamed:@"v3_contact_member"]];
     self.nameLabel.text = _model.from_name;

}

- (IBAction)iconClick:(id)sender {
    if (self.iconClickBlock) {
        self.iconClickBlock();
    }
}

- (IBAction)giftClick:(id)sender {
    if (self.giftClickBlock) {
        self.giftClickBlock();
    }
}

@end
