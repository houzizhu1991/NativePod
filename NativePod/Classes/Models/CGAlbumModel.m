//
//  CGAlbumInfo.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/6.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGAlbumModel.h"


@implementation CGAlbumModel


- (NSString *)pessionDesc
{
    if (_visible_type == 0) {
        return @"仅自己可见";
    }else if(_visible_type == 1){
        return @"家人与好友可见";
    }else{
        return @"所有人可见";
    }
}

@end
