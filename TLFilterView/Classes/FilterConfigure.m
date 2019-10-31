//
//  FilterConfigure.m
//  Masonry
//
//  Created by liyanlei1 on 2019/10/28.
//

#import "FilterConfigure.h"


@implementation FilterConfigure

+(instancetype) shareInstance
{
    static FilterConfigure *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[FilterConfigure alloc] init];
       
        config.resetTextColor = [UIColor blackColor];
        config.resetBgColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        
        
        config.ensureTextColor = [UIColor whiteColor];
        config.ensureBgColor = [UIColor colorWithRed:57/255.0 green:152/255.0 blue:247/255.0 alpha:1];
        
        config.normalTextColor = [UIColor blackColor];
        config.normalBgColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        
        
        config.chooseBgColor = [UIColor colorWithRed:228/255.0 green:240/255.0 blue:253/255.0 alpha:1];
        config.chooseTextColor = [UIColor colorWithRed:57/255.0 green:152/255.0 blue:247/255.0 alpha:1];
        
        
        config.notEnableTextColor = [UIColor grayColor];
        config.notEnableBgColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        
        config.sectionNormalTextColor = [UIColor lightGrayColor];
        config.sectionChooseTextColor = [UIColor lightGrayColor];
        
        config.sectionTitleTextColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        
        config.filterItemFontSize = 14;
        config.sectionChooseFontSize = 14;
        config.sectionTitleFontSize = 14;
        
        config.showSectionChooseText = NO;
    });
    
    return config;
}

@end
