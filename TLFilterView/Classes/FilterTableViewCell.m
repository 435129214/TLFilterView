//
//  FilterTableViewCell.m
//  NewFrameTest
//
//  Created by liyanlei on 2017/5/26.
//  Copyright © 2017年 szg. All rights reserved.
//

#import "FilterTableViewCell.h"
#import "Children.h"

//#import "MarketSchoolCategory.h"
//#import "SpecialChildren.h"

@implementation FilterTableViewCell
{
    Children *selectItem;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(TLEqualSpaceFlowLayout *)flowLayout
{
    if(!_flowLayout){
        _flowLayout = [[TLEqualSpaceFlowLayout alloc] init];
        _flowLayout.delegate =self;
    }
    return _flowLayout;
}


-(void) setFilterDataArr:(NSArray *)filterDataArr
{
    if([_filterDataArr isEqual:filterDataArr]){
           if([FilterConfigure shareInstance].showType == FilterData_Equal){
               NSInteger row = ([filterDataArr count] + 2)/3;
               CGFloat Height = row*35;
               filterCollectionView.frame = CGRectMake(0, 0,[FilterConfigure shareInstance].contentWidth, Height);
               [filterCollectionView reloadData];
           }
           else{
               [self updateCollectionFrame];
           }
        return;
    }
    _filterDataArr = filterDataArr;
    
   if([FilterConfigure shareInstance].showType == FilterData_Equal){
      NSInteger row = ([filterDataArr count] + 2)/3;
      CGFloat Height = row*35;
      if(filterCollectionView == nil)
      {
          // 创建流式布局 设置垂直滚动
          UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
          layout.scrollDirection = UICollectionViewScrollDirectionVertical;
          layout.minimumInteritemSpacing = 0.0;
          layout.minimumLineSpacing = 0.0;
          CGFloat itempW = ([FilterConfigure shareInstance].contentWidth - 0.75)/3.0;// 多减去0.5 和内缩0.25是为了去除cell的分割线重叠效果
          layout.itemSize = CGSizeMake(itempW, 35);
          layout.sectionInset = UIEdgeInsetsMake(0.25, 0.25, 0, 0);
          //    layout.headerReferenceSize = CGSizeMake(self.view.width, 150);
          
          filterCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [FilterConfigure shareInstance].contentWidth, Height) collectionViewLayout:layout];
          filterCollectionView.delegate = self;
          filterCollectionView.dataSource = self;
          filterCollectionView.alwaysBounceVertical = YES;
          filterCollectionView.backgroundColor = [UIColor whiteColor];
          filterCollectionView.scrollEnabled = NO;
          [self addSubview:filterCollectionView];
          
          
          [filterCollectionView registerClass:[FilterCollectionCell class] forCellWithReuseIdentifier:@"FilterCollectionCell"];
      }
      else{
          filterCollectionView.frame = CGRectMake(0, 0,[FilterConfigure shareInstance].contentWidth, Height);
          [filterCollectionView reloadData];
      }
      
      }
   else{
       if(filterCollectionView == nil){
                filterCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40) collectionViewLayout:self.flowLayout];
             [self addSubview:filterCollectionView];
           
           filterCollectionView.scrollEnabled = NO;
             filterCollectionView.dataSource = self;
             filterCollectionView.delegate = self;
             
             [filterCollectionView registerClass:[FilterCollectionCell class] forCellWithReuseIdentifier:@"FilterCollectionCell"];
             
             filterCollectionView.backgroundColor = [UIColor whiteColor];

        }
       else{
            [self updateCollectionFrame];
       }
   }
}

-(void) updateCollectionFrame
{
    CGSize size = filterCollectionView.contentSize;
              
    CGFloat Height = size.height > 40?size.height:40;
              
            
    filterCollectionView.frame = CGRectMake(0, 0,[FilterConfigure shareInstance].contentWidth, Height);
           
    [filterCollectionView reloadData];
    
    self.height = Height;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _filterDataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCollectionCell *cell = (FilterCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCollectionCell" forIndexPath:indexPath];

    id item = [_filterDataArr objectAtIndex:indexPath.row];
    
    {//多选时
        Children *children = item;
        if(children.selected)
        {
            selectItem = item;
            [cell setStyle:YES text:children.name];
        }
        else
        {
            [cell setStyle:NO text:children.name];
        }
    }
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate 点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Children *item = [_filterDataArr objectAtIndex:indexPath.row];
    
    FilterCollectionCell *newCell = (FilterCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //不可点击的状态直接返回
    if (!newCell.enable) {
        return;
    }
    
    if(!self.isMulSelected)//单选
    {
        if(item.selected)
        {
            //不允许取消选择
            if(item.fobitDeSelected)
                return;
            
            item.selected = NO;
            selectItem = nil;
            
            if(self.ClickItem)
            {
                self.ClickItem(selectItem,self.dataDic);
            }
        }
        else{
            if(![item.name isEqualToString:@"切换单位"]){
                item.selected = YES;
                selectItem.selected = NO;
                
                selectItem = item;
                
                if(self.ClickItem)
                {
                    self.ClickItem(selectItem,self.dataDic);
                }
            }
            else{
                //特殊情况，不需要传值
                if(self.ClickItem)
                {
                    self.ClickItem(item,nil);
                }
            }
        }
       
        [collectionView reloadData];
    }
    else{//多选
        BOOL find = NO;
        
        Children *sItem = (Children *)item;
        for(Children *tItem in self.chooseArr)
        {
            if ([sItem isEqual:tItem]) {
                find =  YES;
                
                sItem.selected = NO;
                
                [self.chooseArr removeObject:item];
                
                break;
            }
        }
        
        if (!find) {
            sItem.selected = YES;
            [self.chooseArr addObject:item];
        }
        
        if(self.ClickItem)
        {
            self.ClickItem(self.chooseArr,self.dataDic);
        }
        
        [collectionView reloadData];
    }
}

-(void) setIsMulSelected:(BOOL)isMulSelected{
    _isMulSelected = isMulSelected;
    
    self.chooseArr = [NSMutableArray arrayWithCapacity:4];
}

-(id) GetChooseItem
{
    if(!_isMulSelected)
    {
        if (selectItem == nil) {
            return nil;
        }
        
        return selectItem;
    }
    else{
        return self.chooseArr;
    }
}

-(void) ResetChoose:(BOOL) reset
{
    if(reset)
    {
        selectItem.selected = NO;
        selectItem = nil;
        
        for(Children *child in self.chooseArr)
        {
            child.selected = NO;
        }
        
        //把全部给弄出来，全部一直是默认
        for(Children *child in self.filterDataArr){
            if([child.name isEqualToString:@"全部"])
            {
                child.selected = YES;
            }
        }
        
        [self.chooseArr removeAllObjects];
        
        [filterCollectionView reloadData];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if([FilterConfigure shareInstance].showType == FilterData_Equal){
        CGFloat itempW = ([FilterConfigure shareInstance].contentWidth - 0.75)/3.0;// 多减去0.5 和内缩0.25是为了去除cell的分割线重叠效果
        CGSize itemSize = CGSizeMake(itempW, 35);
        
        return itemSize;
    }
    else{
        Children *item = [_filterDataArr objectAtIndex:indexPath.row];
        CGSize fontSize = [self fontSize:item.name fontsize:14.f contentSize:CGSizeMake(MAXFLOAT, 18)];
        fontSize.height = 35;
        fontSize.width += 40;
        
        return fontSize;
    }
}

-(CGSize)fontSize:(NSString*)aString fontsize:(CGFloat)fontSize contentSize:(CGSize)size{
    if(![aString isKindOfClass:[NSString class]])
        return CGSizeZero;
    
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:(CGFloat)fontSize],NSKernAttributeName:@(0.2)};
    size =[aString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

@end
