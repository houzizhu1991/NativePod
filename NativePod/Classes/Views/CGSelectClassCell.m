//
//  CGSelectClassCell.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/11.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGSelectClassCell.h"
@interface CGSelectClassCell()
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *classNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUploadTipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showIconIV;
@end
@implementation CGSelectClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CGAlbumMyClassModel *)model
{
    _model = model;
    self.classNameLabel.text = model.name;
    self.classNumLabel.text = [NSString stringWithFormat:@"NO.%zd  %@",model.class_id,model.school_name];
    self.lastUploadTipLabel.text = model.last_upload_message;
    NSMutableArray * imgsArr = [NSMutableArray array];
    // 遍历图片数组
    for (NSDictionary *imgDict in model.imgs) {
        [imgsArr addObject:[imgDict objectForKey:@"img"]];
    }
    [self.showIconIV setImageWithImageUrlArray:imgsArr];
}

@end
