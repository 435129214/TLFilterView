//
//  TLViewController.m
//  TLFilterView
//
//  Created by 435129214@qq.com on 10/28/2019.
//  Copyright (c) 2019 435129214@qq.com. All rights reserved.
//

#import "TLViewController.h"
#import <TLFilterView/Children.h>
#import <TLFilterViewHeader.h>

@interface TLViewController ()

@end

@implementation TLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [FilterConfigure shareInstance].showType = FilterData_Dynamic;
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:10];
    for(int i = 0; i < 10;++i){
        Children *child = [[Children alloc] init];
        
        child.childrenIdentifier = i;
        child.name = [NSString stringWithFormat:@"序号序号序号序号：%d",i];
        [tmpArr addObject:child];
    }
    [self appendDataArr:tmpArr sectionTitle:@"状态"];
    
    NSMutableArray *tmpArr1 = [NSMutableArray arrayWithCapacity:10];
       for(int i = 0; i < 10;++i){
           Children *child = [[Children alloc] init];
           
           child.childrenIdentifier = i;
           child.name = [NSString stringWithFormat:@"序号：1%d",i];
           [tmpArr1 addObject:child];
       }
    [self appendDataArr:tmpArr1 sectionTitle:@"拉速度发水电费"];
    
    
    self.DoFilter = ^(NSDictionary * _Nonnull dic) {
        NSLog(@"选择的：%@",dic);
    };
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
