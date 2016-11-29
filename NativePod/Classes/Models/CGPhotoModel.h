//
//  CGPhotoModel.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/12.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CGPhotoModel : NSObject

//****************************服务器数据库字段*********************//

@property (nonatomic, strong) NSString *name;   // 发布人的显示名字

@property (nonatomic, assign) NSInteger create_uid ; // 创建人uid

@property (nonatomic, copy) NSString *photo_url; // 图片地址

@property (nonatomic, copy) NSString *photo_thumbnail_url; // 图片缩略图地址

@property (nonatomic, copy) NSString *album_photo_remark;  // 照片描述

@property (nonatomic, assign) NSInteger photo_resource ;   // 照片来源 （1，原创，2转载）

@property (nonatomic, copy) NSString *img; // 发布人头像

@property (nonatomic, copy) NSString *personal_signature; // 个性签名

@property (nonatomic, copy) NSString *real_name; // 发布人名字

@property (nonatomic, copy) NSString *nick_name; // 发布人昵称

@property (nonatomic, copy) NSString *remark; // 发布人备注

@property (nonatomic, copy) NSString *img_thumbnail; //发布人头像缩略图

@property (nonatomic, assign) NSInteger is_legal ; /// 是否违规 1，正常 0，违规

@property (nonatomic, assign) NSInteger album_photo_id ; // 照片id

@property (nonatomic, assign) NSInteger amazing_count ; // 赞数

@property (nonatomic, assign) NSInteger comment_count ; // 评论数

@property (nonatomic, assign) NSInteger gift_count ; // 礼物数

@property (nonatomic, assign) NSInteger  transfer_count; // 转载数量
@property (nonatomic, assign) NSInteger  remark_status; // 照片描述审核状态（0、待审，1、通过，2、不通过）
@property (nonatomic, assign) BOOL gift_status; // 我是否已经赠送礼物
@property (nonatomic, copy) NSString *create_time;   // 创建时间
@property (nonatomic,assign) NSInteger photo_status ; // 是否违规 1，正常 0，违规
@property (nonatomic,copy)  NSString *photo_remark;  // 照片描述
@property (nonatomic,copy)  NSString *upload_name;


@property (nonatomic, strong) id passet;    // 记录本地相册
@property (nonatomic, assign) NSInteger status ;  // 记录本地状态 状态, 默认: 0 等待上传,1 正在上传，2 上传失败,3 上传成功
@property (nonatomic, assign) NSInteger quality ; //  质量
@property (nonatomic, strong) NSString *audit_remark; // 审核意见

/**
 *  点赞列表
 */
@property (nonatomic, strong) NSArray *AlbumAmazingList;
/**
 *  评论列表
 */
@property (nonatomic, strong) NSArray *AlbumCommentsList;
@property (nonatomic,copy) NSString * isRepeateFlag;  // 是否重复上传标志

@property (nonatomic, strong) NSString *is_amazed;  // 是否已点赞

@property (nonatomic, assign) CGFloat  progress; // 记录上传进度
@property (nonatomic, assign) NSInteger album_id; // 相册id
@property (nonatomic, assign) NSInteger class_id; // 班级id


//****************************本地数据库表需要增加的字段,目的就是记录上传失败的情况*********************//

@property (nonatomic, assign) BOOL  isSecondUpload ;     // 标识是否是本地上传失败后，第二次进入页面
@property (nonatomic,strong) NSString *uid;              // 图片是哪个用户上传
@property (nonatomic,copy)   NSString *versionCode;      // 记录码用于判断上传成功 uuid记录
@property (nonatomic,copy)   NSString *localIndenty;     // 本地图片的唯一标识
@property (nonatomic,assign) NSInteger uploadAlbumId;    // 上传相册的Id
@property (nonatomic,assign) NSInteger uploadStatus ;    // 上传状态: 0 未上传，1 正在上传 , 2上传失败  3 上传成功， 4 已同步到服务器


// TO DO 
@property (nonatomic, copy)  NSString *ossSuccessURL;    // oss上传成功，未同步到服务器
@property (nonatomic, assign) NSInteger albumType ;      // 相册类型，0表示个人相册，1表示班级相册
@property (nonatomic, assign) NSInteger isPhotoUploading ; // 0 表示默认， 1 表示正在上传中

@property (nonatomic, assign) BOOL isUploadForOtherVC ;  // 用于标识是否上传

//@property (nonatomic,copy)   NSString *uploadSuccessUrl;  // 上传成功后的url

@end
