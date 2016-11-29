//
//  CGMyMessageCell.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/21.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMyMessageModel.h"
@interface CGMyMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIImageView *detailIV;

@property (weak, nonatomic) IBOutlet UIView *giftView;

@property (weak, nonatomic) IBOutlet UIImageView *giftIV;

@property (weak, nonatomic) IBOutlet UILabel *giftDesc;

@property (weak, nonatomic) IBOutlet UIButton *giftButton;
@property (nonatomic,strong) CGMyMessageModel  *model;

@property (nonatomic,strong) void (^iconClickBlock)();  // 头像点击block

@property (nonatomic,strong) void (^giftClickBlock)();  // 礼物点击block
@end
