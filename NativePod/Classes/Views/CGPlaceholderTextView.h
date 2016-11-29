//
//  CGPlaceholderTextView.h
//  CenturyGuard
//
//  Created by duxiaoqiang on 16/7/13.
//  Copyright © 2016年 sjyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
