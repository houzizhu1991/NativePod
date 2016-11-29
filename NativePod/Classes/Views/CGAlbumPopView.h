//
//  CGAlbumPopView.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/11.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGAlbumPopViewCell.h"
typedef void(^deleteMsgBlock) ();
typedef void(^JumpClickBlock) (BOOL isJumpToUpload);
@interface CGAlbumPopView : UIView 
@property (nonatomic,copy) deleteMsgBlock block;
- (void)handleBlock:(deleteMsgBlock )block;

@property (nonatomic,copy) JumpClickBlock jumpblock;
- (void)jumpBlock:(JumpClickBlock )block;
@property (nonatomic,strong) NSMutableArray *messageList;
@property (nonatomic,strong) NSString *headImageUrl;  // 头像url
@end
