//
//  FilterTableViewCell.h
//  NewFrameTest
//
//  Created by liyanlei on 2017/5/26.
//  Copyright © 2017年 szg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterCollectionCell.h"
#import "TLEqualSpaceFlowLayout.h"

@interface FilterTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,TLEqualSpaceFlowLayoutDelegate>
{
    UICollectionView *filterCollectionView;
}

@property(nonatomic, strong) TLEqualSpaceFlowLayout *flowLayout;

@property(nonatomic, strong) NSDictionary *dataDic;

@property(nonatomic, assign) BOOL isMulSelected;//是否可以多选

@property(nonatomic, strong) NSArray *filterDataArr;

@property(nonatomic, strong)NSMutableArray *chooseArr;

@property(nonatomic, strong) void(^ClickItem)(id item, NSDictionary *dic);

-(id) GetChooseItem;

-(void) ResetChoose:(BOOL) reset;

@end
