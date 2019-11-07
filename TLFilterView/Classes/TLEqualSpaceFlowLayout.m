//
//  TLEqualSpaceFlowLayout.m
//  UICollectionViewDemo
//
//  Created by CHC on 2018/8/9
//  Copyright (c) 2018年 CHC. All rights reserved.
//

#import "TLEqualSpaceFlowLayout.h"

@interface TLEqualSpaceFlowLayout()
@property (nonatomic, strong) NSMutableArray *itemAttributes;
@end

@implementation TLEqualSpaceFlowLayout
- (id)init
{
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
        self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
    return self;
}

#pragma mark - Methods to Override
//- (void)prepareLayout
//{
//    [super prepareLayout];
//    
//    NSInteger itemCount = [[self collectionView] numberOfItemsInSection:0];
//    self.itemAttributes = [NSMutableArray arrayWithCapacity:itemCount];
//    
//    CGFloat xOffset = self.sectionInset.left;
//    CGFloat yOffset = self.sectionInset.top;
//    CGFloat xNextOffset = self.sectionInset.left;
//    for (NSInteger idx = 0; idx < itemCount; idx++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
//        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
//        
//        xNextOffset+=(self.minimumInteritemSpacing + itemSize.width);
//        if (xNextOffset > [self collectionView].bounds.size.width - self.sectionInset.right) {
//            xOffset = self.sectionInset.left;
//            xNextOffset = (self.sectionInset.left + self.minimumInteritemSpacing + itemSize.width);
//            yOffset += (itemSize.height + self.minimumLineSpacing);
//        }
//        else
//        {
//            xOffset = xNextOffset - (self.minimumInteritemSpacing + itemSize.width);
//        }
//        
//        UICollectionViewLayoutAttributes *layoutAttributes =
//        [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//        
//        layoutAttributes.frame = CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height);
//        [_itemAttributes addObject:layoutAttributes];
//    }
//}

//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    // 获取系统帮我们计算好的Attributes
//    NSArray *answer = [super layoutAttributesForElementsInRect:rect];
//    
//    // 遍历结果
//    for(int i = 1; i < [answer count]; ++i) {
//        
//        // 获取cell的Attribute，根据上一个cell获取最大的x，定义为origin
//        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
//        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
//        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
//        
//        // 设置cell最大间距
//        NSInteger maximumSpacing = 15;
//        
//        // 若当前cell和precell在同一行：①判断当前的cell加间距后的最大宽度是否小于ContentSize的宽度，②判断当前cell的x是否大于precell的x（否则cell会出现重叠）
//        
//        //满足则给当前cell的frame属性赋值（不满足的cell会根据系统布局换行）
//        CGRect frame = currentLayoutAttributes.frame;
//        frame.origin.x = origin + maximumSpacing;
//        currentLayoutAttributes.frame = frame;
//    }
//    return answer;
//}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    for (int i=0; i < attributes.count; i++) {
        
        UICollectionViewLayoutAttributes *curAttr = attributes[i]; // 当前cell的位置信息
        if (i == 0) {
            //单独一行的cell的X轴从5开始
            CGRect frame = curAttr.frame;
            frame.origin.x = 10;
            curAttr.frame = frame;
            continue;
        }
        UICollectionViewLayoutAttributes *preAttr = attributes[i-1]; // 上一个cell 的位置信息
        // 下面这块代码是对于一行只有一个cell进行位置调整
        UICollectionViewLayoutAttributes *nextAttr = nil;//下一个cell 位置信息
        if (i+1 < attributes.count) {
            nextAttr = attributes[i+1];
        }
        if (nextAttr != nil){
            CGFloat preY = CGRectGetMaxY(preAttr.frame);
            CGFloat curY = CGRectGetMaxY(curAttr.frame);
            CGFloat nextY = CGRectGetMaxY(nextAttr.frame);
            //根据cell的Y轴位置来判断cell是否是单独一行
            if (curY > preY&&curY < nextY) {
                //这个判断方式也会对区头进行判断 如果是区头则X轴还是从0开始
                if ([curAttr.representedElementKind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
                    CGRect frame = curAttr.frame;
                    frame.origin.x = 0;
                    curAttr.frame = frame;
                } else {
                    //单独一行的cell的X轴从5开始
                    CGRect frame = curAttr.frame;
                    frame.origin.x = 10;
                    curAttr.frame = frame;
                }
            }
        } else {
            CGFloat preY = CGRectGetMaxY(preAttr.frame);
            CGFloat curY = CGRectGetMaxY(curAttr.frame);
            if (preY != curY) {
                //单独一行的cell的X轴从5开始
                CGRect frame = curAttr.frame;
                frame.origin.x = 10;
                curAttr.frame = frame;
            }
        }
        //下面是对一行多个cell的间距进行调整
        CGFloat origin = CGRectGetMaxX(preAttr.frame);
        CGFloat targetX = origin + self.minimumInteritemSpacing;
        if (CGRectGetMinX(curAttr.frame) > targetX){
            //如果下一个cell换行了则不进行调整
            if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionViewContentSize.width) {
                CGRect frame = curAttr.frame;
                frame.origin.x = targetX;
                curAttr.frame = frame;
            }
        }
        
        
    }
    
    return attributes;
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return (self.itemAttributes)[indexPath.item];
//}

//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    return [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
//        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
//    }]];
//}

//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return NO;
//}
@end
