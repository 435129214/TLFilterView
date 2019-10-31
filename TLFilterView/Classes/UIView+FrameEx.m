//
//  UIView+FrameEx.m
//  terminal-ios-sichuan
//
//  Created by 李轶群 on 16/1/7.
//  Copyright © 2016年 szg. All rights reserved.
//

#import "UIView+FrameEx.h"

@implementation UIView (FrameEx)
- (void)setX:(CGFloat)x {
  CGRect frame = self.frame;
  frame.origin.x = x;
  self.frame = frame;
}

- (void)setY:(CGFloat)y {
  CGRect frame = self.frame;
  frame.origin.y = y;
  self.frame = frame;
}

-(void) setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom + self.frame.size.height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
  CGPoint center = self.center;
  center.x = centerX;
  self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
  CGPoint center = self.center;
  center.y = centerY;
  self.center = center;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)centerX {
  return self.center.x;
}

- (CGFloat)centerY {
  return self.center.y;
}

- (CGFloat)x {
  return self.frame.origin.x;
}

- (CGFloat)y {
  return self.frame.origin.y;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setWidth:(CGFloat)width {
  CGRect frame = self.frame;
  frame.size.width = width;
  self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}

- (CGFloat)width {
  return self.frame.size.width;
}

- (CGFloat)height {
  return self.frame.size.height;
}

-(CGFloat) top{
    return self.frame.origin.y;
}

-(CGFloat) right{
    return self.frame.origin.x + self.frame.size.width;
}


-(CGFloat) bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGSize)size {
  return self.frame.size;
}

- (CGPoint)origin {
  return self.frame.origin;
}

- (void)setSize:(CGSize)size {
  CGRect frame = self.frame;
  frame.size = size;
  self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
  CGRect frame = self.frame;
  frame.origin = origin;
  self.frame = frame;
}

- (void)removeAllSubviews {
  for (UIView *view in self.subviews) {
    [view removeFromSuperview];
  }
}
@end
