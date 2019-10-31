//
//  UIView+FrameEx.h
//  terminal-ios-sichuan
//
//  Created by 李轶群 on 16/1/7.
//  Copyright © 2016年 szg. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  直接用点语法获取修改UIView的属性
 */
@interface UIView (FrameEx)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat right;
//left其实就等于x
@property (nonatomic, assign) CGFloat left;

- (void)removeAllSubviews;
@end
