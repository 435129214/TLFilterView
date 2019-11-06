//
//  TLFilterViewController.m
//  Masonry
//
//  Created by liyanlei1 on 2019/10/28.
//

#import "TLFilterViewController.h"

#import "FilterTableViewCell.h"
#import "FilterSectionView.h"
#import "FilterFootView.h"
#import "FilterHeadView.h"
#import "FilterConfigure.h"
#import <Masonry/Masonry.h>
#import "Children.h"

@interface TLFilterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL footerHide;
    
    NSInteger sectionNum;

    FilterFootView *footView;
    FilterHeadView *headView;
}

@property(nonatomic, strong)   NSMutableArray *dataArr;
@property(nonatomic, strong) NSString *searchText;

@property(nonatomic, strong) NSArray *headerDataArr;

@property(nonatomic, assign) CGFloat leftW;//左侧距离


@end

@implementation TLFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self initView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) initData
{
    sectionNum = 0;
    self.leftW = [FilterConfigure shareInstance].leftW;
    
    self.dataArr = [NSMutableArray arrayWithCapacity:10];
}

-(void) setFootDataArr:(NSArray *)footDataArr
{
    _footDataArr = footDataArr;
    
    footView = [[FilterFootView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - self.leftW, 75)];
    footView.dataArr = footDataArr;
    
    footView.frame = footView.bounds;
    
    self.myTableView.tableFooterView = footView;
}

-(void) setHeaderDataArr:(NSArray *)headerDataArr
{
    _headerDataArr = headerDataArr;
    
    headView = [[FilterHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - self.leftW, 75)];
    headView.dataArr = headerDataArr;
    
    headView.frame = headView.bounds;
   
    @weakify_self
    headView.SendOutClickItem = ^(id item) {
        @strongify_self  @if_self_is_nil_return;

    };
    
    self.myTableView.tableHeaderView = headView;
}

-(UIView *)bottomView
{
    if(!_bottomView){
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.view);
            make.left.equalTo(self.view).offset(self.leftW);
            make.height.mas_equalTo(50);
        }];
        
        UIView *line = [[UIView alloc] init];
        [_bottomView addSubview:line];
        
        line.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(_bottomView);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return _bottomView;
}

- (UITableView *)myTableView {
    if (!_myTableView) {
        CGFloat tableY = 0;
    
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableY, self.view.bounds.size.width, self.view.bounds.size.height - tableY)];
        _myTableView.estimatedRowHeight = 0;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor whiteColor];
        
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        } else {
            // Fallback on earlier versions
        }
        
        [self.view addSubview:_myTableView];
        
        [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topHeader.mas_bottom);
            make.bottom.equalTo(self.bottomView.mas_top);
            make.left.equalTo(self.view).offset(self.leftW);
            make.width.mas_equalTo([FilterConfigure shareInstance].contentWidth);
        }];
    }
    return _myTableView;
}

-(void) appendDataArr:(NSArray *)dataArr sectionTitle:(NSString *)title
{
        NSInteger sectionIndex = self.dataArr.count+1;
        NSDictionary *dic = [self GetNeedDictionaryWithSection:sectionIndex Data:dataArr Choose:@"" Parent:title];
        [self.dataArr addObject:dic];
    
        sectionNum = self.dataArr.count;
        [self.myTableView reloadData];
}

-(void) insertDataArr:(NSArray *)dataArr sectionTitle:(NSString *)title at:(NSInteger)at
{
    //如果插入位置不合理，返回
    if(self.dataArr.count < at){
        return;
    }
    
    NSInteger sectionIndex = at + 1;
    NSDictionary *dic = [self GetNeedDictionaryWithSection:sectionIndex Data:dataArr Choose:@"" Parent:title];
    [self.dataArr insertObject:dic atIndex:at];
    
    NSInteger index = 0;
    //循环修改旧数据的section下标
    for(NSMutableDictionary *tmpDic in self.dataArr){
        [tmpDic setValue:@(index) forKey:@"section"];
    }
    
    sectionNum = self.dataArr.count;
    [self.myTableView reloadData];
}


-(NSMutableDictionary *) GetNeedDictionaryWithSection:(NSInteger)section Data:(NSArray *)arr Choose:(NSString *)choose Parent:(NSString *)parent
{
     NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys: @"1",@"show",[NSArray array],@"data",@"",@"section",nil];
    
    if([arr count] > 0)
    {
        [dic setObject:arr forKey:@"data"];
    }
    else{
        [dic setObject:@"0" forKey:@"show"];
    }
    
    [dic setObject:[NSNumber numberWithInteger:section] forKey:@"section"];
    
    if(parent != nil)
        [dic setObject:parent forKey:@"parent"];
    
    if(choose != nil)
        [dic setObject:choose forKey:@"choose"];
    
    return dic;
}

-(void) initView
{
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.leftW, self.view.height)];
    leftView.backgroundColor = [UIColor blackColor];
    leftView.alpha = 0.2;
    [self.view addSubview:leftView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(HideMySelf)];
    [leftView addGestureRecognizer:tap];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(self.leftW, 0, self.view.width-self.leftW, self.view.height - 40)];
    rightView.backgroundColor = [UIColor whiteColor];
    self.myTableView.backgroundView = rightView;
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] init];
    [gesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [gesture addTarget:self action:@selector(HideMySelf)];
    [self.view addGestureRecognizer:gesture];
    
    self.resetBt.hidden = NO;
    self.sureBt.hidden = NO;
}

-(UIView *)topHeader
{
    if(!_topHeader){
        _topHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.myTableView.width, 30)];
        [self.view addSubview:_topHeader];
        
        _topHeader.backgroundColor = [UIColor whiteColor];
        
    }
    return _topHeader;
}

-(UIButton *) resetBt{
    if(!_resetBt){
        float btW = (self.view.width - self.leftW)/2;
           _resetBt = [UIButton buttonWithType:UIButtonTypeCustom];
           [self.bottomView addSubview:_resetBt];
        
           _resetBt.frame = CGRectMake(7, 5, btW, 40);
           [_resetBt setTitle:@"重置" forState:UIControlStateNormal];
           //    [resetBt moocGrayStyle];
           [_resetBt setTitleColor:[FilterConfigure shareInstance].resetTextColor forState:UIControlStateNormal];
           [_resetBt addTarget:self action:@selector(ResetBtClick) forControlEvents:UIControlEventTouchUpInside];
           _resetBt.backgroundColor = [FilterConfigure shareInstance].resetBgColor;
        
           _resetBt.titleLabel.font = [UIFont systemFontOfSize:16];
           //添加阴影效果
           _resetBt.layer.shadowColor = [UIColor lightGrayColor].CGColor;
           _resetBt.layer.shadowOffset = CGSizeMake(0, 0.5);
           _resetBt.layer.shadowOpacity = 0.3;
        
        [_resetBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).offset(10);
            make.right.equalTo(self.bottomView.mas_centerX).offset(-5);
            make.top.equalTo(self.bottomView).offset(10);
            make.height.mas_equalTo(30);
        }];
    }
    return _resetBt;
}

-(UIButton*) sureBt{
    if(!_sureBt){
        _sureBt = [UIButton buttonWithType:UIButtonTypeCustom];
       [self.bottomView addSubview:_sureBt];
       
        float btW = (self.view.width - self.leftW)/2;
       _sureBt.frame = CGRectMake(self.resetBt.right, 5, btW, 40);
       [_sureBt setTitle:@"确定" forState:UIControlStateNormal];
       [_sureBt addTarget:self action:@selector(SureBtClick) forControlEvents:UIControlEventTouchUpInside];
       _sureBt.backgroundColor = [FilterConfigure shareInstance].ensureBgColor;
       [_sureBt setTitleColor:[FilterConfigure shareInstance].ensureTextColor forState:UIControlStateNormal];
       //添加阴影效果
       _sureBt.layer.shadowColor = [UIColor lightGrayColor].CGColor;
       _sureBt.layer.shadowOffset = CGSizeMake(0, 0.5);
       _sureBt.layer.shadowOpacity = 0.3;
       _sureBt.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_sureBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView.mas_centerX).offset(5);
            make.right.equalTo(self.bottomView).offset(-10);
            make.top.equalTo(self.bottomView).offset(10);
            make.height.mas_equalTo(30);
        }];
    }
    return _sureBt;
}

-(void) HideFooterView:(UIButton *)btn
{
    footerHide = !footerHide;
    
    if(footerHide)
    {
        [btn setImage:[UIImage imageNamed:@"图层-21-展"] forState:UIControlStateNormal];
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"图层-21-拷贝"] forState:UIControlStateNormal];
    }
}

-(void) HideMySelf
{
      if(self.openRemoveFlag){
    [UIView animateWithDuration:0.33 animations:^{
          self.view.frame = CGRectMake(self.view.width, self.view.y, self.view.width, self.view.height);
      } completion:^(BOOL finished) {
          self.view.frame = CGRectMake(0, self.view.y, self.view.width, self.view.height);
          [self.view removeFromSuperview];
      }];
      }
}

-(void) ResetBtClick
{
    for(int i=0;i < sectionNum;++i)
    {
        FilterTableViewCell *cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        [cell ResetChoose:YES];
    }
    
    [headView ResetAllSelectState];
    [footView ResetAllSelectState];
    
    //清空标题
//    for(NSDictionary *dic in self.dataArr)
//    {
//        [dic setValue:@"" forKey:@"choose"];
//
//        if([[dic objectForKey:@"section"] intValue] == 1)
//        {
//            continue;
//        }
//        else
//        {
//            [dic setValue:@"" forKey:@"parent"];
//        }
//    }


    [self.myTableView reloadData];
}

//-(FilterSearchView *)searchView
//{
//    if(!_searchView)
//    {
//        _searchView = [[FilterSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - leftW, 120)];
//        self.myTableView.tableHeaderView = _searchView;
//
//         @weakify_self
//        _searchView.SearchClick = ^(NSString *text) {
//            @strongify_self  @if_self_is_nil_return;
//            self.searchText = text;
//            [self DoSearch];
//        };
//    }
//    return _searchView;
//}

-(void) SureBtClick
{
    [self HideMySelf];

    if(footView == nil)//没有footView时
    {
        NSDictionary *selectDic  = [self GetNetRequestAreaChoose];
        
        {
            if(headView == nil)
            {
                if(self.DoFilter){
                    self.DoFilter(selectDic);
                }
            }
            else{
                if(self.DoMoreFilterParam){
                    self.DoMoreFilterParam(selectDic, [headView GetNeedPara], [footView GetNeedPara]);
                }
            }
        }
    }
    else
    {
        if(footView != nil)
        {
            NSDictionary *selectDic  = [self GetNetRequestAreaChoose];
//            if(headView == nil)
//            {
//                if(self.DoExtentFilterParam){
//                    self.DoExtentFilterParam(selectID,[footView GetNeedPara]);
//                }
//            }
//            else{
            
                if(self.DoMoreFilterParam){
                    self.DoMoreFilterParam(selectDic, [headView GetNeedPara], [footView GetNeedPara]);
                }
//            }
        }
    }

}

-(NSDictionary *)GetNetRequestAreaChoose{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    if(sectionNum != 0)
    {
        for(int i=0;i < sectionNum;++i)
        {
            NSMutableDictionary *cDic = [NSMutableDictionary dictionaryWithDictionary:self.dataArr[i]];
            
            NSString *indexStr = [NSString stringWithFormat:@"index:%d",i];
            [mDic setObject:cDic forKey:indexStr];
            //data是全部数据，移除吧
            [cDic removeObjectForKey:@"data"];
            FilterTableViewCell *cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
            id item = [cell GetChooseItem];
            if(item == nil)
            {
                continue;
            }
            else
            {
                if([item isKindOfClass:[Children class]])
                {
                    [cDic setObject:[item dictionaryRepresentation] forKey:@"chooseItem"];
                }
                else{
                    [cDic setObject:item forKey:@"chooseItem"];
                }
            }
        }
    }
    
    return mDic;
}


#pragma mark tableViewDelegate

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellH = 0;
    
    NSArray *arr = [[self.dataArr objectAtIndex:indexPath.section] objectForKey:@"data"];
    
    if([arr count] > 0)
    {
        cellH = (([arr count] + 2)/3)*35;
    }
    
    return cellH;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.noNetRequest)
        return 0;
    return sectionNum;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    
    if(self.noNetRequest)
        return row;
    
    BOOL show = [[[self.dataArr objectAtIndex:section] objectForKey:@"show"] boolValue];
    
    if(show)
        row = 1;
    
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString  *identifier = @"FilterTableViewCell";
    FilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
  
#if 1
    NSDictionary *tmpDic = [self.dataArr objectAtIndex:indexPath.section];
    
    cell.dataDic = tmpDic;
    
    NSArray *tmpArr  = [tmpDic objectForKey:@"data"];
    [cell setFilterDataArr:tmpArr];
    
    cell.ClickItem = ^(id item, NSDictionary *dic) {
        Children *child = (Children *)item;
        [dic setValue:child.name forKey:@"choose"];

        NSInteger section = [[dic objectForKey:@"section"] intValue];
        if([child.children count] > 0)
        {
            self->sectionNum = section + 1;
            
            NSDictionary *getDic = [self GetNeedDictionaryWithSection:self->sectionNum Data:child.children Choose:@"" Parent:child.name];
            [self.dataArr insertObject:getDic atIndex:self->sectionNum -1];
        }
//        else
//        {
//            self->sectionNum = section;
//        }
        [self.myTableView reloadData];
    };
   
#endif

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FilterSectionView *sectionView = [[FilterSectionView alloc] initWithFrame:CGRectMake(0, 0, self.leftW, 40)];
    
    NSDictionary *dic = [self.dataArr objectAtIndex:section];
    
    sectionView.typeName.text = [dic objectForKey:@"parent"];
    
    if([FilterConfigure shareInstance].showSectionChooseText){
        sectionView.chooseName.text =  [dic objectForKey:@"choose"];
    }
    
    BOOL show =  [[dic objectForKey:@"show"] boolValue];
    [sectionView SetOpen:show];
    
    
    sectionView.openBtn.tag = section;
    [sectionView.openBtn addTarget:self action:@selector(HideSection:) forControlEvents:UIControlEventTouchUpInside];
    
    return sectionView;
}


-(void) HideSection:(UIButton *)btn
{
    NSDictionary *dic = [self.dataArr objectAtIndex:btn.tag];
    
    BOOL show =  [[dic objectForKey:@"show"] boolValue];
  
    [dic setValue:[NSNumber numberWithBool:!show] forKey:@"show"];
    
    [self.myTableView reloadData];
}

-(NSInteger) GetRow:(BOOL) sectionHide
{
    if (!sectionHide) {
        return 1;
    }
    
    return 0;
}

@end
