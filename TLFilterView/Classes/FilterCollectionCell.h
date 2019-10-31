//
//  FilterCollectionCell.h
//  NewFrameTest
//
//  Created by liyanlei on 2017/5/26.
//  Copyright © 2017年 szg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLFilterCommonHeader.h"

@interface FilterCollectionCell : UICollectionViewCell

@property(nonatomic, assign) BOOL enable,isChoosed;

@property(nonatomic, strong) UILabel *filterData;
@property(nonatomic, strong) id item;

-(void) setStyle:(BOOL)chooseStyle text:(NSString *)text;

-(void) setStyle:(BOOL)chooseStyle;

@end
