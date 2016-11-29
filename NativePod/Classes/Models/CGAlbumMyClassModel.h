//
//  CGAlbumMyClassModel.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/15.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGAlbumMyClassModel : NSObject


@property (nonatomic, assign) NSInteger class_id ; // 班级id
@property (nonatomic, copy) NSString *name; // 班级名称，未绑定学校是为自定义名称，绑定学校后为学校设定的班级名称
@property (nonatomic, assign) NSInteger creator ; // 创建者id

@property (nonatomic, copy) NSString *creator_name; // 创建者姓名

@property (nonatomic, copy) NSString *creator_tel;  // 创建者电话

@property (nonatomic, copy) NSString *create_date;  // 创建时间

@property (nonatomic, copy) NSString *qr_code;

@property (nonatomic, copy) NSString *news;  // 公告

@property (nonatomic, copy) NSString *chatroom_user_count; // 班级人数

@property (nonatomic, assign) NSInteger user_identity ; // 0,群主 1,一级管理员 2二级管理员 3,普通成员

@property (nonatomic, assign) NSInteger vali_status ; // 提示房间认证情况0，未认证  1，已认证  -1，以提交认证

@property (nonatomic, copy) NSString *service_type; // 班级服务类型（1、使用积分服务，2、使用包月服务，多个以半角逗号分隔）

@property (nonatomic, assign) NSInteger school_id ; // 学校id

@property (nonatomic, copy) NSString *school_name; // 学校名

@property (nonatomic,strong) NSArray *imgs; // 返回的5个图片名

@property (nonatomic, assign) NSInteger mode_type ; // 免打扰模式  0正常 1免打扰

@property (nonatomic, copy) NSString *class_addr; // 班级地址

@property (nonatomic, assign) NSInteger version ; // 版本号
@property (nonatomic, copy) NSString *class_remark; // 班级昵称

@property (nonatomic, assign) NSInteger is_solid_school ;

@property (nonatomic, copy) NSString *last_upload_message; // 客户端根据这个时间 来显示****（用户名称）上传了新照片,


@end
