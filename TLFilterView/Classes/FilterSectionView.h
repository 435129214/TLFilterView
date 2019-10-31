//
//  FilterSectionView.h
//  NewFrameTest
//
//  Created by liyanlei on 2017/5/26.
//  Copyright © 2017年 szg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLFilterCommonHeader.h"

@interface FilterSectionView : UIView

@property(nonatomic,strong) UILabel *typeName;
@property(nonatomic,strong) UIButton *openBtn;
@property(nonatomic,strong) UILabel *chooseName;

-(void) SetOpen:(BOOL)isOpen;

@end
