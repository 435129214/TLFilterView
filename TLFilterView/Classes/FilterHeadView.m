//
//  FilterHeadView.m
//  UnicomApp3
//
//  Created by Jack on 2018/4/26.
//

#import "FilterHeadView.h"
#import "FilterTableViewCell.h"
#import "FilterSectionView.h"

#import "Children.h"

@interface FilterHeadView()
{
    
}

@property (nonatomic, strong) NSMutableArray *sectionArr;
@property (nonatomic, strong) NSMutableArray *cellArr;

@end

@implementation FilterHeadView

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
        //        self.backgroundColor = [UIColor blueColor];
        
    }
    return self;
}

-(void) setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    
    if([self.dataArr count] == 0)
        return;
    
    self.sectionArr = [NSMutableArray arrayWithCapacity:[dataArr count]];
    self.cellArr = [NSMutableArray arrayWithCapacity:[dataArr count]];
    
    CGFloat posY = 40;
    int index = 0;
    for(NSDictionary *dic in dataArr)
    {
        NSArray *arr = [dic objectForKey:@"data"];
        
        FilterSectionView *section = [[FilterSectionView alloc] initWithFrame:CGRectMake(0, posY, self.width, 40)];
        section.typeName.text = [dic objectForKey:@"title"];
        [self addSubview:section];
        [self.sectionArr addObject:section];
        posY += 40;
        
        CGFloat cellH = ([arr count] + 2)/3 * 35;
        
        FilterTableViewCell *cell =  [[FilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.frame = CGRectMake(0, posY, self.width, cellH);
        [self addSubview:cell];
        posY += cellH;
        [cell setFilterDataArr:arr];
        cell.isMulSelected = [[dic objectForKey:@"multi"] boolValue];
        cell.dataDic = @{@"section":@(index),@"multi":@(cell.isMulSelected)};
        
        [self.cellArr addObject:cell];
        
        @weakify_self;
        cell.ClickItem = ^(id item, NSDictionary *dic) {
            @strongify_self  @if_self_is_nil_return;
            if(dic != nil && ![[dic objectForKey:@"multi"] boolValue])//单选时才显示名称，多选时不显示
            {
                FilterSectionView *section = [self.sectionArr objectAtIndex:[[dic objectForKey:@"section"] intValue]];
                section.chooseName.text = ((Children *)item).name;
            }
            
            if(self.SendOutClickItem)
            {
                self.SendOutClickItem(item);
            }
        };
        
        ++index;
    }
    
    self.frame = CGRectMake(0, 0, self.width, posY);
}

-(void) ResetAllSelectState
{
    for(FilterSectionView *section in self.sectionArr)
    {
        section.chooseName.text = @"";
    }
    
    for(FilterTableViewCell *cell in self.cellArr)
    {
        [cell ResetChoose:YES];
    }
    
    NSArray *arr = [self.dataArr.firstObject objectForKey:@"data"];
    Children *child = arr.firstObject;
    
    //假如是全部的话
//    if([child.name isEqualToString:@"全部"])
    {
        child.selected = YES;
        
        FilterTableViewCell *firCell = self.cellArr.firstObject;
        [firCell setFilterDataArr:arr];
    }
    
}

-(NSDictionary *)GetNeedPara
{
    NSMutableDictionary *dic =  [NSMutableDictionary dictionaryWithCapacity:5];
    
    
    for(int i = 0; i < [self.dataArr count];++i)
    {
        NSDictionary *tmpDic = [self.dataArr objectAtIndex:i];
        
        FilterTableViewCell *cell = [self.cellArr objectAtIndex:i];
        //注意，多选时，selectItem是个数组，单独时是一个child
        id selectItem = [cell GetChooseItem];
        if(selectItem != nil)
        {
            [dic setObject:selectItem forKey:[tmpDic objectForKey:@"type"]];
        }
    }
    
    if([[dic allKeys] count] == 0)
        return nil;
    
    return dic;
}

@end
