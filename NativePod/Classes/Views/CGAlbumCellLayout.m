//
//  CGAlbumCellLayout.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/6.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGAlbumCellLayout.h"

@implementation CGAlbumCellLayout

- (void)prepareLayout
{
    // 计算宽度
    CGFloat margin = 2;
    CGFloat itemWH = (kScreenWidth - margin) / 2;
    self.itemSize = CGSizeMake(itemWH, itemWH);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0); //设置item的内边距
    self.collectionView.showsVerticalScrollIndicator = NO;
}
@end
