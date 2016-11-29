//
//  CGAlbumInfo.h
//  CenturyGuard
//  相册模型
//  Created by duxiaoqiang on 16/7/6.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGAlbumModel : NSObject
@property (nonatomic,copy)   NSString *create_uid;  // 相册创建人uid

@property (nonatomic,assign) NSInteger type ; // 相册类型 0个人相册 1班级相册

@property (nonatomic,assign) NSInteger album_id ; // 相册id

@property (nonatomic,copy)   NSString *album_name; // 相册名

@property (nonatomic,assign) NSInteger photo_count ; // 相册照片数量

@property (nonatomic,assign) NSInteger amaze_count ; // 赞数

@property (nonatomic,assign) NSInteger gift_count ; // 礼物数量

@property (nonatomic,assign) NSInteger visible_type ; // 可见类型标志  0自己可见 1亲朋友好可见 2所有人可见 3 所有人

@property (nonatomic,copy)   NSString *last_upload_name; // 班级相册时： 最近无更新是为空字符串 有内容为更新人名字  个人相册时：不显示

@property (nonatomic,copy)   NSString *cover_photo_url; // 封面照片url

@property (nonatomic,assign) NSInteger allow_all_republish ; // 是否允许转载

@property (nonatomic,assign) NSInteger allow_all_upload ;  // 是否允许所有人上传

@property (nonatomic,copy)   NSString *create_time;  // 相册创建时间

@property (nonatomic,assign) NSInteger class_id ; /// 个人相册的话为0 班级相册为班级id

@property (nonatomic,strong) NSString *album_remark; // 相册描述

@property (nonatomic,assign) NSInteger album_status ; // 相册是否违规  1，正常 0，违规

@property (nonatomic,copy) NSString * audit_remark; // 审核意见  (为原型图上面的 “该相册**、**涉嫌违规”，直接以字符串返回给你们)
@property (nonatomic,assign) NSInteger cover_status ;// 封面照片是否违规 1，正常 0，违规  为原型图上面的 “该图片涉嫌违规”
@property (nonatomic,assign) NSInteger can_be_edit ; //相册资料是否能够被编辑   1能  0不能  2能编辑 编辑后须提示 “修改已提交，请等待审核。如有疑问，请联系客服

@property (nonatomic,assign) NSInteger is_setting_back ; // 是否设置了封面 1，自己设置的封面  0，未设置封面

@property (nonatomic,assign) NSInteger cover_photo_create_uid ; // 封面图片上传者
//*******************增加多余字段************
@property (nonatomic, copy) NSString *pessionDesc;  // 0自己可见 1亲朋友好可见 2所有人可见 描述文字
@property (nonatomic,assign) BOOL isOther;

@end
