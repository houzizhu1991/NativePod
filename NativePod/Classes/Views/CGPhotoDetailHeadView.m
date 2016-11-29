//
//  CGPhotoDetailHeadView.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/11.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGPhotoDetailHeadView.h"

@implementation CGPhotoDetailHeadView
+ (instancetype)headView{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CGPhotoDetailHeadView class]) owner:nil options:nil] lastObject];
}


@end
