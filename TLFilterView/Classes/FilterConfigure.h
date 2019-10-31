//
//  FilterConfigure.h
//  Masonry
//
//  Created by liyanlei1 on 2019/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterConfigure : NSObject

@property(nonatomic, strong) UIColor *chooseBgColor;
@property(nonatomic, strong) UIColor *normalBgColor;

@property(nonatomic, strong) UIColor *chooseTextColor;
@property(nonatomic, strong) UIColor *normalTextColor;

@property(nonatomic, strong) UIColor *notEnableTextColor;
@property(nonatomic, strong) UIColor *notEnableBgColor;

@property(nonatomic, strong) UIColor *sectionChooseTextColor;
@property(nonatomic, strong) UIColor *sectionNormalTextColor;

@property(nonatomic, strong) UIColor *sectionTitleTextColor;

@property(nonatomic, strong) UIColor *resetTextColor;
@property(nonatomic, strong) UIColor *resetBgColor;

@property(nonatomic, strong) UIColor *ensureTextColor;
@property(nonatomic, strong) UIColor *ensureBgColor;


@property(nonatomic, assign) CGFloat sectionTitleFontSize;
@property(nonatomic, assign) CGFloat sectionChooseFontSize;

@property(nonatomic, assign) CGFloat filterItemFontSize;

@property(nonatomic, assign) BOOL showSectionChooseText;

+(instancetype) shareInstance;

@end

NS_ASSUME_NONNULL_END
