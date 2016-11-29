//
//  CGMyMessageModel.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/22.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGMyMessageModel : NSObject
@property (nonatomic,copy) NSString *head_url; // 发起人的头像URL

@property (nonatomic,copy) NSString *from_name; // 发起人姓名

@property (nonatomic,copy) NSString *context; // 内容

@property (nonatomic,copy) NSString *photo_url; // 相片URL

@property (nonatomic,assign) NSInteger album_photo_id ; // 跳转相册照片的id

@property (nonatomic,copy) NSString *gift_url; // 送礼物的礼物图片

@property (nonatomic,assign) NSInteger gift_id ; // 跳转礼物详情

@property (nonatomic,assign) NSInteger uid ;
@end
