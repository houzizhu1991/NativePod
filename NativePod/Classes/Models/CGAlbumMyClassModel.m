//
//  CGAlbumMyClassModel.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/15.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGAlbumMyClassModel.h"

@implementation CGAlbumMyClassModel

- (NSString *)name
{
    if (_name.length >0) {
        NSString * tempName = @"";
        if (_class_remark.length >0) {
            tempName = [NSString stringWithFormat:@"%@(%@)",_name,_class_remark];
        }else{
            tempName = _name;
        }
        return tempName;
    }else {
        return _class_remark;
    }
}
- (NSString *)school_name
{
    if ([_school_name isBlankString]) {
        return @"";
    }
    return  _school_name;
}
@end
