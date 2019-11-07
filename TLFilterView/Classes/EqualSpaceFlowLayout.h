//
//  EqualSpaceFlowLayout.h
//  UICollectionViewDemo
//
//  Created by CHC on 2018/8/9
//  Copyright (c) 2018年 CHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  EqualSpaceFlowLayoutDelegate<UICollectionViewDelegateFlowLayout>
@end

@interface EqualSpaceFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,weak) id<EqualSpaceFlowLayoutDelegate> delegate;
@end
