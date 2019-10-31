//
//  TLFilterCommonHeader.h
//  Masonry
//
//  Created by liyanlei1 on 2019/10/28.
//

#import <Foundation/Foundation.h>

#import "UIView+FrameEx.h"
#import <Masonry/Masonry.h>
#import "FilterConfigure.h"

#define FilterScreenW [UIScreen mainScreen].bounds.size.width

/************************自定义weak-strong-dance****START*************************/
/**
 
 * 强弱援用转换，用于处理代码块（block）与强援用self之间的循环援用题目
 * 挪用方法: `@weakify_self`完成弱援用转换，`@strongify_self`完成强援用转换
 * 示例：
 * @weakify_self
 * [obj block:^{
 *      @strongify_self
 *      self.property = something;
 * }];
 
 */

#ifndef    weakify_self

#if __has_feature(objc_arc)

#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;

#else

#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;

#endif

#endif

#ifndef    strongify_self

#if __has_feature(objc_arc)

#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;

#else

#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;

#endif

#endif

#define if_self_is_nil_return try{} @finally{} if(!self){return ;} ;
/************************自定义weak-strong-dance****END*************************/


#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif
#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
