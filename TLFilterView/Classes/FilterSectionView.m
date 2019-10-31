//
//  FilterSectionView.m
//  NewFrameTest
//
//  Created by liyanlei on 2017/5/26.
//  Copyright © 2017年 szg. All rights reserved.
//

#import "FilterSectionView.h"
#import "Masonry.h"

@implementation FilterSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        
//        _openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self addSubview:_openBtn];
//        [_openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(-10);
//            make.size.mas_equalTo(CGSizeMake(30, 30));
//            make.centerY.equalTo(self.mas_centerY);
//        }];
//        //图层-21-拷贝@2x
//        [_openBtn setImage:[UIImage imageNamed:@"图层-21-拷贝"] forState:UIControlStateNormal];
//
      
    }
    return self;
}

-(UILabel *)typeName{
    if(!_typeName)
    {
        _typeName = [[UILabel alloc] init];
        [self addSubview:_typeName];
        [_typeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(5);
            //            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
        _typeName.font = [UIFont systemFontOfSize:[FilterConfigure shareInstance].sectionTitleFontSize];
        _typeName.textColor = [FilterConfigure shareInstance].sectionTitleTextColor;
    }
    return _typeName;
}

-(UILabel *)chooseName{
    if(!_chooseName)
    {
        _chooseName = [[UILabel alloc] init];
        [self addSubview:_chooseName];
        [_chooseName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeName.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(5);
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
        _chooseName.font = [UIFont systemFontOfSize:[FilterConfigure shareInstance].sectionChooseFontSize];
        _chooseName.textColor = [FilterConfigure shareInstance].sectionChooseTextColor;
        _chooseName.textAlignment = NSTextAlignmentRight;
    }
    return _chooseName;
}

-(void) SetOpen:(BOOL)isOpen
{
    if(isOpen)
    {
        [_openBtn setImage:[UIImage imageNamed:@"图层-21-展"] forState:UIControlStateNormal];
    }
    else
    {
        [_openBtn setImage:[UIImage imageNamed:@"图层-21-拷贝"] forState:UIControlStateNormal];
    }
}

@end
