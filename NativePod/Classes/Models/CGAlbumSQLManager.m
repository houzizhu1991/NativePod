//
//  AlbumSQLManager.m
//  FMDBCS
//
//  Created by duxiaoqiang on 16/7/12.
//  Copyright © 2016年 professional. All rights reserved.
//

#import "CGAlbumSQLManager.h"
#import "FMDB.h"
#import "CGPhotoModel.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CGAlbumSQLManager()
@property (nonatomic,strong) FMDatabaseQueue *dbQueue;
@property (nonatomic,strong) FMDatabase *db;
@end

@implementation CGAlbumSQLManager

+ (instancetype)shareInstance
{
    static CGAlbumSQLManager *instence;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      instence = [[self alloc]init];
                  });
    
    return instence;
}

- (BOOL)openDBWithFileName:(NSString *)fileName dbName:(NSString *)dbName
{
    if (dbName == nil)return NO;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    if (fileName != nil) {
        docPath = [docPath stringByAppendingPathComponent:fileName];
    }
    NSError * error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:docPath]) { // 如果不存在该文件则去创建
      [[NSFileManager defaultManager] createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    
    if (error) {
        NSLog(@"%@",[error description]);
        return NO;
    }
    
    NSString *dbPath = [docPath stringByAppendingPathComponent:dbName];
    _db = [FMDatabase databaseWithPath:dbPath];
    if (![_db open]) {
        NSLog(@"数据库打开失败");
    }
    if(!_dbQueue){
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    // 提供了一个多线程安全的数据库实例
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"CREATE TABLE if not exists t_Album (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,create_uid TEXT,album_id INTEGER,album_name TEXT,type INTEGER,photo_count INTEGER,amaze_count INTEGER,gift_count INTEGER,visible_type INTEGER,last_upload_name TEXT,cover_photo_url TEXT)"];
        
        [db executeUpdate:@"CREATE TABLE if not exists t_photo (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,uid TEXT,uploadAlbumId INTEGER,localIndenty TEXT,uploadStatus INTEGER,versionCode INTEGER,ossSuccessURL TEXT,albumType INTEGER,quality INTEGER,isPhotoUploading INTEGER)"];
        
    }];
    
    return YES;
}

#pragma  mark - 相册相关操作
- (BOOL)insertAlbum:(CGAlbumModel *)albumModel
{
    __weak typeof(self) weakSelf = self;
    __block BOOL ret = NO;
    
    // 先查询表是否存在，不存在插入否则更新
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sql = @"select count(*) t_Album where album_id =?";
        FMResultSet * result = [db executeQuery:sql,@(albumModel.album_id)];
        int totalCount = 0;
        if ([result next]) {
            totalCount = [result intForColumnIndex:0];
        }
        // 不存在数据
        if (totalCount == 0) {
            ret = [weakSelf inertAlbumEntity:albumModel db:db];
        }else{ // 更新相册操作
            ret = [weakSelf updateAlbumEntity:albumModel db:db];
        }
        
    }];
    return ret;
}

- (void)insertAlbumArray:(NSArray *)albumModelArr
{
    __weak typeof(self) weakSelf = self;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (CGAlbumModel * model  in  albumModelArr) {
            [weakSelf inertAlbumEntity:model db:db];
        }
    }];
}

- (BOOL)inertAlbumEntity:(CGAlbumModel *)albumModel db:(FMDatabase *)db
{
    NSString * sql = @"insert into t_Album(create_uid,album_id,album_name,type,photo_count,amaze_count,gift_count,visible_type,last_upload_name,cover_photo_url) values(?,?,?,?,?,?,?,?,?,?)";
   return  [db executeUpdate:sql,albumModel.create_uid,@(albumModel.album_id),albumModel.album_name,@(albumModel.type),@(albumModel.photo_count),@(albumModel.amaze_count),@(albumModel.gift_count),@(albumModel.visible_type),albumModel.last_upload_name,albumModel.cover_photo_url];

    
}

- (BOOL)updateAlbumEntity:(CGAlbumModel *)albumModel db:(FMDatabase *)db
{
    NSString * sql = @"update t_Album set create_uid=?,album_name = ?,photo_count =? ,amaze_count = ?,gift_count =?,visible_type =?,last_upload_name =?,cover_photo_url =? where album_id =?";
    return  [db executeUpdate:sql,albumModel.create_uid,albumModel.album_name,@(albumModel.photo_count),@(albumModel.amaze_count),@(albumModel.gift_count),@(albumModel.visible_type),albumModel.last_upload_name,albumModel.cover_photo_url,@(albumModel.album_id)];
    
    
}


- (BOOL)deleteAlbum:(NSInteger)albumId
{
    __block BOOL ret = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
       NSString * sql = @"delete from t_Album t where t.album_id = ?";
       ret =[db executeUpdate:sql,albumId];
    }];
    return ret;
}

#pragma mark - 照片相关操作

- (BOOL)insertPhoto:(CGPhotoModel *)photoModel
{
    __weak typeof(self) weakSelf = self;
    __block BOOL ret = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        ret = [weakSelf inertPhotoEntity:photoModel db:db];
    }];
    return ret;
}

- (void)insertPhotoArray:(NSArray *)photoModelArr
{
    __weak typeof(self) weakSelf = self;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (CGPhotoModel * model  in photoModelArr) {
            [weakSelf inertPhotoEntity:model db:db];
        }
    }];
}
- (BOOL)inertPhotoEntity:(CGPhotoModel *)photoModel db:(FMDatabase *)db
{
    NSString * sql = @"insert into t_photo(uid,uploadAlbumId ,localIndenty ,uploadStatus ,versionCode, ossSuccessURL,albumType,quality,isPhotoUploading) values(?,?,?,?,?,?,?,?,?)";
    return  [db executeUpdate:sql,photoModel.uid,@(photoModel.uploadAlbumId),photoModel.localIndenty,@(photoModel.uploadStatus),photoModel.versionCode,photoModel.ossSuccessURL,@(photoModel.albumType),@(photoModel.quality),@(0)];
}

- (void)deletePhoto:(NSString *)localIndenty
{
 
        [_dbQueue inDatabase:^(FMDatabase *db) {
            NSString * sql = @"delete from t_photo  where localIndenty = ?";
            [db executeUpdate:sql,localIndenty];
        }];
    
}

- (BOOL)deletePhotoByAlbumId:(NSInteger)albumId
{
    __block BOOL ret = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sql = @"delete from t_photo  where uploadAlbumId = ?";
        ret =[db executeUpdate:sql,@(albumId)];
    }];
    return ret;
}
- (BOOL)updatePhotoStatus:(NSInteger)status withOssUrl:(NSString *)ossUrl  withlocalIndenty:(NSString *)localIndenty
{
    NSString * sql =@"";
    if (ossUrl == nil) {
        sql = @"update t_photo set uploadStatus = ? where localIndenty = ?";
    }else{
        sql = @"update t_photo set uploadStatus = ?, ossSuccessURL =? where localIndenty = ?";
    }
    __block BOOL ret = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        if (ossUrl == nil) {
            ret = [db executeUpdate:sql,@(status),localIndenty];
        }else{
            ret = [db executeUpdate:sql,@(status),ossUrl,localIndenty];
        }
        
    }];
    return ret;
}
- (BOOL)updatePhotoUploading:(NSInteger)status withAlbumId:(NSInteger)albumId
{
    NSString * sql = @"update t_photo set isPhotoUploading = ? where uploadAlbumId = ?";

    __block BOOL ret = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdate:sql,@(status),@(albumId)];
    }];
    return ret;
}

- (NSMutableArray *)getPhotoByUid:(NSString *)uid whitAlbumType:(NSInteger )albumType
{
    NSString *sql =@"select *from t_photo where uid =? and albumType =? ";
    NSMutableArray * nativeArray = [NSMutableArray array];
    FMResultSet *result = [_db executeQuery:sql,uid,@(albumType)];
    while (result.next) {
        CGPhotoModel * model = [[CGPhotoModel alloc]init];
        model.uploadStatus = [result intForColumn:@"uploadStatus"];
        model.uploadAlbumId = [result intForColumn:@"uploadAlbumId"];
        model.localIndenty = [result stringForColumn:@"localIndenty"];
        model.versionCode = [result stringForColumn:@"versionCode"];
        model.quality     = [result intForColumn:@"quality"];
        if (![model.localIndenty hasPrefix:@"assets-library"]) {
           model.passet = [[PHAsset fetchAssetsWithLocalIdentifiers:@[[result stringForColumn:@"localIndenty"]] options:nil] firstObject];
        }
        [nativeArray addObject:model];
    }
    return nativeArray;
}

- (NSMutableArray *)getPhotoByAlbumIdAndUid:(NSInteger)albumId whitUid:(NSString *)uid
{
    NSString *sql =@"select *from t_photo where uid =? and uploadAlbumId =?";
    NSMutableArray * nativeArray = [NSMutableArray array];
    FMResultSet *result = [_db executeQuery:sql,uid,@(albumId)];
    while (result.next) {
        CGPhotoModel * model = [[CGPhotoModel alloc]init];
        model.uploadStatus = [result intForColumn:@"uploadStatus"];
        model.uploadAlbumId = [result intForColumn:@"uploadAlbumId"];
        model.localIndenty = [result stringForColumn:@"localIndenty"];
        model.versionCode = [result stringForColumn:@"versionCode"];
        model.quality     = [result intForColumn:@"quality"];
        model.isSecondUpload = YES;
        if (![model.localIndenty hasPrefix:@"assets-library"]) {
             model.passet = [[PHAsset fetchAssetsWithLocalIdentifiers:@[[result stringForColumn:@"localIndenty"]] options:nil] firstObject];
        }
        [nativeArray addObject:model];
    }
    return nativeArray;
}
- (BOOL)isLastVercode:(NSString *)versionCode
{
    NSString *sql = @"select count(*) from t_photo where versionCode =? and uploadStatus != ?";
    FMResultSet *result = [_db executeQuery:sql,versionCode,@(PhotoUploadStatus_fail)];
    BOOL isSuccess = NO;
    while (result.next) {
        int count = [result intForColumnIndex:0];
        if(count == 1)
        {
            isSuccess = YES;
        }
    }
    return isSuccess;

}
@end
