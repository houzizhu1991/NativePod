//
//  AlbumSQLManager.h
//  FMDBCS
//
//  Created by duxiaoqiang on 16/7/12.
//  Copyright © 2016年 professional. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGAlbumModel.h"
#import "CGPhotoModel.h"

@interface CGAlbumSQLManager : NSObject

@property (nonatomic,assign) NSInteger uploadFailCount ; // 记录上传失败的数量

@property (nonatomic,assign) NSInteger uploadComplete ; // 记录某次上传完成数量

@property (nonatomic,assign) NSInteger uploadFailComplete ; // 记录上传失败界面数量
@property (nonatomic,strong) NSArray *uploadImages; //记录上传操作次数

@property (nonatomic,assign) BOOL isUploading ;  

@property (nonatomic,strong) NSMutableArray *progressArray;
/**
 * 单例获取对象
 */
+ (instancetype)shareInstance;
/**
 *  打开数据数据库
 *
 *  @param fileName  文件名  可以为nil，为nil时默认存放在Document下
 *  @param dbName    数据名不能为空
 */
- (BOOL)openDBWithFileName:(NSString *)fileName dbName:(NSString *)dbName;
/**
 *  插入单挑相册数据
 *
 *  @param model 相册数据模型
 */
- (BOOL)insertAlbum:(CGAlbumModel *) albumModel;

/**
 *  插入多条相册数据
 *
 *  @param model 相册数据模型数组
 */
- (void)insertAlbumArray:(NSArray *) albumModelArr;

/**
 *  删除一条相册数据
 */
- (BOOL)deleteAlbum:(NSInteger )albumId;


#pragma mark - 照片数据库相关操作

/**
 *  插入单条照片数据
 *
 *  @param model 照片数据模型
 */
- (BOOL)insertPhoto:(CGPhotoModel *) photoModel;
/**
 *  插入多条照片数据
 *
 *  @param model 相册数据模型数组
 */
- (void)insertPhotoArray:(NSArray *) photoModelArr;
/**
 *  删除一条照片数据
 */
- (void)deletePhoto:(NSString* )localIndenty;
/**
 *  删除多条照片数据
 */
- (BOOL)deletePhotoByAlbumId:(NSInteger )albumId;
/**
 *  根据照片id 来更新照片相关数据
 *
 *  @param status 更新状态
 *  @paran ossUrl 为nil 只更新状态
 *  @return 更新结果
 */
- (BOOL)updatePhotoStatus:(NSInteger )status withOssUrl:(NSString *)ossUrl withlocalIndenty:(NSString *)localIndenty;

- (BOOL)updatePhotoUploading:(NSInteger)status withAlbumId:(NSInteger)albumId;
/**
 *  通过相册id和uid获取数据
 *
 *  @param albumId albumId
 *  @param uid     用户id
 *
 *  @return 查询出来的数组
 */
- (NSMutableArray *)getPhotoByAlbumIdAndUid:(NSInteger )albumId whitUid:(NSString *)uid;
/**
 *  通过uid获取所有未上传成功的照片信息
 *
 *  @return 未上传成功后的数组
 */
- (NSMutableArray *)getPhotoByUid:(NSString *)uid whitAlbumType:(NSInteger )albumType;

/**
 *  查询本地数据库，看是否是最后一个
 *
 *  @param versionCode versionCode
 */
- (BOOL)isLastVercode:(NSString *)versionCode;

@end
