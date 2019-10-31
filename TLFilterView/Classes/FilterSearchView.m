//
//  FilterSearchView.m
//  UnicomApp3
//
//  Created by Jack on 2018/1/25.
//

#import "FilterSearchView.h"

@implementation FilterSearchView

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
        self.title.text = @"标题";
        self.searchField.hidden = NO;
    }
    return self;
}


-(UILabel *)title
{
    if(!_title)
    {
        _title = [[UILabel alloc] init];
        [self addSubview:_title];
        
        _title.font = [UIFont systemFontOfSize:16];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(50);
            make.height.mas_equalTo(20);
        }];
    }
    
    return _title;
}


-(UITextField *)searchField
{
    if(!_searchField)
    {
        UIView *bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_left);
            make.top.equalTo(self.title.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.mas_equalTo(30);
        }];
        bgView.layer.cornerRadius = 5;
        bgView.layer.borderWidth = 0.5;
        bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = [UIColor whiteColor];
        
        _searchField = [[UITextField alloc] init];
        [bgView addSubview:_searchField];
        [_searchField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView.mas_left);
            make.top.equalTo(bgView.mas_top);
            make.right.equalTo(bgView.mas_right).offset(-20);
            make.height.mas_equalTo(30);
        }];
        _searchField.placeholder = @"请输入关键字";
        //        _searchField.textAlignment = NSTextAlignmentCenter;
        _searchField.font = [UIFont systemFontOfSize:12];
        _searchField.delegate = self;
        CGRect frame = _searchField.frame;
        frame.size.width = 6;
        UIView *leftview = [[UIView alloc] initWithFrame:frame];
        _searchField.leftViewMode = UITextFieldViewModeAlways;
        _searchField.leftView = leftview;
        _searchField.returnKeyType = UIReturnKeySearch;
        
        
       UIImageView *searchImg = [[UIImageView alloc] init];
        [bgView addSubview:searchImg];
        [searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView.mas_right).offset(-18);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.centerY.equalTo(bgView.mas_centerY);
        }];
        searchImg.image = [UIImage imageNamed:@"搜索灰色"];
        searchImg.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(DoSearch)];
        [searchImg addGestureRecognizer:tap];
    }
    return _searchField;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self DoSearch];
    return YES;
}

-(void) DoSearch
{
    [self.searchField resignFirstResponder];
    if(self.SearchClick)
    {
        self.SearchClick(self.searchField.text);
    }
}


@end
