//
//  CGAlbumPopViewCell.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/19.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGPopButton.h"
typedef void(^DeleteMsgBlock) (NSString* desc);
typedef void(^ContentMsgBlock) (NSString* desc);
@interface CGAlbumPopViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *contentBtn;
@property (nonatomic, copy)DeleteMsgBlock block ;
@property (nonatomic, copy)ContentMsgBlock contentBlock ;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (nonatomic,copy) NSString *headImageUrl;

@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *descContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *marginIconConst;

- (void) handleDelete:(DeleteMsgBlock )block;
- (void) handleContentClick:(ContentMsgBlock )block;
@end
