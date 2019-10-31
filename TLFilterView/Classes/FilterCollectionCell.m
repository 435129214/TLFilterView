//
//  FilterCollectionCell.m
//  NewFrameTest
//
//  Created by liyanlei on 2017/5/26.
//  Copyright © 2017年 szg. All rights reserved.
//

#import "FilterCollectionCell.h"
#import "Masonry.h"

@implementation FilterCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.enable = YES;
        
        _filterData = [[UILabel alloc] init];
        [self addSubview:_filterData];
        [_filterData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(5);
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
        
        _filterData.font = [UIFont systemFontOfSize:[FilterConfigure shareInstance].filterItemFontSize];
        _filterData.layer.cornerRadius = 3;
        _filterData.layer.masksToBounds = YES;
//        _filterData.layer.borderWidth = 0.5;
        _filterData.textAlignment = NSTextAlignmentCenter;
//        _filterData.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

-(void) setStyle:(BOOL)chooseStyle text:(NSString *)text
{
    self.isChoosed = chooseStyle;
    _filterData.text = text;
    [self setStyle:chooseStyle];
}

-(void) setStyle:(BOOL)chooseStyle
{
    self.isChoosed = chooseStyle;
    if (chooseStyle) {
        _filterData.backgroundColor = [FilterConfigure shareInstance].chooseBgColor;
        _filterData.textColor = [FilterConfigure shareInstance].chooseTextColor;
//        _filterData.layer.borderColor = [UIColor redColor].CGColor;
    }
    else{
        _filterData.backgroundColor = [FilterConfigure shareInstance].normalBgColor;
        _filterData.textColor = [FilterConfigure shareInstance].normalTextColor;
//        _filterData.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

-(void) setEnable:(BOOL)enable
{
    _enable = enable;
    
    if (enable) {
        if(_isChoosed){
            _filterData.backgroundColor = [FilterConfigure shareInstance].chooseBgColor;
            _filterData.textColor = [FilterConfigure shareInstance].chooseTextColor;
//            _filterData.layer.borderColor = [UIColor redColor].CGColor;
        }
        else{
            _filterData.backgroundColor = [FilterConfigure shareInstance].normalBgColor;
            _filterData.textColor = [FilterConfigure shareInstance].normalTextColor;
//            _filterData.layer.borderColor = [UIColor whiteColor].CGColor;
        }
    }
    else{
        _filterData.textColor = [FilterConfigure shareInstance].notEnableTextColor;
        _filterData.backgroundColor = [FilterConfigure shareInstance].notEnableBgColor;
//        _filterData.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

@end
