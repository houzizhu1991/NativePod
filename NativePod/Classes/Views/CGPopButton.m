//
//  CGPopButton.m
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/28.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import "CGPopButton.h"
#import "UIView+Extension.h"

@implementation CGPopButton

//-(CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    CGFloat imageWH = 32;
//    return CGRectMake(self.titleLabel.frame.origin.x-45, 0, imageWH, imageWH);
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageWH = 32;
    if (self.imageView.image.size.height == 100 && [self.titleLabel.text hasSuffix:@"信息未读"]) {
              //self.imageView.frame = CGRectMake(self.titleLabel.x , 0, imageWH, imageWH);
        self.imageView.frame = CGRectMake(self.titleLabel.frame.origin.x-60, 0, imageWH, imageWH);
        self.imageView.layer.cornerRadius = 5;
        self.titleLabel.x = self.titleLabel.x - 15;
        

    }else{
        if ([self.titleLabel.text hasSuffix:@"信息未读"]) { 
            self.imageView.width = imageWH;
            self.imageView.height = imageWH;
        }else{
            self.imageView.size = CGSizeZero;
            self.titleLabel.centerX = self.centerX;
        }
    }
    
}
@end
